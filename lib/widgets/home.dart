import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:poem_generator/widgets/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  String poem = ''; //this stores the poem written by the AI
  bool showpoemWidget = false; //used to control dynamic display
  bool isCopied = false;
  bool isLoading = false;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Uint8List uploadedImage; //to store image uploaded by user; i.e user input
  String uploadedFileURL = '';

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
                        isLoading = false;
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
                input,
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
                '\n\n- Penned by an AI\n  $formattedDate',
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
    setState(() {
      isLoading = true;
    });
    /*This function is one of the most important parts of our program, as it writes our poem; here, I've split it into 3 parts.
    Also, the two key peices of data here:-

      user input : uploadedImage
      AI's output : poem*/

    //--------------------IMP !!  NEW-------------------------------------------------------
    //Here, I'm uploading user's input image to the cloud firestore, and then storing DownloadURL
    //in uploadedFileURL.
    //io.File file = new io.File.fromRawPath(uploadedImage);
    /*StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('gs://poemgenerator-db22e.appspot.com');
    StorageUploadTask uploadTask = storageReference.putFile(uploadedImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL = fileURL;
      });
    });*/

    //PART-1 : Sending the user's input to the server, based on which the ML model makes the prediction.
    final url = 'http://98e7772ca55e.ngrok.io/predict';
    final response1 =
        await http.post(url, body: json.encode({'text': uploadedFileURL}));

    //PART-2 : Making a http get request to the server to retreive the poem generated by the ML model
    // final response2 = await http.get('http://127.0.0.1:5000/output');
    //print(response2);
    final decoded = json.decode(response1.body) as Map<String, dynamic>;
    print(decoded);

    //PART-3 : Performing a setState operation to trigger a rebuild of the widget tree, and display the poem
    setState(() {
      poem = decoded['poem'];
      showpoemWidget = true;
    });
  }

  startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.accept =
        '.png,.jpg, .jpeg'; //to accept only images, in particular, pngs, jpgs and jpeg
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage =
                reader.result; //uploadedImage now holds the user's input
            writePoem();
            showpoemWidget =
                true; //once the input has been read, we must shift to poem view
          });
        });

        reader.onError.listen((fileEvent) {
          //error handling
          setState(() {
            print("Some Error occured while reading the file");
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
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
                ? (isLoading)
                    ? LoadingWidget(
                        child: Image.memory(
                        uploadedImage,
                        width: width * 0.3,
                        height: height * 0.3,
                      ))
                    : (poemWidget(poem, font, height))
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
                      FlatButton(
                        onPressed: () {
                          startFilePicker(); //writePoem()
                        },
                        color: Color(0xfffab1a0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              10.0, height * 0.05, 10, height * 0.05),
                          child: Column(
                            children: [
                              Text(
                                "Generate sonnet!",
                                style: TextStyle(
                                  fontSize:
                                      (width < 725) ? font * 0.8 : font * 1.1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Upload an image and watch the magic",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize:
                                        (width < 725) ? font * 0.5 : font * 0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                    ],
                  )));
  }
}
