import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poem_generator/text.dart/textLoading.dart';

class LoadingWidget extends StatefulWidget {
  final Widget child;

  LoadingWidget({this.child});

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  String _text = textLoading[0];
  Timer _timer;
  var i = 1;

  _LoadingWidgetState() {
    _timer = new Timer.periodic(const Duration(seconds: 3), (Timer t) {
      setState(() {
        _text = textLoading[i];
        i++;
      });
      if (i == 6) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double font = height * 0.025;

    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Text(
              "Your image will now serve as the inspiration for our AI's sonnet!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[200],
                fontSize: (width < 725) ? font : font * 1.3, //height * 0.03,
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            widget.child,
            SizedBox(
              height: height * 0.025,
            ),
            SpinKitWave(
              color: Color(0xfffab1a0),
              size: 35.0,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Text(
              _text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey[350],
                fontSize:
                    (width < 725) ? font * 0.9 : font * 1.2, //height * 0.03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
