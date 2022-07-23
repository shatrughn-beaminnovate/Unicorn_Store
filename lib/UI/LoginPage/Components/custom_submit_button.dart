import 'package:flutter/material.dart';

import '../../size_config.dart';


class LoginButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final double? height;
  final double? width;
  final Color color;
  final Color? onPrimary;
  
  const LoginButton({Key? key, required this.title,this.onPrimary,required this.color,required this.onPress,this.width,this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {
      onPress();
        },
        style: ElevatedButton.styleFrom(
      primary: color, // background
      onPrimary: onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ), // <-- Radius
      ), // foreground
        ),
        child: Text(
      title,
      style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
        ),
      ),
    );
  }
}
