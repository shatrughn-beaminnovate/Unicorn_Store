import 'package:flutter/material.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';

import '../../../size_config.dart';
import '../../../constant.dart';
import 'title_and_data.dart';

class ItemsInsideSingleOrder extends StatelessWidget {
  const ItemsInsideSingleOrder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 150,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(15.0)),
      padding: EdgeInsets.all(getProportionateScreenHeight(10.0)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kDefaultBorderColor),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(90.0),
            width: getProportionateScreenWidth(90.0),

            // decoration: BoxDecoration(
            //     border: Border.all(color: kDefaultBorderColor)),
            child: const Image(
              fit: BoxFit.fill,
              image: AssetImage("assets/BestSellerImages/macbook.jpeg"),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "21.5-inch iMac with Retina 4K display",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      height: 1.5, fontSize: getProportionateScreenWidth(15.0)),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                const TitleAndData(title: "OTY: ", data: "5"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
               const TitleAndData(
                  title: "Amount: ",
                  priceTag: PriceTag(
                    price: "1,00,500",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
