import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../constant.dart';

class TextFormFieldAndButton extends StatelessWidget {
  final String buttonTitle;
  final String hintText;
  const TextFormFieldAndButton(
      {Key? key, required this.buttonTitle, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        color: Colors.white,
        width: getProportionateScreenWidth(350),
        height: getProportionateScreenHeight(40),
        child: TextFormField(
          cursorColor: Colors.black,
         
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: const Color(0xFF6C757D),
                fontSize: getProportionateScreenWidth(13.0)),
            hintText: hintText,
            contentPadding:  EdgeInsets.all(getProportionateScreenHeight(7.0)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.0))),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kDefaultBorderColor, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: kDefaultSecondaryButtonColor, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
          ),
        ),
      ),
      Positioned(
        right: 0,
        child: SizedBox(
            width: getProportionateScreenWidth(80),
            height: getProportionateScreenHeight(40),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                buttonTitle,
                style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
              ),
              style: ElevatedButton.styleFrom(
                primary: kDefaultSecondaryButtonColor, // background
                onPrimary: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(3.0),
                      bottomRight: Radius.circular(3.0)), // <-- Radius
                ), // foreground
              ),
            )),
      ),
    ]);
  }
}
