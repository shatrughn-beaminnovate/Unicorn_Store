// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/cart/total%20product%20count/total_product_count_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/my_account/Wishlist/Wishlist%20Product%20Details/wishlist_product_details_fetching_bloc.dart';
import 'package:unicorn_store/Data/Repositories/cart/add_to_local_cart_repository.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/main_screen.dart';
import 'package:unicorn_store/UI/routes.dart';

import 'UI/OnBoarding Screen/on_boarding_page.dart';

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
      this.productTypeId,
      this.productTypeSlug,
      this.productPageId})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Creating bloc instace
  // late AuthenticationBloc authenticationBloc;
  final WishlistProductDetailsFetchingBloc wishlistProductDetailsFetchingBloc =
      WishlistProductDetailsFetchingBloc();

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   //authenticationBloc =
  //   authenticationBloc.add(AppStarted());
  //   super.didChangeDependencies();
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AddToLocalCartRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              RepositoryProvider.of<AddToLocalCartRepository>(context),
            )..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => wishlistProductDetailsFetchingBloc,
          ),
          BlocProvider(
            create: (context) => TotalProductCountBloc(
                RepositoryProvider.of<AddToLocalCartRepository>(context)),
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
                BlocProvider.of<TotalProductCountBloc>(context).add(
                    LoadTotalCartProductCount(
                        state.loginData.userData!.token!, true));
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
              if (state is AuthenticationUnauthenticated) {
                BlocProvider.of<TotalProductCountBloc>(context)
                    .add(const LoadTotalCartProductCount(" ", false));
              }
            },
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (BuildContext context, AuthenticationState state) {
                if (state is AuthenticationUninitialized) {
                  print("Authentication Unintialiazed............");
                  return const LoadingIndicatorBar();
                } else 
                if (state is AuthenticationLoading) {
                  print("AuthenticationLoading............");

                  return const LoadingIndicatorBar();
                }
                if (state is AuthenticatedOnboardingIncomplete) {
                  print("OnBoardingPage............");

                  return const OnBoardingPage();
                } else if (state is AuthenticationAuthenticated) {
                  print("AuthenticationAuthenticated............");
                  if (widget.myAccountRedirect == "false") {
                    return MainScreen(
                      selectedIndex: 2,
                    );
                  } else if (widget.myAccountRedirect == "true") {
                    return MainScreen(
                      selectedIndex: 0,
                    );
                  }
                  return MainScreen(
                    selectedIndex: 0,
                  );
                } else if (state is AuthenticationUnauthenticated) {
                  print("AuthenticationUnauthenticated............");

                  return MainScreen(
                    selectedIndex: 0,
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
      ),
    );
  }
}