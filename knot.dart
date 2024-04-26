import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MaterialApp(
      home: Knots(),
    ));
  });
}

// Constants for text styles
const TextStyle appBarTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  fontFamily: 'Sarabun',
  letterSpacing: 1.5,
);

const TextStyle knotTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle knotDescriptionStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'Lora',
  fontWeight: FontWeight.w900,
  letterSpacing: 1.5,
  color: Color(0xFF0001cf),
  height: 1.5,
);

class Knots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KNOTS',
          style: appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          KnotItem(
            knotImage: 'assets/icons/knot.png',
            knotName: 'REEF KNOT',
            knotVideo: 'assets/videos/knotreef.mp4',
            knotDescription: Knot1Description,
          ),
          SizedBox(height: 16.0),
          KnotItem(
            knotImage: 'assets/icons/knot.png',
            knotName: 'BOWLINE KNOT',
            knotVideo: 'assets/videos/bowline.mp4',
            knotDescription: Knot2Description,
          ),
          SizedBox(height: 16.0),
          KnotItem(
            knotImage: 'assets/icons/knot.png',
            knotName: 'SHEET BEND',
            knotVideo: 'assets/videos/sheetbend.mp4',
            knotDescription: Knot3Description,
          ),
          SizedBox(height: 16.0),
          KnotItem(
            knotImage: 'assets/icons/knot.png',
            knotName: 'SHEAP SHANK',
            knotVideo: 'assets/videos/sheapshank.mp4',
            knotDescription: Knot4Description,
          ),
          SizedBox(height: 16.0),
          KnotItem(
            knotImage: 'assets/icons/knot.png',
            knotName: "FIREMAN'S CHAIR KNOT",
            knotVideo: 'assets/videos/firemanschairknot.mp4',
            knotDescription: Knot5Description,
          ),
          SizedBox(height: 16.0),
          KnotItem(
            knotImage: 'assets/icons/knot.png',
            knotName: "FISHERMAN'S KNOT",
            knotVideo: "assets/videos/fisherman'sknot.mp4",
            knotDescription: Knot6Description,
          ),
          SizedBox(height: 16.0),
          KnotItem(
            knotImage: 'assets/icons/knot.png',
            knotName: "FIGURE OF EIGHT KNOT",
            knotVideo: "assets/videos/figure.mp4",
            knotDescription: Knot7Description,
          ),
          SizedBox(height: 16.0),
          KnotItem(
            knotImage: 'assets/icons/knot.png',
            knotName: "BOWLINE ON A BIGHT",
            knotVideo: "assets/videos/bowlineonabight.mp4",
            knotDescription: Knot8Description,
          )// Add more KnotItem widgets for each knot// Add more KnotItem widgets for each knot
        ],
      ),
    );
  }
}

class KnotItem extends StatelessWidget {
  final String knotImage;
  final String knotName;
  final String knotVideo;
  final String knotDescription;

  KnotItem({
    this.knotImage,
    this.knotName,
    this.knotVideo,
    this.knotDescription,
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
              knotImage,
              width: 30,
              height: 30,
            ),
            title: Text(
              knotName,
              style: knotTitleStyle,
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
                child: VideoPlayerWidget(videoPath: knotVideo),
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
                    children: knotDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: knotDescriptionStyle,
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

final String Knot1Description = '''
#Uses: 
#
# • Tying two ends of a rope together securely.
#
#Practicel Use: 
#
# • Securing packages, binding objects together, or joining fishing lines.
''';

final String Knot2Description = '''
#Uses: 
#
# • Forming a secure loop at the end of a rope.
#
#Practicel Use: 
#
# • Tying safety lines, securing boats, or creating a fixed loop for rescue operations.
''';

final String Knot3Description = '''
#Uses: 
#
# • Joining two ropes of different diameters or materials.
#
#Practicel Use: 
#
# • Extending a rope, repairing a broken line, or creating a longer line for towing or hauling.
''';

final String Knot4Description = '''
#Uses: 
#
# • Temporarily shortening a rope or taking up slack.
#
#Practicel Use: 
#
# • Rigging sails, securing a line to a cleat, or adjusting tension in a rope system.
''';

final String Knot5Description = '''
#Uses: 
#
# • Creating a secure seat for emergency rappelling or rescue situations
#
#Practicel Use: 
#
# • Swiftwater rescue, high-angle rescue, or emergency evacuation scenarios where a quick and stable harness is needed.
''';

final String Knot6Description = '''
#Uses: 
#
# • Joining two lines of similar diameter together securely.
#
#Practicel Use: 
#
# • Fishing, connecting fishing lines, leader lines, or repairing broken fishing lines.
''';

final String Knot7Description = '''
#Uses: 
#
# • Creating a secure loop at the end of a rope.
#
#Practicel Use: 
#
# • Climbing, securing safety lines, or stopping ropes from slipping through equipment.
''';

final String Knot8Description = '''
#Uses: 
#
# • Forming a fixed loop in the middle of a rope without access to the ends.
#
#Practicel Use: 
#
# • Climbing, rescue operations, or creating secure attachment points in rigging.
''';

