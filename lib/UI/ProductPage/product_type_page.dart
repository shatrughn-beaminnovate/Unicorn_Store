// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:unicorn_store/Business_Logic/bloc/cart/total%20product%20count/total_product_count_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/filter%20product/filter_single_product_details/filter_single_product_details_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/my_account/Wishlist/Wishlist%20Product%20Details/wishlist_product_details_fetching_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/product/product%20page%20details/product_page_details_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/product/product_details_api_fetch_bloc.dart';
import 'package:unicorn_store/Data/Models/Cart/View%20Cart/cart_product_data.dart';
import 'package:unicorn_store/Data/Models/Filter/Filter%20Product%20Details/filter_product_selected_attributes.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Login/login_data.dart';
import 'package:unicorn_store/Data/Models/Product/New%20Product%20Type/attributes_options.dart';
import 'package:unicorn_store/Data/Models/Product/New%20Product%20Type/product_attributes.dart';
import 'package:unicorn_store/Data/Models/Product/New%20Product%20Type/product_info_data.dart';
import 'package:unicorn_store/Data/Models/Product/New%20Product/single_product_data.dart';
import 'package:unicorn_store/Data/Models/Product/New%20Product/type_image.dart';
import 'package:unicorn_store/Data/Repositories/cart/add_to_local_cart_repository.dart';
import 'package:unicorn_store/UI/Components/default_snackbar.dart';
import 'package:unicorn_store/UI/Components/image_path.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar_with_no_background.dart';
import 'package:unicorn_store/UI/HomePage/Cart/add_to_cart.dart';
import 'package:unicorn_store/UI/HomePage/Components/third_header_text.dart';
import 'package:unicorn_store/UI/HomePage/Search%20Button/custom_search_delegate.dart';
import 'package:unicorn_store/UI/ProductPage/Components/button_with_icon.dart';
import 'package:unicorn_store/UI/main_screen.dart';
import 'package:unicorn_store/UI/size_config.dart';
import '../../Business_Logic/bloc/cart/add cart/adding_product_to_cart_bloc.dart';
import '../Components/linear_indicator.dart';
import '../HomePage/Components/price_tag.dart';
import '../LoginPage/Components/custom_submit_button.dart';
import '../constant.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  static String id = "ProductDetails_Screen";

  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  String? imageSrc = " ";
  bool expanded = false;
  // TabController? _controller;
  Map<String, String> selectedIndex = <String, String>{};

  bool productPageFlag = false;

  //creating flag for wishlist button
  bool favoriteFlag = false;

  //flag for already added to cart
  bool cartStatus = false;

  //Creating object for a bloc
  final ProductDetailsApiFetchBloc _productDetailsApiFetchBloc =
      ProductDetailsApiFetchBloc();
  final ProductPageDetailsBloc _productPageDetailsBloc =
      ProductPageDetailsBloc();
  late AuthenticationBloc authenticationBloc;
  final WishlistProductDetailsFetchingBloc wishlistProductDetailsFetchingBloc =
      WishlistProductDetailsFetchingBloc();
  final FilterSingleProductDetailsBloc filterSingleProductDetailsBloc =
      FilterSingleProductDetailsBloc();

  late AddingProductToCartBloc addingProductToCartBloc;

  late TotalProductCountBloc totalProductCountBloc;

  ProductInfoData? productInfoData;
  SingleProductData? singleProductData;

  String? productPageId;

  String? radioButtonValue;

  bool isProgress = false;

  //Back button check flag when wishlist product added by logout user
  bool wishlistBackbuttonFlag = false;

  //Creating instance for logged in user data
  LoginData? loginData;

  //Check which screen user comes from
  bool navigationScreen = false;

  //This will show product attributes
  List<ProductAttributes>? productAttributesList;

  List<FilterProductSelectedAttributes>? filterProductSelectedAttributes;

  String? token;
  bool? isAuthenticate;

  @override
  void initState() {
    addingProductToCartBloc = AddingProductToCartBloc(
        RepositoryProvider.of<AddToLocalCartRepository>(context));
    super.initState();
    // _controller = TabController(length: 2, vsync: this);
  }

  Map<String, String> generateSelectedAttributeValue(
      List<ProductAttributes> productAttributesList,
      List<FilterProductSelectedAttributes> filterProductSelectedAttributes) {
    Map<String, String> selectedAttribute = {};
    if (filterProductSelectedAttributes.isNotEmpty) {
      for (int i = 0; i < productAttributesList.length; i++) {
        selectedAttribute.addAll({
          i.toString():
              filterProductSelectedAttributes[i].integer_value.toString()
        });
      }
    }

    return selectedAttribute;
  }

  @override
  void didChangeDependencies() {
    // print("false");
    final productDetailsId =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productTypeSlug = productDetailsId["productTypeSlug"];
    token = productDetailsId["token"];
    navigationScreen = productDetailsId["filterProductData"];

    if (navigationScreen) {
      filterSingleProductDetailsBloc
          .add(LoadFilterSingleProductDetails(productTypeSlug));
    } else {
      _productDetailsApiFetchBloc.add(LoadProductDetailsApiFetch(
          productNameSlug: productTypeSlug.toString()));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    totalProductCountBloc = BlocProvider.of<TotalProductCountBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        // if (wishlistBackbuttonFlag) {
        //   Navigator.pushAndRemoveUntil(context,
        //       MaterialPageRoute(builder: (context) {
        //     return MainScreen(
        //       selectedIndex: 0,
        //     );
        //   }), (Route<dynamic> route) => false);
        //   return false;
        // }
        // Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
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
                BlocProvider(
                  create: (context) => filterSingleProductDetailsBloc,
                ),
                BlocProvider(
                  create: (context) => addingProductToCartBloc,
                ),
              ],
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    loginData = state.loginData;
                    token = loginData!.userData!.token;
                    isAuthenticate = true;
                  }
                  if (state is AuthenticationUnauthenticated) {
                    isAuthenticate = false;
                  }
                  return BlocListener<FilterSingleProductDetailsBloc,
                      FilterSingleProductDetailsState>(
                    listener: (context, state) {
                      if (state is FilterSingleProductDetailsLoading) {
                        setState(() {
                          isProgress = true;
                        });
                      }
                      if (state is FilterSingleProductDetailsLoaded) {
                        setState(() {
                          productPageFlag = true;
                          cartStatus = false;
                          isProgress = false;
                          singleProductData = SingleProductData(
                              true, state.filterProductInfo!.product);
                          productAttributesList =
                              state.filterProductInfo!.attributes;
                          filterProductSelectedAttributes =
                              state.filterProductInfo!.selected_attribute;
                          selectedIndex = generateSelectedAttributeValue(
                              productAttributesList!,
                              filterProductSelectedAttributes!);
                          // print(selectedIndex);
                        });
                      }
                      if (state is FilterSingleProductDetailsFailure) {
                        setState(() {
                          isProgress = false;
                        });
                      }
                    },
                    child: BlocListener<ProductDetailsApiFetchBloc,
                        ProductDetailsApiFetchState>(
                      listener: (context, state) {
                        if (state is ProductDetailsApiFetchLoaded) {
                          setState(() {
                            productInfoData = state.productTypeDetails;
                            productAttributesList =
                                productInfoData!.data!.attribute;
                            selectedIndex = generateSelectedAttributeValue(
                                productAttributesList!, []);
                            // print(selectedIndex);
                          });
                        }
                      },
                      child: BlocBuilder<FilterSingleProductDetailsBloc,
                          FilterSingleProductDetailsState>(
                        builder: (context, state) {
                          if (state is FilterSingleProductDetailsLoaded) {
                            productPageFlag = true;
                            return _buildProductDetailsPage(context);
                          }
                          if (state is FilterSingleProductDetailsFailure) {
                            return Center(child: Text(state.message!));
                          }
                          return BlocBuilder<ProductDetailsApiFetchBloc,
                              ProductDetailsApiFetchState>(
                            builder: (context, state) {
                              if (state is ProductDetailsApiFetchLoading) {
                                return LinearIndicatorBar();
                              } else if (state
                                  is ProductDetailsApiFetchLoaded) {
                                return _buildProductDetailsPage(context);
                              } else if (state is ProductDetailsApiFetchError) {
                                return const Center(
                                  child: Text("No Product Details Found"),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            (isProgress) ? LoadingIndicatorBarWithNoBackground() : Center()
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            (wishlistBackbuttonFlag)
                ? Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                    return MainScreen(
                      selectedIndex: 0,
                    );
                  }), (Route<dynamic> route) => false)
                : Navigator.of(context).pop();
          }),
      actions: [
        const Spacer(flex: 2),
        const Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Image(
                image: AssetImage("assets/unicornLogo.png"),
                fit: BoxFit.fitHeight,
              ),
            )),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Shopping_card Icon
                BlocBuilder<TotalProductCountBloc, TotalProductCountState>(
                  builder: (context, state) {
                    if (state is TotalProductCountLoaded) {
                      return InkWell(
                        onTap: () {
                          //  print("This is token: $token");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AddToCartPage(
                              token: token,
                            );
                          }));
                        },
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle),
                          child: Stack(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.shopping_cart_sharp,
                                    size: getProportionateScreenWidth(25),
                                    color: Colors.white,
                                  ),
                                  tooltip: 'Shopping_cart',
                                  onPressed: null),
                              Positioned(
                                right: 8,
                                top: 0,
                                child: Container(
                                  width: getProportionateScreenWidth(18.0),
                                  height: getProportionateScreenWidth(18.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.lightGreen,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Text(
                                    state.totalProductCount.message.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12.0)),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AddToCartPage(token: token);
                        }));
                      },
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.transparent, shape: BoxShape.circle),
                        child: Stack(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Icon(
                                  Icons.shopping_cart_sharp,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.white,
                                ),
                                tooltip: 'Shopping_cart',
                                onPressed: null),
                            Positioned(
                              right: 8,
                              top: 0,
                              child: Container(
                                width: getProportionateScreenWidth(18.0),
                                height: getProportionateScreenWidth(18.0),
                                decoration: const BoxDecoration(
                                  color: Colors.lightGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(12.0)),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(width: getProportionateScreenWidth(5.0)),
                //SearchButton
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.search,
                    size: getProportionateScreenWidth(25),
                    color: Colors.white,
                  ),
                  tooltip: 'Search',
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Product Details Page
  Widget _buildProductDetailsPage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(15.0)),
        child: Column(
          children: [
            (productInfoData == null)
                ? Text(singleProductData!.data!.name ?? " ",
                    style: TextStyle(
                        height: 1.5,
                        fontSize: getProportionateScreenWidth(20.0),
                        color: kDefaultHeaderFontColor))
                : Text(productInfoData!.data!.primary!.name ?? " ",
                    style: TextStyle(
                        height: 1.5,
                        fontSize: getProportionateScreenWidth(20.0),
                        color: kDefaultHeaderFontColor)),
            const Divider(
              color: kDefaultBorderColor,
              thickness: 1,
            ),
            BlocConsumer<ProductPageDetailsBloc, ProductPageDetailsState>(
              listener: (context, state) {
                if (state is ProductPageDetailsLoading) {
                  setState(() {
                    isProgress = true;
                  });
                }
                if (state is ProductPageDetailsLoaded) {
                  setState(() {
                    productPageFlag = true;
                    cartStatus = false;
                    singleProductData = state.productPageDetail;
                    isProgress = false;
                  });
                }
                if (state is ProductPageDetailsError) {
                  setState(() {
                    isProgress = false;
                  });
                }
              },
              builder: (context, state) {
                if (state is ProductPageDetailsLoaded) {
                  productPageFlag = true;
                  singleProductData = state.productPageDetail;
                  //imageSrc=getPrimaryImageSrc(singleProductData!.data!.images!);
                  return _buildProductData(context);
                }
                return _buildProductData(context);
              },
            )
          ],
        ),
      ),
    );
  }

  //This is widget for show product details
  Widget _buildProductData(BuildContext context) {
    return Column(
      children: [
        (productPageFlag)
            ? Column(
                children: [
                  CachedNetworkImage(
                      width: getProportionateScreenWidth(250.0),
                      height: getProportionateScreenHeight(250.0),
                      imageUrl: (imageSrc == " ")
                          ? "$categoryImageUrl/product/small/${ImagePath.getPrimaryImageSrc(singleProductData!.data!.images ?? [])}"
                          : "$categoryImageUrl/product/small/$imageSrc",
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) =>
                          const Image(image: AssetImage(errorImageUrl))),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: getProportionateScreenHeight(60.0),
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15.0)),
                    child: ListView.builder(
                      itemCount: singleProductData!.data!.images!.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (singleProductData!.data!.images![index].primary ==
                            true) {
                          imageSrc =
                              singleProductData!.data!.images![index].filename;
                          // return _buildImageList(
                          //     singleProductData!.data!.images!, index);
                        }
                        return _buildImageList(
                            singleProductData!.data!.images!, index);
                      },
                    ),
                  ),
                ],
              )
            : CachedNetworkImage(
                width: getProportionateScreenWidth(250.0),
                height: getProportionateScreenHeight(250.0),
                imageUrl:
                    "$categoryImageUrl/product/small/${productInfoData!.data!.primary!.images}",
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) =>
                    const Image(image: AssetImage(errorImageUrl))),
        SizedBox(
          height: 20.0,
        ),

        //Product Title
        (productPageFlag)
            ? Column(
                children: [
                  //##############  Show out of stock text ##############################
                  (singleProductData!.data!.quantity! <= 0)
                      ? Text(
                          "OUT OF STOCK",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16.0),
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 10.0,
                  ),

                  //##############  Show selected product title ##############################
                  Center(
                    child: Text(
                      singleProductData!.data!.name ?? "",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(18.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  //############## Sales price and price ##############
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (singleProductData!.data!.price.toString() !=
                              singleProductData!.data!.saleprice.toString())
                          ? PriceTag(
                              price: singleProductData!.data!.price.toString(),
                              color: kDefaultTitleFontColor,
                              textDecoration: TextDecoration.lineThrough,
                            )
                          : Container(),
                      SizedBox(
                        width: getProportionateScreenWidth(10.0),
                      ),
                      PriceTag(
                        price: singleProductData!.data!.saleprice.toString(),
                        color: Colors.black,
                      )
                    ],
                  ),

                  SizedBox(
                    height: getProportionateScreenHeight(10.0),
                  ),

                  //Price with cashback
                  (singleProductData!.data!.affordability == 1)
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Price with Cashback: ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          getProportionateScreenWidth(15.0)),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10.0),
                                ),
                                // PriceTag(
                                //   price: (singleProductData!.data!.saleprice! -
                                //           singleProductData!.data!.c!)
                                //       .toString(),
                                //   color: Colors.black,
                                // )
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10.0),
                            ),
                          ],
                        )
                      : Container(),

                  // (singleProductData!.data!.discount! > 0)
                  //     ? Text(
                  //         "${productPageDetail!.discount}% off",
                  //         style: TextStyle(
                  //             fontSize: getProportionateScreenWidth(15.0),
                  //             color: Colors.green),
                  //       )
                  //     : Container(),
                ],
              )
            : Container(),
        SizedBox(
          height: getProportionateScreenHeight(30.0),
        ),

        //Select Product Color and other Details
        ListView.builder(
          itemCount: productAttributesList!.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            ProductAttributes productAttributes = productAttributesList![index];
            return Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: ThirdHeaderText(
                      thirdHeader: productAttributes.attribute_label ?? " "),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10.0),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: productAttributes.attribute_options!.map((e) {
                      if (e.attribute_name == "Choose your color") {
                        return _buildColorContainer(
                            e, index, productAttributesList!.length);
                      } else {
                        return _buildDataContainer(
                            e, index, productAttributesList!.length);
                      }
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15.0),
                ),
              ],
            );
          },
        ),

        (productPageFlag)
            ? (singleProductData!.data!.quantity! <= 0)
                ? LoginButton(
                    title: "Notify Me When Available",
                    color: kDefaultSecondaryButtonColor,
                    onPress: () {
                      // Navigator.pushNamed(context, TextFile.id);
                    })
                : BlocListener<AddingProductToCartBloc,
                        AddingProductToCartState>(
                    listener: (context, state) {
                      if (state is AddingProductToCartLoading) {
                        setState(() {
                          isProgress = true;
                        });
                      }
                      if (state is AddingProductToCartLoaded) {
                        totalProductCountBloc.add(LoadTotalCartProductCount(
                            token ?? " ", isAuthenticate!));
                        setState(() {
                          isProgress = false;
                          cartStatus = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          defaultSnackBar("Product Added to Cart", Colors.green,
                              Colors.white, 2000),
                        );
                      }
                      if (state is AddingProductToCartFailure) {
                        setState(() {
                          isProgress = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          defaultSnackBar(
                              state.message, Colors.red, Colors.white, 2000),
                        );
                      }
                    },
                    child: (cartStatus)
                        ? ButtonWithIcon(
                            icon: Icon(Icons.shopping_cart_rounded),
                            title: "Go to Cart",
                            color: kDefaultSecondaryButtonColor,
                            onPress: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddToCartPage(
                                  token: token,
                                );
                              }));
                            })
                        : ButtonWithIcon(
                            icon: Icon(Icons.add_shopping_cart_rounded),
                            title: "Add to Cart",
                            color: kDefaultSecondaryButtonColor,
                            onPress: () {
                              if (loginData == null) {
                                CartProductData cartProductData =
                                    CartProductData(
                                        item_quantity: 1,
                                        id: singleProductData!.data!.id,
                                        sku: singleProductData!.data!.sku,
                                        name: singleProductData!.data!.name,
                                        slug: singleProductData!.data!.slug,
                                        description: singleProductData!
                                            .data!.description,
                                        excerpt:
                                            singleProductData!.data!.excerpt,
                                        price: singleProductData!.data!.price!
                                            .toDouble(),
                                        saleprice: singleProductData!
                                            .data!.saleprice!
                                            .toDouble(),
                                        quantity:
                                            singleProductData!.data!.quantity,
                                        related_products: singleProductData!
                                            .data!.related_products,
                                        images: singleProductData!.data!.images,
                                        enabled:
                                            singleProductData!.data!.enabled,
                                        route_id:
                                            singleProductData!.data!.route_id,
                                        fixed_quantity: singleProductData!
                                            .data!.fixed_quantity);

                                addingProductToCartBloc.add(
                                    AddProductToLocalCartEvent(
                                        cartProductData));
                              } else {
                                addingProductToCartBloc.add(AddProductToCart(
                                    singleProductData!.data!.id!,
                                    loginData!.userData!.token!));
                              }

                              // Navigator.pushNamed(context, TextFile.id);
                            }))
            : Container(),
      ],
    );
  }

  //This is list of Product Images
  Widget _buildImageList(List<TypeImage> typeImage, int index) {
    return InkWell(
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: () {
        setState(() {
          imageSrc = typeImage[index].filename;
        });
      },
      child: Container(
        height: getProportionateScreenHeight(20.0),
        width: getProportionateScreenWidth(100.0),
        margin: EdgeInsets.only(left: getProportionateScreenWidth(10.0)),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: kDefaultBorderColor)),
        child: CachedNetworkImage(
            imageUrl:
                "$categoryImageUrl/product/small/${typeImage[index].filename}",
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage(errorImageUrl))),
      ),
    );
  }

  //Select Product Data
  Widget _buildDataContainer(
      AttributesOption optionValues, int index, int length) {
    return SelectableContainer(
      //selected: true,
      selected: (selectedIndex[index.toString()]
              .toString()
              .contains(optionValues.id.toString()))
          ? true
          : false,
      marginColor: Colors.white,
      onValueChanged: (_) {
        setState(() {
          selectedIndex[index.toString()] = optionValues.id.toString();
        });

        if (selectedIndex.keys.length == length) {
          // print(selectedIndex);
          List attributesId = [];

          selectedIndex.entries.map((e) => attributesId.add(e.value)).toList();

          if (productInfoData != null) {
            //adding bloc event
            _productPageDetailsBloc.add(LoadProductDataBasedOnValueEvent(
                productValue: attributesId,
                productTypeId: productInfoData!.data!.primary!.id.toString()));
          } else {
            //adding bloc event
            _productPageDetailsBloc.add(LoadProductDataBasedOnValueEvent(
                productValue: attributesId,
                productTypeId: singleProductData!.data!.parent_id.toString()));
          }
        }
      },
      padding: 10,
      iconSize: 12,
      borderRadius: 3,
      borderSize: 1,
      unselectedOpacity: 0.9,
      unselectedBorderColor: kDefaultBorderColor,
      child: Text(
        optionValues.option_name ?? "",
        style: TextStyle(
            fontSize: getProportionateScreenWidth(15.0),
            color: kDefaultHeaderFontColor),
      ),
    );
  }

  //Select Product Color
  Widget _buildColorContainer(
      AttributesOption optionValues, int index, int length) {
    return SelectableContainer(
      selected: (selectedIndex[index.toString()]
              .toString()
              .contains(optionValues.id.toString()))
          ? true
          : false,
      marginColor: Colors.white,
      onValueChanged: (_) {
        setState(() {
          selectedIndex[index.toString()] = optionValues.id.toString();
        });

        if (selectedIndex.keys.length == length) {
          // print(selectedIndex);
          List attributesId = [];

          selectedIndex.entries.map((e) => attributesId.add(e.value)).toList();
          if (productInfoData != null) {
            //adding bloc event
            _productPageDetailsBloc.add(LoadProductDataBasedOnValueEvent(
                productValue: attributesId,
                productTypeId: productInfoData!.data!.primary!.id.toString()));
          } else {
            //adding bloc event
            _productPageDetailsBloc.add(LoadProductDataBasedOnValueEvent(
                productValue: attributesId,
                productTypeId: singleProductData!.data!.parent_id.toString()));
          }
        }
      },
      padding: 7,
      iconSize: 12,
      borderRadius: 3,
      borderSize: 1,
      unselectedOpacity: 0.9,
      unselectedBorderColor: kDefaultBorderColor,
      child: SizedBox(
        width: getProportionateScreenWidth(80.0),
        child: Column(
          children: [
            Container(
              height: getProportionateScreenHeight(30.0),
              width: getProportionateScreenWidth(30.0),
              decoration: BoxDecoration(
                color: Color(int.parse(
                    "0xFF${optionValues.swatch_value?.substring(1)}")),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black26),
              ),
            ),
            SizedBox(width: 15.0),
            Text(
              optionValues.option_name ?? " ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15.0),
                  color: kDefaultHeaderFontColor),
            )
          ],
        ),
      ),
    );
  }
}
