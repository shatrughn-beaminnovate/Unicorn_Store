import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unicorn_store/Business_Logic/bloc/category/accessories_bloc/accessories_data_fetch_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/my_account/Wishlist/Wishlist%20Product%20Details/wishlist_product_details_fetching_bloc.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_product.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Login/login_data.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/type_images.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/HomePage/Add%20Cart/add_to_cart.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';
import 'package:unicorn_store/UI/HomePage/Search%20Button/custom_search_delegate.dart';
import 'package:unicorn_store/UI/LoginPage/Components/custom_submit_button.dart';
import 'package:unicorn_store/UI/LoginPage/login_form.dart';
import 'package:unicorn_store/UI/size_config.dart';
import '../constant.dart';
import '../main_screen.dart';

class ProductPage extends StatefulWidget {
  static String id = "ProductPage";
  final String? productPageId;
  String? token;
  ProductPage({Key? key, this.productPageId, this.token}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //This is for accessory Product Details
  AccessoriesProduct? accessoriesProduct;

  //This will store image src
  String? imageSrc = " ";

  //Flag for loading indicator
  bool isProgress = false;

  //creating flag for wishlist button
  bool? favoriteFlag = false;

  //Creating instance for bloc
  late AuthenticationBloc authenticationBloc;
  final WishlistProductDetailsFetchingBloc wishlistProductDetailsFetchingBloc =
      WishlistProductDetailsFetchingBloc();
  final AccessoriesDataFetchBloc _accessoriesDataFetchBloc =
      AccessoriesDataFetchBloc();

  // ignore: prefer_typing_uninitialized_variables
  var accessoriesData;

  //Back button check flag when wishlist product added by logout user
  bool wishlistBackbuttonFlag = false;

  //Creating instance for logged in user data
  LoginData? loginData;

  @override
  void didChangeDependencies() {
    //This condition check if productPageId is null then it will get data from navigation page
    //otherwise it will call event to load data
    if (widget.productPageId != null) {
      _accessoriesDataFetchBloc.add(LoadAccessoriesProductDetailsFetch(
          productId: widget.productPageId.toString(), token: widget.token!));
      wishlistBackbuttonFlag = true;
    } else {
      accessoriesData =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      widget.token = accessoriesData["token"];
      print("??????????????????????? ${widget.token}");
      if (widget.token != null) {
        print("Here token is not empty");
        _accessoriesDataFetchBloc.add(LoadAccessoriesProductDetailsFetch(
            productId: accessoriesData["productDetails"].id.toString(),
            token: widget.token!));
      } else {
        print("Here token is not empty");

        _accessoriesDataFetchBloc.add(LoadAccessoriesProductDetailsFetch(
            productId: accessoriesData["productDetails"].id.toString(),
            token: " "));
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: BlocProvider(
            create: (context) => _accessoriesDataFetchBloc,
            child: BlocListener<AccessoriesDataFetchBloc,
                AccessoriesDataFetchState>(
              listener: (context, state) {
                if (state is AccessoriesProductDetailsFetchSuccess) {
                  setState(() {
                    favoriteFlag =
                        state.accessoriesWishlistProductDetails.data?.wishlist;
                  });
                }
              },
              child: BlocBuilder<AccessoriesDataFetchBloc,
                  AccessoriesDataFetchState>(
                builder: (context, state) {
                  if (state is AccessoriesProductDetailsFetchSuccess) {
                    return _buildAccessoriesProduct(
                        state.accessoriesWishlistProductDetails.data);
                  } else if (state is AccessoriesDataFetchLoading) {
                    return LoadingIndicatorBar();
                  } else {
                    return Container();
                  }
                },
              ),
            )));
  }

  //This will load accessories product details
  Widget _buildAccessoriesProduct(AccessoriesProduct? accessoriesProduct) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
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
                                ? "$imageDefaultURL$imageSecondUrl${getPrimaryImageSrc(accessoriesProduct.images)}"
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

                          (accessoriesProduct.quantity! <= 0)
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
                                itemCount: accessoriesProduct.images!.length,
                                itemBuilder: (context, index) {
                                  return _buildImageList(
                                      accessoriesProduct.images!, index);
                                }),
                          ),

                          SizedBox(
                            height: getProportionateScreenHeight(30.0),
                          ),

