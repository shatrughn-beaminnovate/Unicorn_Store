import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/type_images.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';
import 'package:unicorn_store/UI/LoginPage/Components/custom_submit_button.dart';
import 'package:unicorn_store/UI/size_config.dart';
import '../constant.dart';

class ProductPage extends StatefulWidget {
  static String id = "ProductPage";
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  dynamic accessoriesProduct;

  String? imageSrc = " ";

  // ignore: prefer_typing_uninitialized_variables
  var accessoriesData;


  @override
  Widget build(BuildContext context) {
    accessoriesData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    accessoriesProduct = accessoriesData["productDetails"];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BuildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child: Column(
              children: [
                Text(accessoriesProduct!.name!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.5,
                        overflow: TextOverflow.ellipsis,
                        fontSize: getProportionateScreenWidth(20.0),
                        color: kDefaultHeaderFontColor)),
                const Divider(
                  color: kDefaultBorderColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
                Stack(
                  children: [
                    //Product Details
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        //Primary Image
                        CachedNetworkImage(
                          height: getProportionateScreenHeight(300),
                          width: getProportionateScreenWidth(300),
                          imageUrl: (imageSrc == " ")
                              ? "$imageDefaultURL$imageSecondUrl${getPrimaryImageSrc(accessoriesProduct!.images)}"
                              : imageSrc!,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => SizedBox(
                            height: getProportionateScreenHeight(300),
                            width: getProportionateScreenWidth(300),
                            child: const Image(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/NoImage.jpg"),
                            ),
                          ),
                        ),

                        (accessoriesProduct!.quantity! <= 0)
                            ? Text(
                                "OUT OF STOCK",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(20.0),
                                  color: Colors.red,
                                ),
                              )
                            : Container(),

                        SizedBox(
                          height: getProportionateScreenHeight(30.0),
                        ),

                        //List Of Images
                        Container(
                          height: getProportionateScreenHeight(70.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(15.0)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: accessoriesProduct!.images!.length,
                              itemBuilder: (context, index) {
                                return _buildImageList(
                                    accessoriesProduct!.images!, index);
                              }),
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(30.0),
                        ),

                        //Product Title
                        Text(
                          accessoriesProduct!.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: getProportionateScreenWidth(20.0),
                              color: kDefaultTitleColor),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15.0),
                        ),

                        //Product Description
                        Text(
                          accessoriesProduct!.description!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: getProportionateScreenWidth(15.0),
                              color: kDefaultTitleFontColor),
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(15.0),
                        ),

                        //Sales Price of product
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Price: ",
                              style: TextStyle(
                                  color: kDefaultTitleFontColor,
                                  fontSize: getProportionateScreenWidth(15.0)),
                            ),
                            PriceTag(
                              price: accessoriesProduct!.saleprice.toString(),
                              color: Colors.black,
                            ),
                          ],
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(15.0),
                        ),

                        //MRP of product
                        (accessoriesProduct!.saleprice !=
                                accessoriesProduct!.price && accessoriesProduct!.price!=0)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "MRP: ",
                                    style: TextStyle(
                                        color: kDefaultTitleFontColor,
                                        fontSize:
                                            getProportionateScreenWidth(12.0)),
                                  ),
                                  PriceTag(
                                    price: accessoriesProduct!.price.toString(),
                                    textDecoration: TextDecoration.lineThrough,
                                    color: kDefaultTitleFontColor,
                                  ),
                                ],
                              )
                            : Container(),
                        (accessoriesProduct!.saleprice !=
                                accessoriesProduct!.price)
                            ? SizedBox(
                                height: getProportionateScreenHeight(15.0),
                              )
                            : Container(),

                        //Product Discount
                        (accessoriesProduct!.discount.toString() != "0")
                            ? Column(
                                children: [
                                  Text(
                                    "${accessoriesProduct!.discount.toString()}% Off",
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(15.0),
                                        color: Colors.green),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(15.0),
                                  ),
                                ],
                              )
                            : Container(),

                        (accessoriesProduct!.quantity! <= 0)
                            ? LoginButton(
                                title: "Notify Me When Available",
                                color: kDefaultSecondaryButtonColor,
                                onPress: () {})
                            : LoginButton(
                                title: "Buy Now",
                                color: kDefaultSecondaryButtonColor,
                                onPress: () {},
                              ),

                        //***************Description*****************//
                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: const Border(
                              top: BorderSide(
                                  width: 1, color: kDefaultBorderColor),
                              bottom: BorderSide(
                                  width: 1, color: kDefaultBorderColor),
                            ),
                          ),
                          child: Text(
                            "Description",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(18.0),
                                color: kDefaultTitleColor),
                          ),
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(15.0),
                        ),

                        //Description Page
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            accessoriesProduct!.description!,
                            style: TextStyle(
                                height: 1.5,
                                fontSize: getProportionateScreenWidth(15.0),
                                color: kDefaultTitleFontColor),
                          ),
                        ),
                      ],
                    ),

                    //Add to Wishlist Icon
                    Positioned(
                      top: getProportionateScreenHeight(0.0),
                      right: getProportionateScreenWidth(10.0),
                      child: Icon(
                        Icons.favorite_border,
                        color: kDefaultSecondaryButtonColor,
                        size: getProportionateScreenHeight(25.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? getPrimaryImageSrc(List<TypeImages>? images) {
    String? path;
    for (var element in images!) {
      if (element.primary == true && element.primary != null) {
        path = element.filename!;
      }
    }
    return path;
  }

  //This is list of Product Images
  Widget _buildImageList(List<TypeImages> _typeImages, int index) {
    return InkWell(
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: () {
        setState(() {
          imageSrc = "$imageDefaultURL$imageSecondUrl${_typeImages[index].filename}";
        });
      },
      child: Container(
        // height: getProportionateScreenHeight(60.0),
        width: getProportionateScreenWidth(130.0),
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        margin: EdgeInsets.only(left: getProportionateScreenWidth(5.0)),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: kDefaultBorderColor)),
        child: CachedNetworkImage(
            imageUrl: "$imageDefaultURL$imageSecondUrl${_typeImages[index].filename}",
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => const Image(
                  image: AssetImage("assets/NoImage.jpg"),
                  height: 200,
                )),
      ),
    );
  }
}
