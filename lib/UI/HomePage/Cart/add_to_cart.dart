import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unicorn_store/Business_Logic/bloc/cart/product%20service%20check/product_service_check_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/cart/total%20price%20calculate/total_price_calculate_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/cart/total%20product%20count/total_product_count_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/cart/view%20cart/view_cart_product_list_bloc.dart';
import 'package:unicorn_store/UI/Components/default_snackbar.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/HomePage/Cart/Components/cart_product.dart';
import 'package:unicorn_store/UI/My%20Account/Checkout%20Page/checkout_page.dart';
import 'package:unicorn_store/UI/size_config.dart';
import 'package:unicorn_store/UI/constant.dart';
import '../../../Business_Logic/bloc/cart/remove and wishlist/remove_cart_item_bloc.dart';
import '../../../Data/Models/Cart/View Cart/cart_product_data.dart';
import '../Components/price_tag.dart';
import '../Search Button/custom_search_delegate.dart';
import 'Components/show_when_cart_is_empty.dart';
import 'Components/text_form_field_with_button.dart';
import 'dart:math' as math; // import this

class AddToCartPage extends StatefulWidget {
  final String? token;
  const AddToCartPage({Key? key, this.token}) : super(key: key);

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  //Creating instance for bloc
  ViewCartProductListBloc viewCartProductListBloc = ViewCartProductListBloc();
  late TotalProductCountBloc totalProductCountBloc;
  final TotalPriceCalculateBloc totalPriceCalculateBloc =
      TotalPriceCalculateBloc();
  final ProductServiceCheckBloc productServiceCheckBloc =
      ProductServiceCheckBloc();
  final _formKey = GlobalKey<FormState>();

  bool isProgress = false;
  final RemoveCartItemBloc removeCartItemBloc = RemoveCartItemBloc();
  List<CartProductData>? cartProductData;
  Map<String, dynamic> totalPriceList = {};

  //creating controller for pincode and coupon check
  final _picodeCodeCheck = TextEditingController();
  final _couponCheck = TextEditingController();
  bool errorBorder = false;
  bool enableChekoutButton = false;