                          //Product Title
                          Text(
                            accessoriesProduct.name!,
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
                            accessoriesProduct.description!,
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
                                    fontSize:
                                        getProportionateScreenWidth(15.0)),
                              ),
                              PriceTag(
                                price: accessoriesProduct.saleprice.toString(),
                                color: Colors.black,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: getProportionateScreenHeight(15.0),
                          ),

                          //MRP of product
                          (accessoriesProduct.saleprice !=
                                      accessoriesProduct.price &&
                                  accessoriesProduct.price != 0)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "MRP: ",
                                      style: TextStyle(
                                          color: kDefaultTitleFontColor,
                                          fontSize: getProportionateScreenWidth(
                                              12.0)),
                                    ),
                                    PriceTag(
                                      price:
                                          accessoriesProduct.price.toString(),
                                      textDecoration:
                                          TextDecoration.lineThrough,
                                      color: kDefaultTitleFontColor,
                                    ),
                                  ],
                                )
                              : Container(),
                          (accessoriesProduct.saleprice !=
                                  accessoriesProduct.price)
                              ? SizedBox(
                                  height: getProportionateScreenHeight(15.0),
                                )
                              : Container(),

                          // Product Discount
                          (accessoriesProduct.discount.toString() != "0")
                              ? Column(
                                  children: [
                                    Text(
                                      "${accessoriesProduct.discount.toString()}% Off",
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(15.0),
                                          color: Colors.green),
                                    ),
                                    SizedBox(
                                      height:
                                          getProportionateScreenHeight(15.0),
                                    ),
                                  ],
                                )
                              : Container(),

                          (accessoriesProduct.quantity! <= 0)
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
                              accessoriesProduct.description ?? "Akshay",
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: getProportionateScreenWidth(15.0),
                                  color: kDefaultTitleFontColor),
                            ),
                          ),
                        ],
                      ),

                      //########################### Add to Wishlist Icon ################################
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          if (state is AuthenticationAuthenticated) {
                            loginData = state.loginData;
                            return BlocProvider(
                              create: (context) =>
                                  wishlistProductDetailsFetchingBloc,
                              child: BlocListener<
                                  WishlistProductDetailsFetchingBloc,
                                  WishlistProductDetailsFetchingState>(
                                listener: (context, state) {
                                  if (state
                                      is WishlistProductDetailsFetchingLoading) {
                                    setState(() {
                                      isProgress = true;
                                    });
                                  }
                                  if (state
                                      is AddOrRemoveProductFromWishlistSuccess) {
                                    setState(() {
                                      isProgress = false;
                                    });
                                  }
                                },
                                child: BlocBuilder<
                                    WishlistProductDetailsFetchingBloc,
                                    WishlistProductDetailsFetchingState>(
                                  builder: (context, state) {
                                    return Positioned(
                                      top: getProportionateScreenHeight(10.0),
                                      right: getProportionateScreenWidth(0.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            favoriteFlag = !favoriteFlag!;
                                          });
                                          if (favoriteFlag!) {
                                            wishlistProductDetailsFetchingBloc.add(
                                                AddOrDeleteProductFromWishlistEvent(
                                                    productId:
                                                        accessoriesProduct.id
                                                            .toString(),
                                                    token: loginData!.token!));
                                          } else {
                                            wishlistProductDetailsFetchingBloc.add(
                                                AddOrDeleteProductFromWishlistEvent(
                                                    productId:
                                                        accessoriesProduct.id
                                                            .toString(),
                                                    token: loginData!.token!));
                                          }
                                        },
                                        child: Icon(
                                          (favoriteFlag!)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: kDefaultSecondaryButtonColor,
                                          size: getProportionateScreenHeight(
                                              25.0),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                          return Positioned(
                            top: getProportionateScreenHeight(10.0),
                            right: getProportionateScreenWidth(0.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BlocProvider.value(
                                    value: BlocProvider.of<AuthenticationBloc>(
                                        context),
                                    child: LoginScreen(
                                      myAccountRedirect:
                                          "goToAccessoriesProductPage",
                                      productPageId:
                                          accessoriesProduct.id.toString(),
                                    ),
                                  );
                                }));
                              },
                              child: Icon(
                                Icons.favorite_border,
                                color: kDefaultSecondaryButtonColor,
                                size: getProportionateScreenHeight(25.0),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          (isProgress) ? LoadingIndicatorBar() : const Center()
        ],
      ),
    );
  }

  //This method return src of primary Image
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
          imageSrc =
              "$imageDefaultURL$imageSecondUrl${_typeImages[index].filename}";
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
            imageUrl:
                "$imageDefaultURL$imageSecondUrl${_typeImages[index].filename}",
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => const Image(
                  image: AssetImage("assets/NoImage.jpg"),
                  height: 200,
                )),
      ),
    );
  }

  //This is AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            (wishlistBackbuttonFlag)
                ? Navigator.pushNamed(context, MainScreen.id)
                : Navigator.of(context).pop();
          }),
      actions: [
        Expanded(flex: 5, child: SvgPicture.asset("assets/Unicorn-logo.svg")),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Shopping_card Icon
                Stack(
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
                      onPressed: () {
                        Navigator.pushNamed(context, AddToCartPage.id);
                      },
                    ),
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
                              fontSize: getProportionateScreenWidth(12.0)),
                        )),
                      ),
                    )
                  ],
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
}
