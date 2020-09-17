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
        body: Container(
      color: Colors.grey[900],
      width: width,
      height: height,
      child: Stack(
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
                        'Celebrating Ada Lovelace through sonnets + ML',
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
          ),
          Align(
            alignment: Alignment(0, 5),
            child: HomeBody(),
          ),
        ],
      ),
    ));
  }
}
