import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/my_account/Wishlist/Wishlist%20Product%20Details/wishlist_product_details_fetching_bloc.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Login/login_data.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/images_list.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/wishlist_details.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/LoginPage/Components/custom_submit_button.dart';
import 'package:unicorn_store/UI/constant.dart';

import '../size_config.dart';

class WishlistPage extends StatefulWidget {
  static String id = "Wishlist_Screen";

  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  //creating instace for wishlistbloc
  WishlistProductDetailsFetchingBloc wishlistProductDetailsFetchingBloc =
      WishlistProductDetailsFetchingBloc();

  //Creating instace for wishlist product details
  WishlistDetails? wishlistDetails;

  // ignore: prefer_typing_uninitialized_variables
  var userLoginData;

  //getting logged in user details
  LoginData? loginData;

  @override
  void didChangeDependencies() {
    userLoginData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    loginData = userLoginData["loginData"];

    wishlistProductDetailsFetchingBloc
        .add(LoadWishlistProductDetailsApiFetch(token: loginData!.token!));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(),
      body: BlocProvider(
        create: (context) => wishlistProductDetailsFetchingBloc,
        child: BlocListener<WishlistProductDetailsFetchingBloc,
            WishlistProductDetailsFetchingState>(
          listener: (context, state) {
            if (state is WishlistProductDetailsFetchingLoaded) {
              setState(() {
                wishlistDetails = state.wishlistDetails;
              });
            }
            if (state is AddOrRemoveProductFromWishlistSuccess) {
              setState(() {
                wishlistDetails = state.wishlistDetails;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Product removed from wishlist."),
                  backgroundColor: Colors.green,
                  duration: Duration(milliseconds: 2000),
                  // behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: BlocBuilder<WishlistProductDetailsFetchingBloc,
              WishlistProductDetailsFetchingState>(
            builder: (context, state) {
              if (state is WishlistProductDetailsFetchingLoading) {
                return LoadingIndicatorBar();
              } else if (state is AddOrRemoveProductFromWishlistSuccess) {
                return _buildWishlistProduct();
              } else if (state is WishlistProductDetailsFetchingError) {
                return Center(
                  child: Text(state.message.toString()),
                );
              }
              return _buildWishlistProduct();
            },
          ),
        ),
      ),
    );
  }

  //getting primary product from image list
  String? getPrimaryImageSrc(List<ImageList>? images) {
    String? path;
    for (var element in images ?? []) {
      if (element.primary == true && element.primary != null) {
        path = element.filename;
      }
    }
    return path;
  }

  Widget _buildWishlistProduct() {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(15.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Wishlist",
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
          Expanded(
            child: ListView.builder(
                itemCount: wishlistDetails?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return //***************Add on Accessories************
                      Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            bottom: getProportionateScreenWidth(15.0)),
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15.0)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: kDefaultBorderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2.0)),
                        ),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(15.0),
                            ),
                            CachedNetworkImage(
                              height: getProportionateScreenHeight(150),
                              width: getProportionateScreenWidth(200),
                              imageUrl:
                                  "$imageDefaultURL$imageSecondUrl${getPrimaryImageSrc(wishlistDetails?.data?[index].productDetails?.images)}",
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) => SizedBox(
                                height: getProportionateScreenHeight(150),
                                width: getProportionateScreenWidth(200),
                                child: const Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/NoImage.jpg"),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: getProportionateScreenHeight(25.0),
                            ),
                            const Divider(
                              color: kDefaultBorderColor,
                              thickness: 1,
                            ),
                            Text(
                              wishlistDetails?.data?[index].productDetails?.name
                                      .toString() ??
                                  " ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15.0)),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15.0),
                            ),


                            (wishlistDetails
                                        ?.data?[index].productDetails?.quantity
                                        .toString() !=
                                    "0")
                                ? LoginButton(
                                    title: "Add to Cart",
                                    onPress: () {},
                                    color: const Color(0xFF1F99CF),
                                  )
                                : Text(
                                    "Out of stock",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            getProportionateScreenWidth(15.0)),
                                  ),
                            SizedBox(
                              height: getProportionateScreenHeight(20.0),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            wishlistProductDetailsFetchingBloc.add(
                                AddOrDeleteProductFromWishlistEvent(
                                    productId: wishlistDetails!
                                        .data![index].productId
                                        .toString(),
                                    token: loginData!.token!));
                          },
                          child: Icon(
                            Icons.cancel_outlined,
                            size: getProportionateScreenWidth(25.0),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
