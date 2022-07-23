import 'package:flutter/material.dart';
import 'package:unicorn_store/UI/My%20Account/Checkout%20Page/billing_address.dart';
import 'package:unicorn_store/UI/size_config.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';
import '../../../constant.dart';
import 'cart_product.dart';
import 'text_form_field_with_button.dart';

class ProductWithCart extends StatelessWidget {
  const ProductWithCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //List of Card Product
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder:(context,index){
          return const CartProduct();
        }),
       

        //************Order Summary*******//
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(getProportionateScreenWidth(10.0)),
          decoration: BoxDecoration(
            border: Border.all(color: kDefaultBorderColor),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: kDefaultBorderColor),
                  ),
                ),
                child: Text(
                  "Order Summary",
                  style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0)),
                        ),
                        const Spacer(),
                       const PriceTag(price: "2519")
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10.0),
                    ),
                    Text(
                      "* Inclusive of all taxes",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12.0),
                          color: Colors.green),
                    ),
                    const Divider(
                      color: kDefaultBorderColor,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10.0),
                    ),
                    //Pin Check out Input
                    const TextFormFieldAndButton(
                      buttonTitle: "Check",
                      hintText: "Enter Pincode",
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10.0),
                    ),

                    //Continue Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, BillingAddress.id);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kDefaultSecondaryButtonColor, // background
                          onPrimary: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3.0),
                            ), // <-- Radius
                          ), // foreground
                        ),
                        child: Text(
                          "Continue Checkout",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        //****************Coupon Discount**************//
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(getProportionateScreenWidth(10.0)),
          decoration: BoxDecoration(
            border: Border.all(color: kDefaultBorderColor),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: kDefaultBorderColor),
                  ),
                ),
                child: Text(
                  "Coupon Discount",
                  style: TextStyle(fontSize: getProportionateScreenWidth(15.0)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Coupon code Input Field
                    const TextFormFieldAndButton(
                      buttonTitle: "Apply",
                      hintText: "Enter Coupon Code",
                    ),

                    SizedBox(
                      height: getProportionateScreenHeight(5.0),
                    ),
                    const Divider(
                      color: kDefaultBorderColor,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15.0),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_sharp,
                          size: getProportionateScreenHeight(20.0),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(5.0),
                        ),
                        Text(
                          "Need any help?",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5.0),
                    ),
                    Row(
                      children: [
                        Text(
                          "Speak to Our e-commerce specialist :",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12.0)),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(5),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_sharp,
                              size: getProportionateScreenHeight(13.0),
                              color: Colors.green,
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "18002677888",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(13.0),
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
