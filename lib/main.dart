// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/OnBoarding%20Screen/on_boarding_page.dart';
import 'package:unicorn_store/UI/ProductPage/product_page.dart';
import 'package:unicorn_store/UI/ProductPage/product_type_page.dart';
import 'package:unicorn_store/UI/main_screen.dart';
import 'package:unicorn_store/UI/routes.dart';

import 'Business_Logic/bloc/my_account/Wishlist/Wishlist Product Details/wishlist_product_details_fetching_bloc.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  final String? myAccountRedirect;
  final Map<String, String>? productValue;
  final String? productTypeSlug;
  final String? productPageId;
  final String? productTypeId;

  const MyApp(
      {Key? key,
      this.myAccountRedirect,
      this.productValue,
      this.productTypeId,      this.productTypeSlug,
      this.productPageId})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Creating bloc instace
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  final WishlistProductDetailsFetchingBloc wishlistProductDetailsFetchingBloc =
      WishlistProductDetailsFetchingBloc();

  @override
  void initState() {
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authenticationBloc,
        ),
        BlocProvider(
          create: (context) => wishlistProductDetailsFetchingBloc,
        ),
      ],
      child: MaterialApp(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              if (widget.myAccountRedirect == "goToProductPageType") {
                wishlistProductDetailsFetchingBloc.add(
                    AddProductToWishlistEvent(
                        productId: widget.productPageId!,
                        token: state.loginData.userData!.token!));
              }
              if (widget.myAccountRedirect == "goToAccessoriesProductPage") {
                wishlistProductDetailsFetchingBloc.add(
                    AddProductToWishlistEvent(
                        productId: widget.productPageId!,
                        token: state.loginData.userData!.token!));
              }
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                print("Authentication Unintialiazed............");

                return Scaffold(body: LoadingIndicatorBar());
              } else
                if (state is AuthenticationLoading) {
                print("AuthenticationLoading............");

                return Scaffold(body: LoadingIndicatorBar());
              }
               if (state is AuthenticatedOnboardingIncomplete) {
                print("OnBoardingPage............");

                return const OnBoardingPage();
              } else if (state is AuthenticationAuthenticated) {
                print("AuthenticationAuthenticated............");
                if (widget.myAccountRedirect == "false") {
                  return BlocProvider.value(
                    value: authenticationBloc,
                    child: MainScreen(
                      selectedIndex: 2,
                    ),
                  );
                } else if (widget.myAccountRedirect == "true") {
                  return BlocProvider.value(
                    value: authenticationBloc,
                    child: MainScreen(
                      selectedIndex: 0,
                    ),
                  );
                } else if (widget.myAccountRedirect == "goToProductPageType") {
               
                  return BlocProvider.value(
                    value: authenticationBloc,
                    child: ProductDetailsScreen(
                      productTypeSlug: widget.productTypeSlug,
                      productValue: widget.productValue,
                      productTypeId: widget.productTypeId!,
                      token: state.loginData.userData!.token.toString(),
                    ),
                  );
                } else if (widget.myAccountRedirect ==
                    "goToAccessoriesProductPage") {
                  return BlocProvider.value(
                    value: authenticationBloc,
                    child: ProductPage(
                      productPageId: widget.productPageId,
                      token: state.loginData.userData!.token!,
                    ),
                  );
                }
                return BlocProvider.value(
                  value: authenticationBloc,
                  child: MainScreen(
                    selectedIndex: 0,
                  ),
                );
              } 
             else if (state is AuthenticationUnauthenticated) {
                print("AuthenticationUnauthenticated............");

                return BlocProvider(
                  create: (context) => authenticationBloc,
                  child: MainScreen(
                    selectedIndex: 0,
                  ),
                );
              }
              return const Scaffold(
                body: Center(child: Text("")),
              );
            },
          ),
        ),
        routes: routes,
      ),
    );
  }
}
