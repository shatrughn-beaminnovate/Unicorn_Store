import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_product.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/type_images.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';
import 'package:unicorn_store/UI/ProductPage/product_page.dart';

import '../../constant.dart';
import '../../size_config.dart';

// ignore: must_be_immutable
class ListOfProduct extends StatelessWidget {
  static String id = "ListOfProduct";
  ListOfProduct({Key? key}) : super(key: key);

  //Load accessories data
  // ignore: prefer_typing_uninitialized_variables
  var accessoriesData;

  List<AccessoriesProduct>? accessoriesProduct;

  String? imageHeader = "https://shop.unicornstore.in/uploads/images/medium/";


  @override
  Widget build(BuildContext context) {
    accessoriesData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;


    return Scaffold(
      appBar: const BuildAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child: Column(
              children: [
                Text(accessoriesData["name"],
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(25.0),
                        color: kDefaultHeaderFontColor)),
                const Divider(
                  color: kDefaultBorderColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
                _buildListOfProduct()
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? getPrimaryImageSrc(List<TypeImages>? images)
  {
     String? path;
     for (var element in images!) {

       if(element.primary==true && element.primary!=null)
       {
           path=element.filename!;
       }
      }

    return path;
  }

  Widget _buildListOfProduct() {
    accessoriesProduct = accessoriesData["productData"];

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: accessoriesProduct!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
                  Navigator.pushNamed(context, ProductPage.id,arguments: {
                    "productDetails":accessoriesProduct![index],
                    "token":accessoriesData["token"],
                  });
            },
            child: Column(
              children: [
                     CachedNetworkImage(
                      height: getProportionateScreenHeight(200),
                      width: getProportionateScreenWidth(200),
                      imageUrl: "$imageHeader${getPrimaryImageSrc(accessoriesProduct![index].images)}",
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) =>
                          const Image(image: AssetImage("assets/NoImage.jpg"))),
     
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
                Text(
                  accessoriesProduct![index].name!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(18.0),
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Starting from',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15.0),
                          color: kDefaultTitleFontColor),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10.0),
                    ),
                     PriceTag(
                      price: accessoriesProduct![index].saleprice.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                const Divider(
                  color: kDefaultBorderColor,
                  thickness: 1,
                ),
              ],
            ),
          );
        });
  }
}
