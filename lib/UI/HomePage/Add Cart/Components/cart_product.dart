import 'package:flutter/material.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';

import '../../../size_config.dart';
import '../../../constant.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Header Image and title
        Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(5.0)),
          height: getProportionateScreenHeight(100.0),
          width: getProportionateScreenWidth(100.0),
          decoration:
              BoxDecoration(border: Border.all(color: kDefaultBorderColor)),
          child: const Image(
            fit: BoxFit.fill,
            image: AssetImage("assets/BestSellerImages/iphone11.jpeg"),
          ),
        ),
        SizedBox(
          height: getProportionateScreenWidth(15.0),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15.0)),
          child: Text(
            "MYTH SLEEVES 13 GRANITE BLACK",
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15.0), height: 1.5),
          ),
        ),

        //Price Tag
        Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(15.0),
            ),
            Text(
              "Offers Available",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15.0),
                  color: Colors.green),
            ),
            SizedBox(
              height: getProportionateScreenHeight(15.0),
            ),
            Text(
              "Price",
              style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5.0),
            ),
           const PriceTag(
              price: "2,519",
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(20.0),
        ),

        //Quantity
        Column(
          children: [
            Text(
              "Quantity",
              style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {

                      setState(() {
                        
                        counter++;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      size: getProportionateScreenHeight(25.0),
                    )),
                Container(
                  alignment: Alignment.center,
                  height: getProportionateScreenHeight(35.0),
                  width: getProportionateScreenWidth(45.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: kDefaultBorderColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    "$counter",
                    style:
                        TextStyle(fontSize: getProportionateScreenWidth(15.0)),
                  ),
                ),
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        if(counter==1)
                        {}
                        else
                        {
                        counter--; 
                        }
                      });
                    },
                    icon: Icon(
                      Icons.remove_rounded,
                      size: getProportionateScreenHeight(25.0),
                    )),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(5.0),
            ),
            Text(
              "Remove From Cart",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: getProportionateScreenWidth(12.0)),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(20.0),
        ),

        //Sub-Total
        Column(
          children: [
            Text(
              "Sub-Total",
              style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5.0),
            ),
          const  PriceTag(
              price: "2,519",
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(25.0),
        ),

        const Divider(
          color: kDefaultBorderColor,
          thickness: 1,
        ),
      ],
    );
  }
}
