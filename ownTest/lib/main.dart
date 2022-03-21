import 'package:flutter/material.dart';
void main() {
  runApp(Container(
    color: Colors.blue,
    child: Center(
     child: Text(
       'Hello world',
       textDirection: TextDirection.ltr,
       textScaleFactor: 3,
       style : TextStyle(
        color: Colors.black
       )
     )
    )
  )
  );
}
