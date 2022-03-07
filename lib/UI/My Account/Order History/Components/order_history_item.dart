import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../constant.dart';
import '../order_details.dart';
import 'title_and_data.dart';

class OderHistoryItem extends StatelessWidget {
  const OderHistoryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, OrderDetails.id);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(getProportionateScreenHeight(20.0)),
            margin: EdgeInsets.only(bottom: getProportionateScreenHeight(20.0)),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(2.0))),
            child: Column(
              children: [
                const TitleAndData(
                  title: "Order ID: ",
                  data: "163395646710972",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                const TitleAndData(
                    title: "Items: ",
                    data:
                        "iPad mini 6th Generation, iPad 9th Generation, iPad Pro Apple M1 chip"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                const TitleAndData(
                    title: "Order Date: ", data: "23rd Dec, 2021"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                const TitleAndData(title: "Total Amount: ", data: "2,00,000"),
              ],
            ),
          ),
        ),
        Positioned(
            right: getProportionateScreenWidth(15.0),
            top: getProportionateScreenHeight(15.0),
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(2.0)),
              decoration: BoxDecoration(
                border: Border.all(color: kDefaultSecondaryButtonColor),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Text(
                "Delivered",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(15.0),
                    color: kDefaultSecondaryButtonColor),
              ),
            ))
      ],
    );
  }
}
