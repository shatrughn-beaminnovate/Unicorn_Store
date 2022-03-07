import 'package:flutter/material.dart';
import 'package:unicorn_store/UI/size_config.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/constant.dart';
import 'Components/product_with_cart.dart';

class AddToCartPage extends StatelessWidget {
  static String id = "AddToCartPage_Screen";

  const AddToCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BuildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Cart",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: kDefaultHeaderFontColor),
                ),
                const Divider(
                  color: kDefaultBorderColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),


              //  const ShowWhenCartIsEmpty(),

               const ProductWithCart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
