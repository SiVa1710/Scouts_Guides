import 'package:flutter/material.dart';

class Uniform extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UNIFORM',
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
          UniformItem(
            uniformImage: 'assets/images/scout.png',
            uniformName: 'SCOUT UNIFORM',
            uniformDescription: Scout,
          ),
          SizedBox(height: 16.0),
          UniformItem(
            uniformImage: 'assets/images/guide.png',
            uniformName: 'GUIDE UNIFORM',
            uniformDescription: Guide,
          ),
        ],
      ),
    );
  }
}

class UniformItem extends StatelessWidget {
  final String uniformImage;
  final String uniformName;
  final String uniformDescription;

  UniformItem({
    this.uniformImage,
    this.uniformName,
    this.uniformDescription,
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
              'assets/icons/uniform.png', // Replace with your image asset path
              width: 30, // Adjust image size
              height: 30,
            ),
            title: Text(
              uniformName,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              uniformImage,
              width: MediaQuery.of(context).size.width - 32.0,
              height: MediaQuery.of(context).size.width * 0.90,
              fit: BoxFit.cover,
            ),
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
                    children: uniformDescription.split('#').map((line) {
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

final String Scout = '''
#Shirt:
#
# • A steel grey shirt featuring two patch pockets with shoulder straps. Sleeves can be worn either half or rolled up, and may be turned down during cold weather.
#
#Shorts or Trousers:
#
# • Navy blue shorts or trousers are mandatory. However, during Rashtrapati Scout Testing camp and Rashtsapati Award Rally, trousers are compulsory. Trousers should maintain a moderate fit, featuring two side pockets and one back pocket.
#
#Head-dress:
#
# • A dark blue beret cap with the official cap badge supplied by the National Association is required. Alternatively, a Sikh may wear a blue turban with the official cap badge. The head dress is mandatory during ceremonies.
#
#Belt:
#
# • A grey Nylex belt with the official buckle of the Bharat Scouts & Guides supplied by the National Association should be worn.
#
#Scarf:
#
# • A triangular scarf in the Group's color, excluding green, purple, or yellow, and pattern approved by the Local or District Association. The scarf should be worn with shoulder straps featuring the Group woggle, other than the Gilwell woggle. Each side of the scarf should measure between 70cms and 80cms.
#
#Shoulder Badge:
#
# • A shoulder badge measuring 6 to 8 cm x 1.5 cm with a white background and red border. The serial number and name of the group in red letters should be worn on both shoulders just below the seam with a slight curve. Note: Members of the Group consisting of Sea Scouts or Air Scouts should not include the words "Sea Scout" or "Air Scout" on the shoulder badge. Instead, a red slip supplied by the National Association should be worn on shoulder straps on both sides.
#
#Shoulder Stripes:
#
# • Two shoulder stripes, each 5cms long and 1.5 cms wide, indicative of the color and name of the patrol as shown in Scouting for Boys. These should be stitched horizontally, 2 cms apart on a square-shaped steel grey cloth. The patch should be worn at the top of the left sleeve immediately below the Shoulder Badge. Note: If there is an Ambulance man badge, Shoulder stripes should be worn below the Ambulance man badge.
#
#Membership Badge:
#
# • A cloth badge with a green background, featuring a Fleur-de-lis in yellow superimposed by the Trefoil with Ashoka Chakra also in yellow in the center. This badge should be worn in the center of the pleat of the left pocket of the shirt.
#
#Socks or Stockings:
#
# • Black socks or stockings are permissible. If wearing stockings, they should be rolled down below the knees, with the green garter tabs visible outside. Stockings should be worn with shorts only.
#
#World Scout Badge:
#
# • The World Scout Badge should be worn in the center of the pleat of the right pocket of the shirt.
#
#Footwear:
#
# • "Black shoes (leather or canvas) with laces may be worn".
#
#The BSG Stripe:
#
# • The name stripe containing "The Bharat Scouts & Guides" supplied by National Headquarters may be worn just above the right pocket of the shirt. The size of the stripe should be 11 cm x2 cm, with the right corner featuring the tricolor of the National Flag of the size of 2 cm x 3 cm, and the rest for the title of "The Bharat Scout & Guides".
''';

final String Guide = '''
#Overall: 
#
# • A deep sky blue overall made of plain non-transparent material with two top patch pockets and two side pockets from the underside. It features half sleeves that are 8 cm above the elbow, with turned up and stitched down cuffs 4 cm wide, and an open sports collar with epaulettes on both shoulders. The overall should not be tight-fitted.
#
#Salwar, Kameez, and Dupatta: 
#
# • A deep sky blue Salwar and light blue Kameez made of plain non-transparent material. The length of the Kameez should be up to the knees, with two patch pockets and two side pockets, half sleeves 8 cm above the elbow with turned up and stitched down cuffs 4 cm wide, and an open sports collar with epaulettes on both shoulders. The Salwar and Kameez should not be tight-fitted. The Dupatta should be deep sky blue in color made of plain non-transparent material.
#
#Midi Skirt and Blouse: 
#
# • A midi skirt in deep sky blue made of plain non-transparent material with side pockets and a slit at the back. The length of the skirt should be up to half the distance between the knee and ankle. A white blouse made of plain non-transparent material with two patch pockets, half sleeves 8 cm above the elbow with turned up and stitched down cuffs 4 cm wide, and an open sports collar with epaulettes on both shoulders. The length of the blouse should be 8 cm below the waistline. The skirt and blouse should not be tight-fitted.
#
#Belt: 
#
# • A brown Nylex belt with the official brass buckle of the Bharat Scouts & Guides supplied by the National Association.
#
#Scarf: 
#
# • scarf of the group's color and pattern, other than green, purple, and yellow, as approved by the Local or District Association, shall be worn round the neck and over the collar and epaulettes with the group woggle. The scarf should be triangular with a base and two sides, each of the two sides should have a minimum length of 70 cm and a maximum of 80 cm.
#
#Socks: 
#
# • White in color.
#
#Footwear: 
#
# • Black leather or black canvas closed shoes with a buckle.
#
#Hair Ribbon: 
#
# • Black plain ribbon or black plain hair band (without any design only for short hair).
#
#Membership Badge: 
#
# • A cloth badge with a green background, with Fleur-de-lis in yellow superimposed by the Trefoil with Ashoka Chakra also in yellow in the center, shall be worn in the middle of the left sleeve.
#
#Shoulder Badge: 
#
# • A shoulder badge 6 to 8 cm in length and 1.5 cm in width with a white background and red border, the serial number (optional), and the name of the Group/District/State in red letters shall be worn on both shoulders just below the seam with a little curve.
#
#World Guide Badge: 
#
# • The World Guide Badge shall be worn in the middle of the right sleeve.
#
#Patrol Emblem: 
#
# • Every Guide shall wear a Patrol emblem, embroidered on a black background with a green border, 4 cm in diameter. It shall be worn in the center of the top of the sash.
#
#Name Stripe: 
#
# • The Name Stripe containing “The Bharat Scouts & Guides” supplied by National Headquarters may be worn above the right pocket on the blouse or kameez. The size of the stripe should be 11 cm x 2 cm. The right corner of which would be tricolor of National Flag of the size of 3 cm x 2 cm, and the rest for the Title “The Bharat Scouts & Guides”.
#
#Cardigan: 
#
# • When worn, it shall be black without any design. Sleeveless according to the season allowed.
#
#Sash: 
# 
# • A deep sky blue sash with 10 cm width should be worn on the left shoulder across the chest so that the lower end of the sash will come up to just below the hip level on the right side with Proficiency Badges earned in accordance with the girls' program in ascending order.
#
#Optional:
#
# • Camp Uniform: Deep blue Salwar, deep blue Kameez with the same pattern as mentioned above, and a deep blue Dupatta.
# 
# • During Outing and Hiking: Deep blue jeans, Sky Blue T-Shirt with a collar having a pocket superimposed with BSG emblem. A P. Cap can be worn when they go for an outing.
#  
# • A black pouch shall be worn: The pouch shall not be worn at the time of the Ceremony.
# 
# • Metal Badge: A “metal badge” of the Bharat Scouts & Guides may be worn when not in uniform.
#  
# • Lanyard and Whistle: A white lanyard with a whistle may be worn round the neck.
#
# • Jewelry: No jewelry shall be worn except those enjoined by religion or custom.
#
#Uniform for Sea Guide: A Sea Guide shall wear the uniform as for a Guide. She shall also wear the Sea Guide Badge above the right pocket.
#
#Uniform for Air Guide: An Air Guide shall wear the uniform as for a Guide. She shall also wear the Air Guide Badge above the right pocket.
''';

void main() {
  runApp(MaterialApp(
    home: Uniform(),
  ));
}
