import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';
import 'shared_widgets.dart';
import 'homescreen.dart';

/// A comprehensive authentication screen handling both user login and registration.
/// 
/// Integrates Firebase Authentication for state management and SharedPreferences 
/// for persisting "Remember Me" credentials. Features a responsive, glassmorphism 
/// UI with entrance animations.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  // State variables determining the current UI mode and processing state
  bool _isLogin = true;
  bool _isLoading = false;
  bool _rememberMe = false;

  // Controllers for text input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Animation controllers for screen entrance effects
  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations for a smooth fade and slide-up entrance
    _entranceController = AnimationController(
        vsync: this, 
        duration: const Duration(milliseconds: 800)
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _entranceController, curve: Curves.easeOut)
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
        CurvedAnimation(parent: _entranceController, curve: Curves.easeOutQuart)
    );

    _entranceController.forward();
    _loadRememberMe();
  }

  /// Retrieves saved email and password credentials if "Remember Me" was previously checked.
  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember_me') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('saved_email') ?? '';
        _passwordController.text = prefs.getString('saved_password') ?? '';
      }
    });
  }

  /// Persists or clears credentials locally based on the "Remember Me" checkbox state.
  Future<void> _saveRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setBool('remember_me', true);
      await prefs.setString('saved_email', _emailController.text.trim());
      await prefs.setString('saved_password', _passwordController.text.trim());
    } else {
      await prefs.setBool('remember_me', false);
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handles the main submission logic for both Sign In and Sign Up workflows.
  Future<void> _submit() async {
    HapticFeedback.mediumImpact();
    FocusScope.of(context).unfocus(); // Dismiss the keyboard

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    // Basic client-side validation
    if (email.isEmpty || password.isEmpty || (!_isLogin && name.isEmpty)) {
      _showError('Please fill in all fields.');
      return;
    }
    if (password.length < 6) {
      _showError('Password must be at least 6 characters long.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isLogin) {
        // --- LOGIN FLOW ---
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, 
            password: password
        );
        await _saveRememberMe();
        HapticFeedback.lightImpact();
        
        if (mounted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen())
          );
        }
      } else {
        // --- REGISTRATION FLOW ---
        UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, 
            password: password
        );

        // Save name to FirebaseAuth directly as a primary fallback
        await cred.user!.updateDisplayName(name);

        // Attempt to save user profile data to Firestore.
        // Wrapped in try/catch to ensure missing/strict security rules won't break the UI flip.
        try {
          await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
            'name': name,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        } catch (e) {
          debugPrint("Firestore save warning: $e");
        }

        // Force sign out requiring the user to log in manually after creation
        await FirebaseAuth.instance.signOut();
        HapticFeedback.lightImpact();

        if (mounted) {
          _showSuccess('Account created successfully! Please sign in.');
          setState(() {
            _isLogin = true;
            _passwordController.clear();
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Authentication failed');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Triggers a Firebase password reset email to the currently entered email address.
  Future<void> _resetPassword() async {
    HapticFeedback.lightImpact();
    FocusScope.of(context).unfocus();
    
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showError('Please enter your email address first to reset your password.');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) {
        _showSuccess('Password reset link sent to your email!');
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Failed to send reset email');
    }
  }

  /// Displays a custom styled error SnackBar.
  void _showError(String message) {
    if (!mounted) return;
    HapticFeedback.heavyImpact();
    _passwordController.clear(); // Clear password for security on error

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        content: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF8A1A1A).withOpacity(0.95),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.redAccent.withOpacity(0.5), width: 1),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.white, size: 26),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  message,
                  style: AppTheme.bodyText(MediaQuery.of(context).size.width).copyWith(
                      color: Colors.white,
                      fontSize: AppTheme.scaleText(MediaQuery.of(context).size.width, 14),
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Displays a custom styled success SnackBar.
  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        content: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.green.shade800.withOpacity(0.95),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.greenAccent.withOpacity(0.5), width: 1),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 26),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  message,
                  style: AppTheme.bodyText(MediaQuery.of(context).size.width).copyWith(
                      color: Colors.white,
                      fontSize: AppTheme.scaleText(MediaQuery.of(context).size.width, 14),
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const Color brandAccent = Color(0xFF2E6BFF);

    return GestureDetector(
      // Ensure tapping outside of text fields dismisses the keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background Gradient Layer
            const SmoothGradientBackground(child: SizedBox.expand()),
            
            // Foreground Content Layer
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420), // Max width for tablet/desktop compatibility
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Glassmorphism Authentication Card
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                                          child: Container(
                                            padding: const EdgeInsets.all(36),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                                              color: Colors.white.withOpacity(0.04),
                                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 40, spreadRadius: -5)],
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Dynamic Header Text
                                                AnimatedSwitcher(
                                                  duration: const Duration(milliseconds: 300),
                                                  child: Text(
                                                    _isLogin ? 'Welcome Back' : 'Create Account',
                                                    key: ValueKey<bool>(_isLogin),
                                                    style: AppTheme.display(width).copyWith(
                                                        fontSize: AppTheme.scaleText(width, 32),
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: -0.5
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  _isLogin ? 'Sign in to access your dashboard' : 'Join the Scouts & Guides platform',
                                                  style: AppTheme.bodyText(width).copyWith(
                                                      fontSize: AppTheme.scaleText(width, 15),
                                                      color: Colors.white70
                                                  ),
                                                ),
                                                const SizedBox(height: 40),

                                                // Name Input Field (Only visible during Registration)
                                                AnimatedSize(
                                                  duration: const Duration(milliseconds: 300),
                                                  curve: Curves.easeOutQuart,
                                                  child: _isLogin
                                                      ? const SizedBox.shrink()
                                                      : Column(
                                                    children: [
                                                      _PremiumDynamicTextField(
                                                        controller: _nameController, hint: 'Full Name', icon: Icons.person_rounded, width: width, accentColor: brandAccent,
                                                        textInputAction: TextInputAction.next,
                                                      ),
                                                      const SizedBox(height: 16),
                                                    ],
                                                  ),
                                                ),

                                                // Email Input Field
                                                _PremiumDynamicTextField(
                                                  controller: _emailController, hint: 'Email Address', icon: Icons.mail_rounded, isEmail: true, width: width, accentColor: brandAccent,
                                                  textInputAction: TextInputAction.next,
                                                ),
                                                const SizedBox(height: 16),

                                                // Password Input Field
                                                _PremiumDynamicTextField(
                                                  controller: _passwordController, hint: 'Password', icon: Icons.lock_rounded, isPassword: true, width: width, accentColor: brandAccent,
                                                  textInputAction: TextInputAction.done,
                                                  onSubmitted: (_) => _submit(),
                                                ),
                                                const SizedBox(height: 16),

                                                // Remember Me & Forgot Password (Only visible during Login)
                                                if (_isLogin)
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 22, width: 22,
                                                            child: Checkbox(
                                                              value: _rememberMe,
                                                              onChanged: (val) {
                                                                HapticFeedback.selectionClick();
                                                                setState(() => _rememberMe = val ?? false);
                                                              },
                                                              activeColor: brandAccent,
                                                              checkColor: Colors.white,
                                                              side: BorderSide(color: Colors.white.withOpacity(0.5), width: 1.2),
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),
                                                          Text(
                                                              'Remember me',
                                                              style: AppTheme.bodyText(width).copyWith(
                                                                  fontSize: AppTheme.scaleText(width, 14),
                                                                  color: Colors.white70
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                      TextButton(
                                                        onPressed: _resetPassword,
                                                        style: TextButton.styleFrom(
                                                          padding: EdgeInsets.zero,
                                                          minimumSize: const Size(50, 30),
                                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                        ),
                                                        child: Text(
                                                          'Forgot Password?',
                                                          style: AppTheme.bodyText(width).copyWith(
                                                              fontSize: AppTheme.scaleText(width, 14),
                                                              color: const Color(0xFF6BB8FF),
                                                              fontWeight: FontWeight.w600
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                const SizedBox(height: 35),

                                                // Primary Action Button
                                                AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  height: 56,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30),
                                                    boxShadow: _isLoading ? [] : [
                                                      BoxShadow(color: brandAccent.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))
                                                    ],
                                                    gradient: const LinearGradient(
                                                      colors: [Color(0xFF2E6BFF), Color(0xFF093185)],
                                                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                                                    ),
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: _isLoading ? null : _submit,
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.transparent,
                                                      disabledBackgroundColor: Colors.transparent,
                                                      shadowColor: Colors.transparent,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30),
                                                        side: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
                                                      ),
                                                    ),
                                                    child: _isLoading
                                                        ? const SizedBox(
                                                      height: 24, width: 24,
                                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                                    )
                                                        : Text(
                                                      _isLogin ? 'Sign In' : 'Create Account',
                                                      style: AppTheme.heading(width).copyWith(
                                                          fontSize: AppTheme.scaleText(width, 18),
                                                          fontWeight: FontWeight.w800,
                                                          letterSpacing: 1,
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 25),

                                                // Toggle Login/Registration State
                                                GestureDetector(
                                                  onTap: () {
                                                    HapticFeedback.lightImpact();
                                                    FocusScope.of(context).unfocus();
                                                    setState(() {
                                                      _isLogin = !_isLogin;
                                                      _passwordController.clear();
                                                    });
                                                  },
                                                  child: Center(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: AppTheme.bodyText(width).copyWith(
                                                            fontSize: AppTheme.scaleText(width, 14),
                                                            color: Colors.white60
                                                        ),
                                                        children: [
                                                          TextSpan(text: _isLogin ? "Don't have an account? " : "Already have an account? "),
                                                          TextSpan(
                                                            text: _isLogin ? "Sign up" : "Sign in",
                                                            style: AppTheme.heading(width).copyWith(
                                                                fontSize: AppTheme.scaleText(width, 14),
                                                                color: const Color(0xFF6BB8FF),
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom, animated text field widget designed for premium UI experiences.
/// 
/// Automatically handles focus states, obscures text for passwords, and matches
/// the parent container's stylistic theme.
class _PremiumDynamicTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool isEmail;
  final double width;
  final Color accentColor;
  final TextInputAction textInputAction;
  final Function(String)? onSubmitted;

  const _PremiumDynamicTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.isEmail = false,
    required this.width,
    required this.accentColor,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  });

  @override
  State<_PremiumDynamicTextField> createState() => _PremiumDynamicTextFieldState();
}

class _PremiumDynamicTextFieldState extends State<_PremiumDynamicTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    
    // Listen to focus changes to trigger UI updates (e.g., border color changes)
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: _isFocused ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.03),
        border: Border.all(
          color: _isFocused ? widget.accentColor : Colors.white.withOpacity(0.08),
          width: 1.5,
        ),
        boxShadow: _isFocused
            ? [BoxShadow(color: widget.accentColor.withOpacity(0.2), blurRadius: 15, spreadRadius: 2)]
            : [],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _obscureText,
        keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onSubmitted,
        style: AppTheme.bodyText(widget.width).copyWith(
            color: Colors.white,
            fontSize: AppTheme.scaleText(widget.width, 16)
        ),
        cursorColor: const Color(0xFF6BB8FF),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: AppTheme.bodyText(widget.width).copyWith(
              color: Colors.white.withOpacity(0.4),
              fontSize: AppTheme.scaleText(widget.width, 16)
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Icon(
                widget.icon,
                color: _isFocused ? const Color(0xFF6BB8FF) : Colors.white.withOpacity(0.5),
                size: 24
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 65),

          // Visibility toggle button for password fields
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: Colors.white.withOpacity(0.4),
              size: 22,
            ),
            onPressed: () {
              HapticFeedback.selectionClick();
              setState(() => _obscureText = !_obscureText);
            },
          )
              : null,

          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}
