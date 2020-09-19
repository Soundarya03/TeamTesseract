import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final inputText = TextEditingController();
  String error = '';
  String poem = '';
  bool showpoemWidget = false;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Widget poemWidget(String input, double font, double sizeHeight) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 20),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //margin: EdgeInsets.all(left: 25),
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        inputText.text = '';
                        showpoemWidget = false;
                      });
                    },
                    color: Color(0xfffab1a0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          10.0, sizeHeight * 0.035, 10, sizeHeight * 0.035),
                      child: Text("Back Home"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 25),
                  child: FlatButton(
                    onPressed: () {
                      //download poem
                    },
                    color: Color(0xfffab1a0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          10.0, sizeHeight * 0.03, 10, sizeHeight * 0.03),
                      child: Icon(
                        Icons.download_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                input +
                    '\n Lorem ipsum dolor sit amet,\n consectetur adipiscing elit, \nsed do eiusmod tempor incididunt ut labore \net dolore magna aliqua. \n\nUt enim ad minim veniam, \nquis nostrud exercitation ullamco \nlaboris nisi ut aliquip ex \nea commodo consequat. \nDuis aute irure dolor in \nreprehenderit in voluptate velit \nesse cillum dolore eu fugiat \nnulla pariatur excepteur sint \noccaecat cupidatat non proident.',
                //'\n\nPenned by an AI\n',
                style: TextStyle(
                  fontSize: font,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                '- Penned by an AI\n  $formattedDate',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: font,
                  color: Color(0xfffab1a0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> writePoem() async {
    final response = await http.get('http://127.0.0.1:5000/output');
    //print(response);
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    setState(() {
      error = '';
      poem = decoded['poem'];
      showpoemWidget = true;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double font = height * 0.025;

    return Container(
        width: width * 0.95,
        height: height * 0.9,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(1), BlendMode.dstATop),
            image: AssetImage('images/AdaBG.png'),
            fit: BoxFit.cover,
          ),
          //color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: (showpoemWidget)
            ? poemWidget(poem, font, height)
            : Center(
                child: Column(
                children: [
                  SizedBox(height: height * 0.15),
                  Text(
                    'Sonnets + AI',
                    style: GoogleFonts.titilliumWeb(
                      textStyle: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.5, 2.5),
                              //blurRadius: 3.0,
                              color: Color(0xffff7979),
                            ),
                          ],
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[200],
                          fontSize: height * 0.06),
                    ),
                  ),
                  Text(
                    'Celebrating Ada Lovelace by bringing together two domains that shaped her life.\nProgramming and Poetry.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[200],
                      fontSize:
                          (width < 725) ? font : font * 1.3, //height * 0.03,
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Color(0xfffab1a0),
                      controller: inputText,
                      decoration: InputDecoration(
                        hintText:
                            'Enter some text here, and watch our AI model write you an original sonnet based on it!',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        hintMaxLines: 4,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfffab1a0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: (width < 725) ? height * 0.02 : font * 1.1,
                          color: Colors.red[400],
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      (inputText.text != '')
                          ? writePoem()
                          : setState(() {
                              error =
                                  'Please enter some text. Our AI does need a teeny bit of help to begin!';
                            });
                    },
                    color: Color(0xfffab1a0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          10.0, height * 0.05, 10, height * 0.05),
                      child: Text("Generate a sonnet!"),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                ],
              )));
  }
}
