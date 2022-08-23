import 'package:flutter/material.dart';
import 'package:unicorn_store/UI/constant.dart';

// ignore: must_be_immutable
class LoadingIndicatorBar extends StatelessWidget {
  const LoadingIndicatorBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
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
