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
      home: Lashing(),
    ));
  });
}

// Constants for text styles
const TextStyle appBarTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20,
  fontFamily: 'Sarabun',
  letterSpacing: 1.5,
);

const TextStyle lashTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle lashDescriptionStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'Lora',
  fontWeight: FontWeight.w900,
  letterSpacing: 1.5,
  color: Color(0xFF0001cf),
  height: 1.5,
);

class Lashing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LASHING',
          style: appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          LashItem(
            lashImage: 'assets/icons/lash.png',
            lashName: 'SQUARE LASHING',
            lashVideo: 'assets/videos/sqaurelashing.mp4',
            lashDescription: Lash1Description,
          ),
          SizedBox(height: 16.0),
          LashItem(
            lashImage: 'assets/icons/lash.png',
            lashName: 'DIAGONAL LASHING',
            lashVideo: 'assets/videos/diagonal.mp4',
            lashDescription: Lash2Description,
          ),
          SizedBox(height: 16.0),
          LashItem(
            lashImage: 'assets/icons/lash.png',
            lashName: 'ROUND LASHING',
            lashVideo: 'assets/videos/roundlashing.mp4',
            lashDescription: Lash3Description,
          ),
          SizedBox(height: 16.0),
          LashItem(
            lashImage: 'assets/icons/lash.png',
            lashName: 'TRIPOD LASHING',
            lashVideo: 'assets/videos/tripodlashing.mp4',
            lashDescription: Lash4Description,
          ),
          SizedBox(height: 16.0),
          LashItem(
            lashImage: 'assets/icons/lash.png',
            lashName: 'SHEAR LASHING',
            lashVideo: 'assets/videos/shearlashing.mp4',
            lashDescription: Lash5Description,
          ),
        ],
      ),
    );
  }
}

class LashItem extends StatelessWidget {
  final String lashImage;
  final String lashName;
  final String lashVideo;
  final String lashDescription;

  LashItem({
    required this.lashImage,
    required this.lashName,
    required this.lashVideo,
    required this.lashDescription,
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
              lashImage,
              width: 30,
              height: 30,
            ),
            title: Text(
              lashName,
              style: lashTitleStyle,
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
                child: VideoPlayerWidget(key: UniqueKey(), videoPath: lashVideo),
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
                    children: lashDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: lashDescriptionStyle,
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

  const VideoPlayerWidget({required Key key, required this.videoPath}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

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
    _videoPlayerController.addListener(_onVideoStateChanged);
  }

  void _onVideoStateChanged() {
    if (_videoPlayerController.value.position >= _videoPlayerController.value.duration) {
      // Video playback reached the end
      // Seek back to the start
      _videoPlayerController.seekTo(Duration.zero);
    }
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
    _videoPlayerController.removeListener(_onVideoStateChanged);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}

final String Lash1Description = '''
#Uses: 
#
# • To secure two spars together at right angles.
#
#Practical Use: 
#
# • Building frameworks for shelters or tripods.
''';

final String Lash2Description = '''
#Uses: 
#
# • To join two spars together at any angle other than a right angle.
#
#Practical Use: 
#
# • Constructing more complex structures like a raft or a tower.
''';

final String Lash3Description = '''
#Uses: 
#
# • To bind two spars or poles together along their length.
#
#Practical Use: 
#
# • Creating longer poles for structures or constructing bridges.
''';

final String Lash4Description = '''
#Uses: 
#
# •  Binding three poles together to form a stable tripod structure.
#
#Practical Use: 
#
# • Constructing tripods for outdoor cooking setups, photography, or emergency shelters.
''';

final String Lash5Description = '''
#Uses: 
#
# • Securing two poles together at a perpendicular angle.
#
#Practical Use: 
#
# • Building structures like scaffolding, tripods, or framework in outdoor settings.
''';
