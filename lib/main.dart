import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poem_generator/widgets/home.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(Project());

class Project extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            //ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5))),*/
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              HomeBody(),
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
                        'Team Tesseract',
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
                          'Prateek · Muskan · Manvendra · Soundarya',
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
