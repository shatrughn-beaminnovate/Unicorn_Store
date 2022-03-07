import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/OnBoarding%20Screen/on_boarding_page.dart';
import 'package:unicorn_store/UI/main_screen.dart';
import 'package:unicorn_store/UI/routes.dart';

void main() {
  runApp(DevicePreview(
      enabled: true,
      // ignore: prefer_const_literals_to_create_immutables
      tools: [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MyApp()));
}

class MyApp extends StatefulWidget {
  final String? myAccountRedirect;

  const MyApp({Key? key, this.myAccountRedirect}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Creating bloc instace
  AuthenticationBloc authenticationBloc = AuthenticationBloc();

  @override
  void initState() {
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authenticationBloc,
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              print("Authentication Unintialiazed............");

              return Scaffold(body: LoadingIndicatorBar());
            } else if (state is AuthenticatedOnboardingIncomplete) {
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
              } else {
                return BlocProvider.value(
                  value: authenticationBloc,
                  child: MainScreen(
                    selectedIndex: 0,
                  ),
                );
              }
            } else if (state is AuthenticationLoading) {
              print("AuthenticationLoading............");

              return Scaffold(body: LoadingIndicatorBar());
            } else if (state is AuthenticationUnauthenticated) {
              print("AuthenticationUnauthenticated............");

              return BlocProvider(
                create: (context) => authenticationBloc,
                child: MainScreen(
                  selectedIndex: 0,
                ),
              );
            }
            return const OnBoardingPage();
          },
        ),
        routes: routes,
      ),
    );
  }
}
