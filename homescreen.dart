import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouts_and_guides/exercise.dart';
import 'package:scouts_and_guides/flags.dart';
import 'package:scouts_and_guides/goodturn.dart';
import 'package:scouts_and_guides/history.dart';
import 'package:scouts_and_guides/firstaid.dart';
import 'package:scouts_and_guides/hitch.dart';
import 'package:scouts_and_guides/knot.dart';
import 'package:scouts_and_guides/lashing.dart';
import 'package:scouts_and_guides/nationalanthem.dart';
import 'package:scouts_and_guides/notes.dart';
import 'package:scouts_and_guides/uniform.dart';
import 'package:scouts_and_guides/patrol.dart';
import 'package:scouts_and_guides/flagsong.dart';
import 'package:scouts_and_guides/prayer.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categoryNames = [
    "FLAGS",
    "NOTES",
    "HISTORY",
    "UNIFORM",
    "FIRST AID",
    "KNOTS",
    "LASHING",
    "HITCHES",
    "PATROL SYSTEM",
    "BP 6 EXERCISE"
  ];

  final List<String> categoryImages = [
    "assets/icons/flag.png",
    "assets/icons/notes.png",
    "assets/icons/history.png",
    "assets/icons/uniform.png",
    "assets/icons/aid.png",
    "assets/icons/knot.png",
    "assets/icons/lash.png",
    "assets/icons/hitches.png",
    "assets/icons/patrol.png",
    "assets/icons/exercise.png"
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SCOUTS AND GUIDES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Color(0xFF0001cf),
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/s&g.jpg',
                    width: double.infinity,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'SCOUTS AND GUIDES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            buildListTile(
              image: 'assets/icons/prayer.png',
              title: 'PRAYER SONG',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Prayer()),
                );
              },
            ),
            buildListTile(
              image: 'assets/icons/flag1.png',
              title: 'FLAG SONG',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlagSong()),
                );
              },
            ),
            buildListTile(
              image: 'assets/icons/ind.png',
              title: 'NATIONAL ANTHEM',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NationalAnthem()),
                );
              },
            ),
            buildListTile(
              image: 'assets/icons/good.png',
              title: 'GOOD TURN',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoodTurn()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemBuilder: (context, index) {
            return CategoryItem(
              name: categoryNames[index],
              image: categoryImages[index],
              onTap: () {
                navigateToCategory(context, index);
              },
            );
          },
        ),
      ),
    );
  }

  void navigateToCategory(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Flags()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Notes()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => History()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Uniform()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirstAid()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Knots()),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Lashing()),
        );
        break;
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Hitches()),
        );
        break;
      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Patrol()),
        );
        break;
      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Exercises()),
        );
        break;
    }
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  CategoryItem({this.name, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          elevation: 9,
          color: Color(0xFF0001cf),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: Color(0xFF0001cf),
              width: 3.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.width * 0.13,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.048,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: 'Sarabun',
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ListTile buildListTile({
  String image,
  String title,
  VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade400, width: 1.0),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                width: 37,
                height: 37,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontFamily: 'Sarabun',
                letterSpacing: 1.2,
                color: Color(0xFF0001cf),
              ),
            ),
          ],
        ),
      ),
    ),
    onTap: onTap,
  );
}


