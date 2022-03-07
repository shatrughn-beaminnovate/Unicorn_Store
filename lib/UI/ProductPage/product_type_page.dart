// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/my_account/Wishlist/Wishlist%20Product%20Details/wishlist_product_details_fetching_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/product/product%20page%20details/product_page_details_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/product/product_details_api_fetch_bloc.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Login/login_data.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Page/product_page_details.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/option_values.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/product_details.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/related_products.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/type_details.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/type_images.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/types_options.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';
import 'package:unicorn_store/UI/HomePage/Components/third_header_text.dart';
import 'package:unicorn_store/UI/size_config.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/HomePage/Components/header_text.dart';
import 'package:unicorn_store/UI/LoginPage/Components/custom_submit_button.dart';
import 'package:unicorn_store/UI/text_file.dart';
import '../constant.dart';
import 'Components/accessories_product_item.dart';
import 'Components/emi_option.dart';
import 'Components/notify_me_form.dart';
import 'Components/product_description.dart';

class ProductDetailsScreen extends StatefulWidget {
  static String id = "ProductDetails_Screen";
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  String? imageSrc = " ";
  bool expanded = false;
  TabController? _controller;
  Map<String, String> selectedIndex = <String, String>{};

  bool productPageFlag = false;

  //creating flag for wishlist button
  bool favoriteFlag = false;

  //Creating object for a bloc
  final ProductDetailsApiFetchBloc _productDetailsApiFetchBloc =
      ProductDetailsApiFetchBloc();
  final ProductPageDetailsBloc _productPageDetailsBloc =
      ProductPageDetailsBloc();
  late AuthenticationBloc authenticationBloc;
  final WishlistProductDetailsFetchingBloc wishlistProductDetailsFetchingBloc =
      WishlistProductDetailsFetchingBloc();

  ProductTypeDetails? productTypeDetails;
  dynamic productPageDetail;

  String? radioButtonValue;

  bool isProgress = false;

