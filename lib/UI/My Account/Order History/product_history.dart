import 'package:flutter/material.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/size_config.dart';

import '../../constant.dart';
import 'Components/order_history_item.dart';
import 'reviews_and_ratings.dart';

class ProductHistory extends StatelessWidget {
  static String id = "ProductHistory_Page";
  const ProductHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ReviewAndRating.id);
                  },
                  child: Text("Order History",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(25.0),
                          color: kDefaultHeaderFontColor)),
                ),
                const Divider(
                  color: kDefaultBorderColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const OderHistoryItem();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
