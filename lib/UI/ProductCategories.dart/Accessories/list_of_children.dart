import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_children.dart';
import 'package:unicorn_store/Data/Models/Category/NewCategory/category_data.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/Accessories/list_of_product.dart';

import '../../constant.dart';
import '../../size_config.dart';

class ListOfChildren extends StatefulWidget {
  static String id = "ListOfChildren";

  const ListOfChildren({Key? key}) : super(key: key);

  @override
  State<ListOfChildren> createState() => _ListOfChildrenState();
}

class _ListOfChildrenState extends State<ListOfChildren> {
  // ignore: prefer_typing_uninitialized_variables
  var accessoriesData;

  List<CategoryData>? accessoriesChildren;

  String? imageHeader = "https://shop.unicornstore.in/uploads/images/medium/";

  @override
  Widget build(BuildContext context) {
    accessoriesData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    accessoriesChildren = accessoriesData["subcategoryData"];
    return Scaffold(
      appBar: const BuildAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(accessoriesData["name"],
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
                _buildAccessoriesChild(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccessoriesChild() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: accessoriesChildren!.length,
        itemBuilder: (context, index) {
          return (accessoriesChildren![index].enabled.toString() == "1")
              ? GestureDetector(
                  onTap: () {
                    if (accessoriesChildren![index].children!.isNotEmpty) {
                      Navigator.pushNamed(context, ListOfChildren.id,
                          arguments: {
                            "name": accessoriesChildren![index].name!,
                            "subcategoryData":
                                accessoriesChildren![index].children,
                            "token": accessoriesData["token"]
                          });
                    } else {
                      // Navigator.pushNamed(context, ListOfProduct.id,
                      //     arguments: {
                      //       "name": accessoriesChildren![index].name,
                      //       "productData": accessoriesChildren![index].,
                      //       "token": accessoriesData["token"]
                      //     });
                    }
                  },
                  child: Column(
                    children: [
                      CachedNetworkImage(
                          height: getProportionateScreenHeight(200),
                          width: getProportionateScreenWidth(200),
                          imageUrl:
                              "$categoryImageUrl${accessoriesChildren![index].image}",
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => const Image(
                              image: AssetImage("assets/NoImage.jpg"))),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      Text(
                        accessoriesChildren![index].name!,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(18.0),
                            color: Colors.black),
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
                )
              : Container();
        });
  }
}
