import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../constant.dart';

class TextInputField extends StatelessWidget {
  final String? title;
  final bool obscureText;
  final bool isMandatory;
  final String? hintText;
  final TextInputType textInputType;
  final String Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  const TextInputField(
      {Key? key,
       this.title,
      this.hintText,required this.textInputType,
      this.onChanged,
      this.validator,
      this.textEditingController,
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
              title ?? " ",
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
        TextFormField(
          validator: validator,
          onChanged: onChanged,
          keyboardType: textInputType,
          obscureText: obscureText,
          cursorColor: Colors.black,
          controller: textEditingController,
          
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            contentPadding: EdgeInsets.all(getProportionateScreenWidth(12.0)),
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
      ],
    );
  }
}
