import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../size_config.dart';
import '../../../constant.dart';

class TextFormFieldAndButton extends StatelessWidget {
  final String buttonTitle;
  final String hintText;
  final TextEditingController? controller;
  final Function()? onPress;
  final bool? errorBorder;
  final String? Function(String?)? validator;
  const TextFormFieldAndButton(
      {Key? key,
      required this.buttonTitle,
      required this.validator,
      this.errorBorder,
      required this.hintText,
      this.controller,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      SizedBox(
        //color: Colors.white,
        width: getProportionateScreenWidth(350),
        //height: getProportionateScreenHeight(63),
        child: TextFormField(
          validator: validator,
          cursorColor: Colors.black,
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: false,
            signed: true,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            isDense: true,
            hintStyle: TextStyle(
                color: const Color(0xFF6C757D),
                fontSize: getProportionateScreenWidth(13.0)),
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            border: (errorBorder!)
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  )
                : const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3.0))),
            enabledBorder: (errorBorder!)
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  )
                : const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: kDefaultBorderColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
            focusedBorder: (errorBorder!)
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  )
                : const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kDefaultSecondaryButtonColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
          ),
        ),
      ),
      Positioned(
        right: 0,
        child: SizedBox(
            width: getProportionateScreenWidth(80),
            height: 39,
            child: ElevatedButton(
              onPressed: onPress,
              style: ElevatedButton.styleFrom(
                primary: kDefaultSecondaryButtonColor, // background
                onPrimary: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(3.0),
                      bottomRight: Radius.circular(3.0)), // <-- Radius
                ), // foreground
              ),
              child: Text(
                buttonTitle,
                style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
              ),
            )),
      ),
    ]);
  }
}
