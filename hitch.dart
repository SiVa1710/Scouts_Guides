import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Hitches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HITCHES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          HitchItem(
            hitchImage: 'assets/icons/hitches.png',
            hitchName: 'CLOVE HITCH',
            hitchVideo: 'assets/videos/clovehitch.mp4',
            hitchDescription: Hitch1Description,
          ),
          SizedBox(height: 16.0),
          HitchItem(
            hitchImage: 'assets/icons/hitches.png',
            hitchName: 'ROUND TURN & TWO HALF',
            hitchVideo: 'assets/videos/roundturn2half.mp4',
            hitchDescription: Hitch2Description,
          ),
          SizedBox(height: 16.0),
          HitchItem(
            hitchImage: 'assets/icons/hitches.png',
            hitchName: 'TIMBER HITCH',
            hitchVideo: 'assets/videos/timberhitch.mp4',
            hitchDescription: Hitch3Description,
          ),
          SizedBox(height: 16.0),
          HitchItem(
            hitchImage: 'assets/icons/hitches.png',
            hitchName: 'ROLLING HITCH',
            hitchVideo: 'assets/videos/rollinghitch.mp4',
            hitchDescription: Hitch4Description,
          ),
          SizedBox(height: 16.0),
          HitchItem(
            hitchImage: 'assets/icons/hitches.png',
            hitchName: 'MARLINE SPIKE',
            hitchVideo: 'assets/videos/marlinspike.mp4',
            hitchDescription: Hitch5Description,
          ),
          SizedBox(height: 16.0),
          HitchItem(
            hitchImage: 'assets/icons/hitches.png',
            hitchName: 'DRAW HITCH',
            hitchVideo: 'assets/videos/highwaymans.mp4',
            hitchDescription: Hitch6Description,
          ), // Add more HitchItem widgets for each hitch
        ],
      ),
    );
  }
}

class HitchItem extends StatelessWidget {
  final String hitchImage;
  final String hitchName;
  final String hitchVideo;
  final String hitchDescription;

  HitchItem({
    this.hitchImage,
    this.hitchName,
    this.hitchVideo,
    this.hitchDescription,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFF0001cf),
          child: ListTile(
            leading: Image.asset(
              hitchImage,
              width: 30,
              height: 30,
            ),
            title: Text(
              hitchName,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayerWidget(videoPath: hitchVideo),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: hitchDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: screenWidth * 0.048,
                          fontFamily: 'Lora',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: Color(0xFF0001cf),
                          height: 1.5,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({Key key, this.videoPath}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      showControls: true,
      allowMuting: false,
      allowPlaybackSpeedChanging: true,
      allowFullScreen: false,
      aspectRatio: 16 / 9,
      // other options...
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Adjust the elevation as needed
      shadowColor: Colors.black, // Set the shadow color to black
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}

final String Hitch1Description = '''
#Uses: 
#
# • Securing a rope to a post, pole, or other object.
#
#Practical Use: 
#
# • Starting and finishing lashings, anchoring tents, or tying off loads in cargo handling.
''';

final String Hitch2Description = '''
#Uses: 
#
# • Creating a secure and reliable knot for tying a rope to an object.
#
#Practical Use: 
#
# • Anchoring boats, securing tents, or attaching lines to poles or rings in various settings.
''';

final String Hitch3Description = '''
#Uses: 
#
# • Attaching a rope to a cylindrical object, particularly when the object is being dragged or lifted.
#
#Practical Use: 
#
# • Logging operations, securing loads for transport, or constructing temporary structures.
''';

final String Hitch4Description = '''
#Uses: 
#
# • Attaching a rope to a cylindrical object, allowing it to move freely along the object's length.
#
#Practical Use: 
#
# • Securing a line to a spar or pole on a boat, adjusting tension on a line while sailing, or creating a temporary attachment point in rigging.
''';

final String Hitch5Description = '''
#Uses: 
#
# • Assisting in splicing and unlaying rope, and untying knots.
#
#Practical Use: 
#
# • In sailing, marlinespikes are used for tasks such as unlaying strands of rope for splicing or for untangling knots. They're also handy in camping and survival situations for various rope-related tasks.
''';

final String Hitch6Description = '''
#Uses: 
#
# •  Securing a rope to a post or stake with adjustable tension.
#
#Practical Use: 
#
# • Camping, securing tent guy lines, or creating temporary tie-down points for tarps and shelters.
''';

void main() {
  runApp(MaterialApp(
    home: Hitches(),
  ));
}
