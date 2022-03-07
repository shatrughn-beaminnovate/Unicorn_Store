import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../size_config.dart';

// ignore: must_be_immutable
class LoadingIndicatorBar extends StatelessWidget {
  LoadingIndicatorBar({Key? key}) : super(key: key);

  List<Color> kDefaultRainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  @override
  Widget build(BuildContext context) {
        SizeConfig().init(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(130)),
        child: Center(
            child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: kDefaultRainbowColors,
        )),
      ),
    );
  }
}
