import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poem_generator/widgets/home.dart';

void main() => runApp(Project());

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                        flex: 2,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              width: width,
                              child: Text(
                                'The Ada Lovelace Hack',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.titilliumWeb(
                                  textStyle: TextStyle(
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(5.0, 5.0),
                                          //blurRadius: 3.0,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      fontSize: height * 0.08),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(0),
                                width: width,
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Team Tesseract',
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
                        flex: 1,
                        child: Image.asset(
                          'images/Logo.png',
                          height: height * 0.3,
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
            ],
          ),
        ),
      ),
    ));
  }
}
