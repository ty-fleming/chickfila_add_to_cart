import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chick-Fil-A',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: MenuItemDetailScreen(),
    );
  }
}

const Color COLOR_BACKGROUND_WHITE = Color.fromRGBO(237, 238, 236, 1);
const Color COLOR_RED = Color.fromRGBO(229, 22, 54, 1);

class MenuItemDetailScreen extends StatefulWidget {
  @override
  _MenuItemDetailScreenState createState() => _MenuItemDetailScreenState();
}

class _MenuItemDetailScreenState extends State<MenuItemDetailScreen> {
  double _animatedHeight = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    setState(() {
      //_animatedHeight = MediaQuery.of(context).size.height;
    });
    Widget buildRoundedButton(String buttonText, int number) {
      return GestureDetector(
        onTap: () {
          if (number == 1) {
            setState(() {
              _animatedHeight = 100.00;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: COLOR_RED,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(-3, 3), // changes position of shadow
              )
            ],
            borderRadius: BorderRadius.circular(35),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: textTheme.bodyText1!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: COLOR_BACKGROUND_WHITE,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: 55,
        width: MediaQuery.of(context).size.width * 0.6,
        child: buildRoundedButton("Add To Order", 1),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              color: COLOR_RED,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          AnimatedContainer(
            color: COLOR_BACKGROUND_WHITE,
            height: _animatedHeight,
            duration: const Duration(milliseconds: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 300,
                    child: Image(
                      image: const AssetImage("assets/sandwich.png"),
                      fit: BoxFit.cover,
                      height: 200,
                      width: 350,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