  //Creating instance for logged in user data
  LoginData? loginData;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    final productDetailsId = ModalRoute.of(context)!.settings.arguments as int;
    _productDetailsApiFetchBloc.add(LoadProductDetailsApiFetch(
        productDetailsId: productDetailsId.toString()));
    super.didChangeDependencies();
  }

  String? getPrimaryImageSrc(List<TypeImages> images) {
    String? path;
    for (var element in images) {
      if (element.primary == true && element.primary != null) {
        path = element.filename!;
      }
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BuildAppBar(),
      body: Stack(
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => _productDetailsApiFetchBloc,
              ),
              BlocProvider(
                create: (context) => _productPageDetailsBloc,
              ),
            ],
            child: BlocListener<ProductDetailsApiFetchBloc,
                ProductDetailsApiFetchState>(
              listener: (context, state) {
                if (state is ProductDetailsApiFetchLoaded) {
                  setState(() {
                    productTypeDetails = state.productTypeDetails;
                  });
                }
              },
              child: BlocBuilder<ProductDetailsApiFetchBloc,
                  ProductDetailsApiFetchState>(
                builder: (context, state) {
                  if (state is ProductDetailsApiFetchInitial) {
                    return LoadingIndicatorBar();
                  } else if (state is ProductDetailsApiFetchLoading) {
                    return LoadingIndicatorBar();
                  } else if (state is ProductDetailsApiFetchLoaded) {
                    return _buildProductDetailsPage(context);
                  } else if (state is ProductDetailsApiFetchError) {
                    return const Center(
                      child: Text("No Product Details Found"),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
          (isProgress) ? LoadingIndicatorBar() : Center()
        ],
      ),
    );
  }

  //Product Details Page
  Widget _buildProductDetailsPage(BuildContext context) {
    List<TypesOptions>? _typeOption = productTypeDetails!.data!.typeOptions;
    List<TypeImages>? _typeImages = productTypeDetails!.data!.typeImages;
    List<RelatedProduct>? _relatedProduct =
        productTypeDetails!.data!.relatedProduct;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(15.0)),
        child: Column(
          children: [
            Text(productTypeDetails!.data!.typesName.toString(),
                style: TextStyle(
                    height: 1.5,
                    fontSize: getProportionateScreenWidth(20.0),
                    color: kDefaultHeaderFontColor)),
            const Divider(
              color: kDefaultBorderColor,
              thickness: 1,
            ),

            BlocListener<ProductPageDetailsBloc, ProductPageDetailsState>(
              listener: (context, state) {
                if (state is ProductPageDetailsLoading) {
                  setState(() {
                    isProgress = true;
                  });
                } else if (state is ProductPageDetailsLoaded) {
                  setState(() {
                    productPageFlag = true;
                    productPageDetail = state.productPageDetail;
                    isProgress = false;
                  });
                }
              },
              child:
                  BlocBuilder<ProductPageDetailsBloc, ProductPageDetailsState>(
                builder: (context, state) {
                  // if (state is ProductPageDetailsLoading) {
                  //   return _buildLoading();
                  // } else
                  if (state is ProductPageDetailsLoaded) {
                    return _buildProductData(_typeImages,
                        productTypeDetails!.data, _typeOption, context);
                  } else {
                    return _buildProductData(_typeImages,
                        productTypeDetails!.data!, _typeOption, context);
                  }
                },
              ),
            ),

            //***************Add on Accessories************
            HeaderText(header: "Add on Accessories"),

            SizedBox(
              height: getProportionateScreenWidth(320),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _relatedProduct!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return AccessoriesProductItem(
                      relatedProduct: _relatedProduct[index],
                    );
                  }),
            ),

            //***************Description*****************/
            SizedBox(
              height: getProportionateScreenHeight(25.0),
            ),

            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: const Border(
                  top: BorderSide(width: 1, color: kDefaultBorderColor),
                  bottom: BorderSide(width: 1, color: kDefaultBorderColor),
                ),
              ),
              child: TabBar(
                controller: _controller,
                indicatorColor: Colors.grey,
                labelColor: kDefaultTitleFontColor,
                labelStyle: TextStyle(
                  fontSize: getProportionateScreenWidth(15.0),
                ),
                tabs: const [
                  Tab(
                    text: 'Description',
                  ),
                  Tab(
                    text: 'Overview',
                  ),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 60 / 100,
              child: TabBarView(controller: _controller, children: [
                ProductDescription(
                  descriptionData: productTypeDetails!.data!.typesDescription,
                ),
                ProductDescription(
                  descriptionData: productTypeDetails!.data!.typesDescription,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  //This is widget for show product details
  Widget _buildProductData(
      List<TypeImages>? _typeImages,
      ProductDetails? productDetails,
      List<TypesOptions>? _typeOption,
      BuildContext context) {
    return Column(
      children: [
        //Primary Image of the Product
        (productPageDetail != "failed")
            ? Column(
                children: [
                  (productPageFlag && productPageDetail.toString().isNotEmpty)
                      ? Stack(
                          children: [
                            CachedNetworkImage(
                                width: getProportionateScreenWidth(300.0),
                                height: getProportionateScreenHeight(300.0),
                                imageUrl:
                                    "$imageDefaultURL$imageSecondUrl${productPageDetail!.product.images[0].filename!}",
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) =>
                                    const Image(
                                        image:
                                            AssetImage("assets/NoImage.jpg"))),

                            //Add to Wishlist Icon
                            BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, state) {
                                if (state is AuthenticationAuthenticated) {
                                  loginData = state.loginData;

                                  return BlocProvider(
                                    create: (context) =>
                                        wishlistProductDetailsFetchingBloc,
                                    child: BlocBuilder<
                                        WishlistProductDetailsFetchingBloc,
                                        WishlistProductDetailsFetchingState>(
                                      builder: (context, state) {
                                        return Positioned(
                                          top: getProportionateScreenHeight(
                                              10.0),
                                          right:
                                              getProportionateScreenWidth(0.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                favoriteFlag = !favoriteFlag;
                                              });
                                              if (favoriteFlag) {
                                                 wishlistProductDetailsFetchingBloc.add(AddOrDeleteProductFromWishlistEvent(customerId:loginData!.userData!.id.toString(), productId:"", token: loginData!.token!));
                                              }
                                            },
                                            child: Icon(
                                              (favoriteFlag)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:
                                                  kDefaultSecondaryButtonColor,
                                              size:
                                                  getProportionateScreenHeight(
                                                      25.0),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return Positioned(
                                  top: getProportionateScreenHeight(10.0),
                                  right: getProportionateScreenWidth(0.0),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: kDefaultSecondaryButtonColor,
                                    size: getProportionateScreenHeight(25.0),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : CachedNetworkImage(
                          width: getProportionateScreenWidth(300.0),
                          height: getProportionateScreenHeight(300.0),
                          imageUrl: (imageSrc == " ")
                              ? "$imageDefaultURL$imageSecondUrl${getPrimaryImageSrc(_typeImages!)}"
                              : imageSrc!,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => const Image(
                              image: AssetImage("assets/NoImage.jpg"))),

                  (productPageDetail != "failed" &&
                          productPageDetail.toString().isNotEmpty)
                      ? Column(
                          children: [
                            (productPageFlag &&
                                    productPageDetail!.product.quantity! <= 0)
                                ? Text(
                                    "OUT OF STOCK",
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(20.0),
                                      color: Colors.red,
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: getProportionateScreenHeight(15.0),
                            ),
                            (productPageFlag)
                                ? Column(
                                    children: [
                                      //Product Title
                                      Center(
                                        child: Text(
                                          productPageDetail!.product.name
                                              .toString(),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      18.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(10.0),
                                      ),

                                      //Sales price and price
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          (productPageDetail!.product.price
                                                      .toString() !=
                                                  productPageDetail!
                                                      .product.saleprice
                                                      .toString())
                                              ? PriceTag(
                                                  price: productPageDetail!
                                                      .product.price
                                                      .toString(),
                                                  color: kDefaultTitleFontColor,
                                                  textDecoration: TextDecoration
                                                      .lineThrough,
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: getProportionateScreenWidth(
                                                10.0),
                                          ),
                                          PriceTag(
                                            price: productPageDetail!
                                                .product.saleprice
                                                .toString(),
                                            color: Colors.black,
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(10.0),
                                      ),

                                      //Price with cashback
                                      (productPageDetail!
                                                  .product.affordability ==
                                              1)
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Price with Cashback: ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  15.0)),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              10.0),
                                                    ),
                                                    PriceTag(
                                                      price: (productPageDetail!
                                                                  .product
                                                                  .saleprice! -
                                                              productPageDetail!
                                                                  .product
                                                                  .cashback!)
                                                          .toString(),
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10.0),
                                                ),
                                              ],
                                            )
                                          : Container(),

                                      (productPageDetail!.product.discount! > 0)
                                          ? Text(
                                              "${productPageDetail!.product.discount}% off",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          15.0),
                                                  color: Colors.green),
                                            )
                                          : Container(),
                                    ],
                                  )
                                : Container(),
                          ],
                        )
                      : Container(),

                  SizedBox(
                    height: getProportionateScreenHeight(15.0),
                  ),

                  //Product Image Slide Show
                  (productPageFlag && productPageDetail != "failed")
                      ? Container(
                          height: getProportionateScreenHeight(60.0),
                          width: getProportionateScreenWidth(100.0),
                          margin: EdgeInsets.only(
                              left: getProportionateScreenWidth(10.0)),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: kDefaultBorderColor)),
                          child: CachedNetworkImage(
                              imageUrl:
                                  "$imageDefaultURL$imageSecondUrl${productPageDetail!.product.images[0].filename!}",
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) => const Image(
                                  image: AssetImage("assets/NoImage.jpg"))),
                        )
                      : Container(
                          height: getProportionateScreenHeight(60.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(15.0)),
                          child: ListView.builder(
                            itemCount: _typeImages!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (_typeImages[index].primary == true) {
                                imageSrc =
                                    "$imageDefaultURL$imageSecondUrl${_typeImages[index].filename}";

                                return _buildImageList(_typeImages, index);
                              }
                              return _buildImageList(_typeImages, index);
                            },
                          ),
                        ),

                  SizedBox(
                    height: getProportionateScreenHeight(25.0),
                  ),
                ],
              )
            : SizedBox(
                height: getProportionateScreenHeight(300),
                child: Center(
                  child: Text(
                    "This Product Not Avaiable at This Time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: getProportionateScreenWidth(18.0)),
                  ),
                ),
              ),

        //Product Title
        Center(
          child: Text(
            productDetails!.typesName.toString(),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontSize: getProportionateScreenWidth(18.0)),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(45.0),
        ),

        //Select Product Color and other Details
        ListView.builder(
          itemCount: _typeOption!.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            List<OptionValues>? optionValues = _typeOption[index].optionValues;
            return Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: ThirdHeaderText(
                      thirdHeader:
                          "${index + 1}. ${_typeOption[index].name.toString()}"),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10.0),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: optionValues!.map((e) {
                      if (e.color!.isNotEmpty) {
                        //var colorIndex = optionValues.indexOf(e);
                        return _buildColorContainer(
                            e,
                            index,
                            _typeOption.length,
                            productDetails.typesId.toString());
                      } else {
                        return _buildDataContainer(e, index, _typeOption.length,
                            productDetails.typesId.toString());
                      }
                    }
                        // (e) => (e.color!.isNotEmpty)
                        //     ? _buildColorContainer(
                        //         e.name, e.color?.substring(1))
                        //     : _buildDataContainer(e.name),
                        ).toList(),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
              ],
            );
          },
        ),

        //Cash Back Offers and Emi Details
        (productPageFlag && productPageDetail != "failed")
            ? Column(
                children: [
                  (productPageDetail!.product.affordability == 1)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Cashback Offers",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: getProportionateScreenWidth(18.0)),
                          ),
                        )
                      : Container(),

                  (productPageDetail!.product.affordability == 1)
                      ? SizedBox(
                          height: getProportionateScreenHeight(15.0),
                        )
                      : Container(),

                  (productPageDetail!.product.affordability == 1)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Cashback up to ₹4,000.00",
                            style: TextStyle(
                                color: kDefaultTitleFontColor,
                                fontSize: getProportionateScreenWidth(15.0)),
                          ),
                        )
                      : Container(),
                  (productPageDetail!.product.quantity! <= 0)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: LoginButton(
                              title: "Notify Me When Available",
                              color: kDefaultSecondaryButtonColor,
                              onPress: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return NotifyMeForm();
                                  },
                                );
                              }),
                        )
                      : Container(),

                  //Buy with exchange and without exchange
                  // Column(
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(5.0)),
                  //           border: Border.all(color: kDefaultBorderColor)),
                  //       child: Row(
                  //         children: [
                  //           Radio<String>(
                  //             value: "1",
                  //             groupValue: radioButtonValue,
                  //             onChanged: (String? value) {
                  //               setState(() {
                  //                 radioButtonValue = value;
                  //               });
                  //             },
                  //           ),
                  //           Text(
                  //             "Buy without Exchange",
                  //             style: TextStyle(
                  //                 fontSize: getProportionateScreenHeight(15.0)),
                  //           ),
                  //           Spacer(),
                  //           PriceTag(
                  //             price: "79,900",
                  //             fontSize: getProportionateScreenWidth(15.0),
                  //             priceSuffixFontSize:
                  //                 getProportionateScreenWidth(15.0),
                  //           ),
                  //           SizedBox(
                  //             width: getProportionateScreenWidth(15.0),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  //add to cart and emi button
                  Row(
                    children: [
                      (productPageDetail!.product.quantity! <= 0)
                          ? Container()
                          : LoginButton(
                              title: "Add to Cart",
                              color: kDefaultSecondaryButtonColor,
                              onPress: () {
                                Navigator.pushNamed(context, TextFile.id);
                              }),
                      (productPageDetail!.product.quantity! <= 0)
                          ? Container()
                          : SizedBox(
                              width: getProportionateScreenHeight(15.0),
                            ),
                      (productPageDetail!.product.emiOptions!.isNotEmpty)
                          ? SizedBox(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    expanded = !expanded;
                                  });
                                },
                                icon: Text(
                                  "EMI Available",
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(15.0)),
                                ),
                                label: expanded
                                    ? RotatedBox(
                                        quarterTurns: 225,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: getProportionateScreenHeight(
                                              12.0),
                                        ),
                                      )
                                    : Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size:
                                            getProportionateScreenHeight(12.0),
                                      ),
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF0069D9),
                                  onPrimary: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ), // <-- Radius
                                  ), // foreground
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),

                  //Animated table for emi option
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: (expanded) ? getProportionateScreenWidth(210) : 0,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: EmiTable(
                        emiTableHtml:
                            productPageDetail!.product.emiOptions.toString(),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  //This is list of Product Images
  Widget _buildImageList(List<TypeImages> _typeImages, int index) {
    return InkWell(
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: () {
        setState(() {
          imageSrc =
              "$imageDefaultURL$imageSecondUrl${_typeImages[index].filename}";
        });
      },
      child: Container(
        height: getProportionateScreenHeight(60.0),
        width: getProportionateScreenWidth(100.0),
        margin: EdgeInsets.only(left: getProportionateScreenWidth(10.0)),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: kDefaultBorderColor)),
        child: CachedNetworkImage(
            imageUrl:
                "$imageDefaultURL$imageSecondUrl${_typeImages[index].filename}",
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage("assets/NoImage.jpg"))),
      ),
    );
  }

  //Select Product Data
  Widget _buildDataContainer(
      OptionValues optionValues, int index, int length, String typeId) {
    return SelectableContainer(
      //selected: true,
      selected:
          (selectedIndex[index.toString()].toString() == optionValues.value)
              ? true
              : false,
      marginColor: Colors.white,
      onValueChanged: (_) {
        setState(() {
          selectedIndex[index.toString()] = optionValues.value.toString();
        });
        if (selectedIndex.keys.length == length) {
          //adding bloc event
          _productPageDetailsBloc.add(LoadProductDataBasedOnValueEvent(
              productValue: selectedIndex, productId: typeId));
        }
      },
      child: Text(
        optionValues.name ?? "",
        style: TextStyle(
            fontSize: getProportionateScreenWidth(15.0),
            color: kDefaultHeaderFontColor),
      ),
      padding: 10,
      iconSize: 12,
      borderRadius: 3,
      borderSize: 1,
      unselectedOpacity: 0.9,
      unselectedBorderColor: kDefaultBorderColor,
    );
  }

  //Select Product Color
  Widget _buildColorContainer(
      OptionValues optionValues, int index, int length, String typeId) {
    return SelectableContainer(
      selected:
          (selectedIndex[index.toString()].toString() == optionValues.value)
              ? true
              : false,
      marginColor: Colors.white,
      onValueChanged: (_) {
        setState(() {
          selectedIndex[index.toString()] = optionValues.value.toString();
        });
        if (selectedIndex.keys.length == length) {
          _productPageDetailsBloc.add(LoadProductDataBasedOnValueEvent(
              productValue: selectedIndex, productId: typeId));
        }
      },
      child: SizedBox(
        width: getProportionateScreenWidth(80.0),
        child: Column(
          children: [
            Container(
              height: getProportionateScreenHeight(30.0),
              width: getProportionateScreenWidth(30.0),
              decoration: BoxDecoration(
                color:
                    Color(int.parse("0xFF${optionValues.color?.substring(1)}")),
                shape: BoxShape.circle,
              ),
            ),
            Text(
              optionValues.name ?? " ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15.0),
                  color: kDefaultHeaderFontColor),
            )
          ],
        ),
      ),
      padding: 7,
      iconSize: 12,
      borderRadius: 3,
      borderSize: 1,
      unselectedOpacity: 0.9,
      unselectedBorderColor: kDefaultBorderColor,
    );
  }
}
