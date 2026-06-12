import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The central typography and color design system for the application.
///
/// [AppTheme] establishes a cohesive visual language using the Plus Jakarta Sans
/// font family. It implements a robust, programmatic typography scaling engine 
/// that dynamically adjusts font sizes based on the device's screen width, 
/// ensuring optimal readability across mobile, tablet, and desktop viewports.
class AppTheme {
  
  /// The primary brand accent color.
  static const Color pureBlue = Color(0xFF0000FF);
  
  /// The universal background color, providing high contrast for dark mode.
  static const Color pureBlack = Color(0xFF000000);
  
  /// The primary color for high-emphasis text (e.g., headings, active states).
  static const Color textMain = Color(0xFFFFFFFF);
  
  /// The secondary color for low-emphasis text (e.g., body paragraphs, subtitles).
  static const Color textMuted = Color(0xFFA0AABF);

  /// A dynamic typography scaling engine.
  ///
  /// Calculates the optimal font size based on the current viewport [width].
  /// To prevent text from blowing up uncomfortably on ultra-wide desktop monitors 
  /// or tablets, it caps the scaling calculation at a maximum width of 800 logical pixels.
  static double scaleText(double width, double mobileSize) {
    double safeWidth = width > 800 ? 800 : width; // Caps scaling to prevent tablet overflow
    if (safeWidth >= 800) return mobileSize * 1.15;
    if (safeWidth > 600) return mobileSize * 1.10;
    return mobileSize;
  }

  /// Typography style intended for top-level navigation bars and critical headers.
  /// 
  /// Features aggressive tracking (letter spacing) for a premium, cinematic feel.
  static TextStyle navTitle(double width) => GoogleFonts.plusJakartaSans(
    color: textMain,
    fontSize: scaleText(width, 20),
    fontWeight: FontWeight.w900,
    letterSpacing: 6.0,
  );

  /// Typography style intended for hero sections and massive, page-defining titles.
  /// 
  /// Features tight tracking and compressed line-height for punchy, impactful aesthetics.
  static TextStyle display(double width) => GoogleFonts.plusJakartaSans(
    color: textMain,
    fontSize: scaleText(width, 38),
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
    height: 1.15,
  );

  /// Typography style intended for standard section headers and card titles.
  static TextStyle heading(double width) => GoogleFonts.plusJakartaSans(
    color: textMain,
    fontSize: scaleText(width, 18),
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  /// Typography style intended for standard paragraph content and general readability.
  static TextStyle bodyText(double width) => GoogleFonts.plusJakartaSans(
    color: textMuted,
    fontSize: scaleText(width, 15),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  /// Typography style intended for small, high-contrast UI elements like tags and badges.
  /// 
  /// Allows injecting a custom [color] to match the specific accent of the surrounding UI.
  static TextStyle badgeText(double width, Color color) => GoogleFonts.plusJakartaSans(
    color: color,
    fontSize: scaleText(width, 12),
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2,
  );
}
