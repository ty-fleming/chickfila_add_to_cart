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

class _MenuItemDetailScreenState extends State<MenuItemDetailScreen>
    with SingleTickerProviderStateMixin {
  double _animatedHeight = 0;
  double _borderRadius = 0;
  int _step = 1;
  String _buttonText = "Add To Order";
  int animationMilliseconds = 150;
  late Animation<double> contentAnimation;
  late AnimationController contentAnimationController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _toggleMenuItem(1));

    contentAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (animationMilliseconds - 50)),
    );

    contentAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
          parent: contentAnimationController, curve: Curves.fastOutSlowIn),
    );
  }

  void _toggleMenuItem(int stepNum) {
    setState(() {
      _step = stepNum;
      switch (stepNum) {
        case 1:
          _animatedHeight = MediaQuery.of(context).size.height;
          contentAnimationController.reverse();
          _borderRadius = 0;
          _buttonText = "Add to Order";
          break;
        case 2:
          _animatedHeight = MediaQuery.of(context).size.height * .9;
          contentAnimationController.reverse();
          _borderRadius = 35;
          _buttonText = "View Order";
          break;
        case 3:
          _animatedHeight = 75;
          _borderRadius = 35;
          contentAnimationController.forward();
          _buttonText = "";
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    Widget buildRoundedButton(String buttonText, int number) {
      return GestureDetector(
        onTap: () {
          _toggleMenuItem(number);
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

    Widget _buildCartListItem(BuildContext context, bool showDrink) {
      return Container(
        height: 125,
        margin: EdgeInsets.only(left: 25),
        width: MediaQuery.of(context).size.width,
        color: COLOR_RED,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: COLOR_BACKGROUND_WHITE),
              child: Image(
                height: 75,
                width: 75,
                image: AssetImage(
                    showDrink ? "assets/drink.png" : "assets/sandwich.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    showDrink ? "Coke" : "Crispy Chicken Sandwich",
                    style: textTheme.headline6!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "x1",
                    style: textTheme.bodyText2!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: Center(
                child: Text(
                  "\$ 2.25",
                  style: textTheme.bodyText1!
                      .copyWith(color: COLOR_RED, fontWeight: FontWeight.bold),
                ),
              ),
              height: 25,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    }

    Widget _buildCart(BuildContext context) {
      return ListView(children: <Widget>[
        _buildCartListItem(context, true),
        _buildCartListItem(context, false),
      ]);
    }

    return Scaffold(
      backgroundColor: COLOR_BACKGROUND_WHITE,
      body: Stack(
        children: [
          Positioned(
            child: Container(
              color: COLOR_RED,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.only(bottom: 8.0, top: 60),
                      child: _step == 1 || _step == 2
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: COLOR_BACKGROUND_WHITE),
                                    child: Image(
                                      height: 60,
                                      width: 60,
                                      image: AssetImage("assets/drink.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: COLOR_BACKGROUND_WHITE),
                                    child: Image(
                                      height: 60,
                                      width: 60,
                                      image: AssetImage("assets/sandwich.png"),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "\$ 5.39",
                                      style: textTheme.headline5!.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  child: _buildCart(context),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "Total  \$ 5.39",
                                      style: textTheme.headline5!.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.only(bottom: 25),
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: GestureDetector(
                                    onTap: () {
                                      _toggleMenuItem(1);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black38.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(-3,
                                                3), // changes position of shadow
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Confirm Order",
                                          style: textTheme.bodyText1!.copyWith(
                                            color: COLOR_RED,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 8),
            decoration: BoxDecoration(
              color: COLOR_BACKGROUND_WHITE,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(_borderRadius),
                bottomRight: Radius.circular(_borderRadius),
              ),
            ),
            height: _animatedHeight,
            duration: Duration(milliseconds: animationMilliseconds),
            curve: Curves.bounceInOut,
            child: FadeTransition(
              opacity: contentAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage("assets/sandwich.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Crispy Chicken Sandwich",
                          textAlign: TextAlign.left,
                          style: textTheme.headline6!.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "\$ 5.39",
                          textAlign: TextAlign.left,
                          style: textTheme.headline6!.copyWith(
                              color: COLOR_RED, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "320 Cal",
                            style: textTheme.bodyText1!.copyWith(
                                color: COLOR_RED, fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: COLOR_RED.withOpacity(.2),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "A boneless breast of chicken seasoned to perfection, freshly breaded, pressure cooked in 100% refined peanut oil and served on a toasted, buttered bun with dill pickle chips. Also available on a multigrain bun.",
                          textAlign: TextAlign.left,
                          style: textTheme.bodyText2!.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: COLOR_RED.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Includes",
                                  style: textTheme.bodyText1!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    child: Image(
                                      image: AssetImage("assets/lettuce.png"),
                                    ),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 55,
                                    child: Image(
                                      image: AssetImage("assets/tomato.png"),
                                    ),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 55,
                                    child: Image(
                                      image: AssetImage("assets/mustard.png"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  if (_buttonText != "" && (_step == 1 || _step == 2))
                    Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child:
                          buildRoundedButton(_buttonText, _step == 1 ? 2 : 3),
                    ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
