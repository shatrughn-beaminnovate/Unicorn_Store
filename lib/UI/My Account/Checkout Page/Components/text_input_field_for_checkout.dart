import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../constant.dart';

class TextInputFieldForCheckout extends StatelessWidget {
 final String title;
  final bool obscureText;
  final bool isMandatory;
  final String? hintText;
  const TextInputFieldForCheckout(
      {Key? key,
      required this.title,
      this.hintText,
      required this.isMandatory,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
            ),
            isMandatory
                ? const Positioned(
                    right: -7,
                    top: -4,
                    child: Text("*"),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(5.0),
        ),
        SizedBox(
          height: getProportionateScreenHeight(35.0),
          child: TextFormField(
            obscureText: obscureText,
            cursorColor: Colors.black,
          
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kDefaultBorderColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1F99CF), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            
          ),
        ),
      ],
    );
 
 
  }
}