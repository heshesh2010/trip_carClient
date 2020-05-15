import 'package:flutter/material.dart';

class BuildSeparator extends StatefulWidget {
  final Size screenSize;

  BuildSeparator(this.screenSize);
  @override
  _BuildSeparatorState createState() => _BuildSeparatorState();
}

class _BuildSeparatorState extends State<BuildSeparator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenSize.width,
      height: 0.3,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }
}
