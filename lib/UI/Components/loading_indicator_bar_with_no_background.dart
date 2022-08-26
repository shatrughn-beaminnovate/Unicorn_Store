import 'package:flutter/material.dart';

import '../constant.dart';

class LoadingIndicatorBarWithNoBackground extends StatelessWidget {
  const LoadingIndicatorBarWithNoBackground({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child:  Container(
          color: Colors.black54,
          child:const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5.0,
              color: kDefaultSecondaryButtonColor,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      );
  
  }
}