import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/related_products.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';
import 'package:unicorn_store/UI/LoginPage/Components/custom_submit_button.dart';
import 'package:unicorn_store/UI/ProductPage/product_page.dart';

import '../../constant.dart';
import '../../size_config.dart';

// ignore: must_be_immutable
class AccessoriesProductItem extends StatelessWidget {
  AccessoriesProductItem({Key? key, required this.relatedProduct})
      : super(key: key);

  final RelatedProduct relatedProduct;
  //Image Fix Url
  String imageHeader =
      "http://192.168.1.9/shop.unicornstore.in/uploads/images/thumbnails/";

  // String imgSrc() {
  //   //var src;
  //   for (var i = 0; i <= relatedProduct.images!.length; i++) {
  //     var currentImgSrc = relatedProduct.images![i];

  //     // if (currentImgSrc.primary == true) {
  //     //   src = currentImgSrc.filename.toString();
  //     //   return src;
  //     // }
  //   }
  //   return "src";
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductPage.id,arguments: {
          "productDetails":relatedProduct
        });
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10.0)),
        width: getProportionateScreenWidth(280.0),
        padding: EdgeInsets.only(
            top: getProportionateScreenWidth(10.0),
            left: getProportionateScreenWidth(10.0),
            right: getProportionateScreenWidth(10.0)),
        decoration: BoxDecoration(
          border: Border.all(color: kDefaultBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(2.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: relatedProduct.images!.map((e) {
                if (e.primary == true) {
                  return CachedNetworkImage(
                      height: getProportionateScreenHeight(150.0),
                      width: getProportionateScreenWidth(150.0),
                      imageUrl: "$imageHeader${e.filename}",
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) =>
                          const Image(image: AssetImage("assets/NoImage.jpg")));
                }
    
                return Container();
              }).toList(),
            ),
            Text(
              relatedProduct.name.toString(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15.0),
                  overflow: TextOverflow.ellipsis),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Starting from",
                  style: TextStyle(
                      color: kDefaultTitleFontColor,
                      fontSize: getProportionateScreenWidth(14.0)),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10.0),
                ),
                PriceTag(price: relatedProduct.saleprice.toString())
              ],
            ),
            Column(
              children: [
                const Divider(
                  color: kDefaultBorderColor,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: (relatedProduct.quantity.toString() != "0")
                      ? LoginButton(
                          title: "Add to Cart",
                          onPress: () {},
                          color: const Color(0xFF1F99CF),
                        )
                      : TextButton(
                          child: Text(
                            "Out of Stock",
                            style: TextStyle(
                              color:const Color(0xFFDC3545),
                              fontWeight: FontWeight.w400,
                                fontSize: getProportionateScreenWidth(20.0)),
                          ),
                         
                          onPressed:(){}),
                        ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
