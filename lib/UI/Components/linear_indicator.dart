import 'package:flutter/material.dart';


class LinearIndicatorBar extends StatefulWidget {
  const LinearIndicatorBar({
    Key? key,
  }) : super(key: key);

  @override
  State<LinearIndicatorBar> createState() => _LinearIndicatorBarState();
}

class _LinearIndicatorBarState extends State<LinearIndicatorBar> {
  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      minHeight:5,
      color: Color(0xFF64ffda),
      backgroundColor: Colors.black,
    );
  }
}
