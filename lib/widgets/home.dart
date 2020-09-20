import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clipboard/clipboard.dart';

/*
  This file holds the main content of our webpage, i.e the HomeBody widget.
  This widget displays dynamic content based on whether the user has input text and 
  clicked on the 'Generate Sonnet!' button or not. 
*/

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final inputText = TextEditingController();
  String error =
      ''; //this is to set an error message in case the user doesn't enter any seed text
  String poem = ''; //this stores the poem written by the AI
  bool showpoemWidget = false; //used to control dynamic display
  bool isCopied = false;
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
                        isCopied = false;
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
                      FlutterClipboard.copy(input +
                          '\n\n- Penned by an AI\n  Team Tesseract\n  ' +
                          formattedDate);
                      setState(() {
                        isCopied = true;
                      });
                      //download poem
                    },
                    color: Color(0xfffab1a0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          10.0, sizeHeight * 0.03, 10, sizeHeight * 0.03),
                      child: Tooltip(
                        message: 'Copy poem',
                        child: isCopied
                            ? Text('Copied!')
                            : Icon(
                                Icons.copy_rounded,
                              ),
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
    /*This function is one of the most important parts of our program, as it writes our poem; here, I've split it into 3 parts.
    Also, the two key peices of data here:-

      user input : inputText.text
      AI's output : poem*/

    //PART-1 : Sending the user's input to the server, based on which the ML model makes the prediction.
    final url = 'http://127.0.0.1:5000/input';
    final response1 =
        await http.post(url, body: json.encode({'seed': inputText.text}));

    //PART-2 : Making a http get request to the server to retreive the poem generated by the ML model
    final response2 = await http.get('http://127.0.0.1:5000/output');
    //print(response2);
    final decoded = json.decode(response2.body) as Map<String, dynamic>;

    //PART-3 : Performing a setState operation to trigger a rebuild of the widget tree, and display the poem
    setState(() {
      error = '';
      poem = decoded['poem'];
      showpoemWidget = true;
    });
  }

  @override
  void dispose() {
    // to clean up the controller when the widget is disposed; good programming practice.
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
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child:
            (showpoemWidget) //this ternary operator serves the crucial prpose of displaying dynamic content.
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
                          fontSize: (width < 725)
                              ? font
                              : font * 1.3, //height * 0.03,
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
                              fontSize:
                                  (width < 725) ? height * 0.02 : font * 1.1,
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
