// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';


import '../../size_config.dart';
import '../../constant.dart';
import 'Components/order_details.dart';

class CheckoutPage extends StatefulWidget {
  static String id = "CheckoutPage_Screen";
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? dropdownValueForCountry;
  String? dropdownValueForState;

  bool expanded = false;
  bool expanded1 = false;

  String? radioBtnValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BuildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Checkout",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(20.0),
                        color: kDefaultHeaderFontColor)),
                const Divider(
                  color: kDefaultBorderColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),

             
             //  BillingAddress(),

                //  ShippingAddress(),

                //  PaymentMethod(),

                //  ConfirmOrder(),

                const OrderDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