  @override
  Widget build(BuildContext context) {
    totalProductCountBloc = BlocProvider.of<TotalProductCountBloc>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => viewCartProductListBloc
            ..add(LoadCartProductList(widget.token ?? " ")),
        ),
        BlocProvider(
          create: (context) => removeCartItemBloc,
        ),
        BlocProvider(
          create: (context) => totalPriceCalculateBloc,
        ),
        BlocProvider(
          create: (context) => productServiceCheckBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _buildAppbar(context),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(15.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Cart",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(25),
                            color: kDefaultHeaderFontColor),
                      ),
                      const Divider(
                        color: kDefaultBorderColor,
                        thickness: 1,
                      ),
                      BlocConsumer<ViewCartProductListBloc,
                          ViewCartProductListState>(
                        listener: (context, state) {
                          if (state is ViewCartProductListLoading) {
                            setState(() {
                              isProgress = true;
                            });
                          }
                          if (state is ViewCartProductListLoaded) {
                            setState(() {
                              isProgress = false;
                              cartProductData = state.cartProductData;
                            });
                          }
                          if (state is ViewCartProductListEmpty) {
                            setState(() {
                              isProgress = false;
                            });
                          }
                          if (state is ViewCartProductListFailure) {
                            setState(() {
                              isProgress = false;
                            });
                          }
                        },
                        builder: (context, state) {
                          if (state is ViewCartProductListLoaded) {
                            return BlocConsumer<RemoveCartItemBloc,
                                RemoveCartItemState>(
                              listener: (context, state) {
                                if (state is RemoveCartItemLoading) {
                                  setState(() {
                                    isProgress = true;
                                  });
                                }
                                if (state is RemoveCartItemSuccess) {
                                  viewCartProductListBloc.add(
                                      LoadCartProductList(widget.token ?? " "));
                                  totalProductCountBloc.add(
                                      LoadTotalCartProductCount(
                                          widget.token ?? " "));
                                  setState(() {
                                    isProgress = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      defaultSnackBar(
                                          "Product has been removed to successfully",
                                          Colors.green,
                                          Colors.white,
                                          2000));
                                }
                                if (state is MoveToWishlistProductSuccess) {
                                  viewCartProductListBloc.add(
                                      LoadCartProductList(widget.token ?? " "));
                                  totalProductCountBloc.add(
                                      LoadTotalCartProductCount(
                                          widget.token ?? " "));
                                  setState(() {
                                    isProgress = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      defaultSnackBar(
                                          "Product has been moved to wishlist",
                                          Colors.green,
                                          Colors.white,
                                          2000));
                                }
                                if (state is RemoveCartItemFailure) {
                                  setState(() {
                                    isProgress = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      defaultSnackBar(state.message, Colors.red,
                                          Colors.white, 2000));
                                }
                              },
                              builder: (context, state) {
                                return Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      //List of Card Product
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: cartProductData!.length,
                                          itemBuilder: (context, index) {
                                            totalPriceList.addAll({
                                              cartProductData![index]
                                                  .cart_item_id
                                                  .toString(): 0.0
                                            });

                                            return CartProduct(
                                              cartProduct:
                                                  cartProductData![index],
                                              token: widget.token ?? " ",
                                              onPressed: (cartItemId) {
                                                removeCartItemBloc.add(
                                                    RemoveItemCart(cartItemId,
                                                        widget.token ?? " "));
                                              },
                                              addToWishlist: (cartItemId) {
                                                removeCartItemBloc.add(
                                                    MoveToWishlistCartItem(
                                                        cartItemId,
                                                        widget.token ?? " "));
                                              },
                                              totalPriceList: totalPriceList,
                                            );
                                          }),

                                      //     ************Order Summary*******//
                                      Card(
                                        color: Colors.white,
                                        elevation: 2,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  getProportionateScreenWidth(
                                                      10.0)),
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          kDefaultBorderColor),
                                                ),
                                              ),
                                              child: Text(
                                                "Order Summary",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            15.0)),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  getProportionateScreenWidth(
                                                      15.0)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Total",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenWidth(
                                                                    15.0)),
                                                      ),
                                                      const Spacer(),
                                                      BlocBuilder<
                                                          TotalPriceCalculateBloc,
                                                          TotalPriceCalculateState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is TotalPriceCalculateSuccess) {
                                                            return PriceTag(
                                                                price: state
                                                                    .totalPrice
                                                                    .floor()
                                                                    .toString());
                                                          }
                                                          return const PriceTag(
                                                              price: "00");
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            10.0),
                                                  ),
                                                  Text(
                                                    "* Inclusive of all taxes",
                                                    style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                12.0),
                                                        color: Colors.green),
                                                  ),
                                                  const Divider(
                                                    color: kDefaultBorderColor,
                                                    thickness: 1,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            10.0),
                                                  ),
                                                  //Pin Check out Input
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextFormFieldAndButton(
                                                        errorBorder:
                                                            errorBorder,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter pincode';
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            _picodeCodeCheck,
                                                        buttonTitle: "Check",
                                                        hintText:
                                                            "Enter Pincode",
                                                        onPress: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                            productServiceCheckBloc.add(
                                                                CheckProductService(
                                                                    _picodeCodeCheck
                                                                        .text));
                                                          }
                                                        },
                                                      ),
                                                      BlocListener<
                                                          ProductServiceCheckBloc,
                                                          ProductServiceCheckState>(
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is ProductServiceCheckLoaded) {
                                                            setState(() {
                                                              enableChekoutButton =
                                                                  true;
                                                              errorBorder =
                                                                  false;
                                                            });
                                                          }
                                                          if (state
                                                              is ProductServiceCheckFailure) {
                                                            setState(() {
                                                              enableChekoutButton =
                                                                  false;

                                                              errorBorder =
                                                                  true;
                                                            });
                                                          }
                                                        },
                                                        child: BlocBuilder<
                                                            ProductServiceCheckBloc,
                                                            ProductServiceCheckState>(
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is ProductServiceCheckLoading) {
                                                              return Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10.0,
                                                                    horizontal:
                                                                        30.0),
                                                                child: Center(
                                                                  child:
                                                                      Transform
                                                                          .scale(
                                                                    scale: 0.9,
                                                                    child:
                                                                        const CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          4.0,
                                                                      color:
                                                                          kDefaultSecondaryButtonColor,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            if (state
                                                                is ProductServiceCheckLoaded) {
                                                              errorBorder =
                                                                  false;

                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const SizedBox(
                                                                      height:
                                                                          5.0,
                                                                    ),
                                                                    Text(
                                                                      "Service is available on ${_picodeCodeCheck.text}",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .green,
                                                                          fontSize:
                                                                              14.0),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          5.0,
                                                                    ),
                                                                    Row(
                                                                        children: [
                                                                          Transform(
                                                                              alignment: Alignment.center,
                                                                              transform: Matrix4.rotationY(math.pi),
                                                                              child: const Icon(
                                                                                Icons.local_shipping_rounded,
                                                                                color: Colors.green,
                                                                                size: 20.0,
                                                                              )),
                                                                          const SizedBox(
                                                                            width:
                                                                                5.0,
                                                                          ),
                                                                          const Text(
                                                                            "Ships in 4-5 Working Days.",
                                                                            style:
                                                                                TextStyle(color: Colors.green, fontSize: 14.0),
                                                                          ),
                                                                        ]),
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                            if (state
                                                                is ProductServiceCheckFailure) {
                                                              errorBorder =
                                                                  true;

                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0,
                                                                        top:
                                                                            5.0),
                                                                child: Text(
                                                                  state.message,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          14.0),
                                                                ),
                                                              );
                                                            }
                                                            return Container();
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            10.0),
                                                  ),

                                                  //Continue Checkout Button
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed:
                                                          (!enableChekoutButton)
                                                              ? null
                                                              : () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) {
                                                                            return CheckoutPage(
                                                                              token: widget.token ?? " ",
                                                                              cartProductData: cartProductData,
                                                                            );
                                                                          },
                                                                          settings: const RouteSettings(name: "/CheckoutPage_Screen")));
                                                                  // if (_formKey
                                                                  //     .currentState!
                                                                  //     .validate()) {
                                                                  //   FocusScope.of(
                                                                  //           context)
                                                                  //       .unfocus();
                                                                  //   productServiceCheckBloc.add(
                                                                  //       CheckProductService(
                                                                  //           _picodeCodeCheck.text));
                                                                  // }
                                                                },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            kDefaultSecondaryButtonColor, // background
                                                        onPrimary: Colors.white,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                3.0),
                                                          ), // <-- Radius
                                                        ), // foreground
                                                      ),
                                                      child: Text(
                                                        "Continue Checkout",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenWidth(
                                                                    15.0)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      //****************Coupon Discount**************//
                                      Container(
                                        // width: double.infinity,
                                        // margin: EdgeInsets.all(
                                        //     getProportionateScreenWidth(10.0)),
                                        // decoration: BoxDecoration(
                                        //   border: Border.all(
                                        //       color: kDefaultBorderColor),
                                        // ),
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 2,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(
                                                    getProportionateScreenWidth(
                                                        10.0)),
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            kDefaultBorderColor),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Coupon Discount",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              15.0)),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(
                                                    getProportionateScreenWidth(
                                                        15.0)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    //Coupon code Input Field
                                                    TextFormFieldAndButton(
                                                      controller: _couponCheck,
                                                      errorBorder: false,
                                                      onPress: () {},
                                                      validator: (value) {
                                                        return null;
                                                      },
                                                      buttonTitle: "Apply",
                                                      hintText:
                                                          "Enter Coupon Code",
                                                    ),

                                                    SizedBox(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              5.0),
                                                    ),
                                                    const Divider(
                                                      color:
                                                          kDefaultBorderColor,
                                                      thickness: 1,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              15.0),
                                                    ),

                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.info_sharp,
                                                          size:
                                                              getProportionateScreenHeight(
                                                                  20.0),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  5.0),
                                                        ),
                                                        Text(
                                                          "Need any help?",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  getProportionateScreenWidth(
                                                                      15.0)),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              5.0),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Speak to Our e-commerce specialist :",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  getProportionateScreenWidth(
                                                                      12.0)),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  5),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.phone_sharp,
                                                              size:
                                                                  getProportionateScreenHeight(
                                                                      13.0),
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                            FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Text(
                                                                "18002677888",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        getProportionateScreenWidth(
                                                                            13.0),
                                                                    color: Colors
                                                                        .green),
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
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          if (state is ViewCartProductListEmpty) {
                            return const ShowWhenCartIsEmpty();
                          }
                          if (state is ViewCartProductListFailure) {
                            // print(widget.token);
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            (isProgress) ? const LoadingIndicatorBar() : Container(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      actions: [
        const Spacer(),
        Expanded(flex: 5, child: SvgPicture.asset("assets/Unicorn-logo.svg")),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
