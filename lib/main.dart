import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poem_generator/widgets/home.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(Project());
// This is the main function, the point from where the code is executed

class Project extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        '/': (context) => PoemGenerator(),
      },
    );
  }
}

class PoemGenerator extends StatefulWidget {
  @override
  _PoemGeneratorState createState() => _PoemGeneratorState();
}

class _PoemGeneratorState extends State<PoemGenerator> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context)
        .size
        .width; //these are used to create a more responsive webpage,
    double height = MediaQuery.of(context)
        .size
        .height; //so that it renders well on mobile and PC
    double font = width * 0.025;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.grey[900],
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: width,
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    color: Color(0xfffab1a0),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0)),
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              width: width,
                              child: AutoSizeText(
                                'The Ada Lovelace Hack',

                                minFontSize: 25,
                                //maxLines: 1,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.titilliumWeb(
                                  textStyle: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(4.0, 4.0),
                                        //blurRadius: 3.0,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                    letterSpacing: -1,
                                    //height: 0.02,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    fontSize: font * 1.3, //width * 0.035,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(0),
                                width: width,
                                padding: EdgeInsets.only(left: 15),
                                child: AutoSizeText(
                                  'Team Tesseract',
                                  maxFontSize: 30,
                                  style: GoogleFonts.titilliumWeb(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey[800],
                                        fontSize: height * 0.04),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      //Container(color: Colors.blue, width: width * 0.08),
                      Expanded(
                        flex: 3,
                        child: Image.asset(
                          'images/Logo.png',
                          height: width * 0.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              HomeBody(), //visit the home.dart file to know more about this widget. It forms the main part of our project.
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                width: width,
                height: height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Team Tesseract', //Our team name!
                        style: GoogleFonts.titilliumWeb(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2, 2),
                              //blurRadius: 3.0,
                              color: Colors.grey[200],
                            ),
                          ],
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize:
                                (width < 725) ? height * 0.03 : font * 0.8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                          'Prateek · Muskan · Manvendra · Soundarya', //Credits!
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: height * 0.022,
                          ),
                        ),
                      ),
                      Text(
                        'We thank IEEE, and the WIE branch in particular for this opportunity.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: height * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
