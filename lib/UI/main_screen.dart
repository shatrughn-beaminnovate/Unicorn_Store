import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/HomePage/home_page.dart';
import 'package:unicorn_store/UI/HomePage/NavigationDrawer/Contact/contact_page.dart';
import 'package:unicorn_store/UI/HomePage/NavigationDrawer/Hot%20Deals/hot_deals_page.dart';
import 'package:unicorn_store/UI/LoginPage/Components/custom_submit_button.dart';
import 'package:unicorn_store/UI/My%20Account/my_account_page.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/Accessories/list_of_children.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/Accessories/list_of_product.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/product_categories.dart';
import 'package:unicorn_store/UI/constant.dart';
import 'HomePage/NavigationDrawer/Components/navigation_bar_list_item.dart';
import 'HomePage/NavigationDrawer/Student Offer/student_offer_screen.dart';
import 'LoginPage/login_form.dart';
import 'size_config.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  static String id = "Main_Screen";

  int selectedIndex = 0;

  MainScreen({Key? key, required this.selectedIndex})
      : super(
          key: key,
        );

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String dropdownValue = 'INR';

  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ProductCategories(),
    BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return const MyAccountPage();
        } else {
          //Alert Dialog for login warning
          return AlertDialog(
            title: const Center(
              child: Text(
                'Login !!!',
                style: TextStyle(color: Colors.red),
              ),
            ),
            content: const Text(
              'You can not access my account without login.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.5),
            ),
            actions: <Widget>[
              Center(
                child: LoginButton(
                    title: "Login",
                    color: kDefaultSecondaryButtonColor,
                    onPress: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider.value(
                            value: BlocProvider.of<AuthenticationBloc>(context),
                            child: const LoginScreen(
                              myAccountRedirect: "true",
                            ),
                          );
                        }
                      ),(Route<dynamic> route) => true);
                    }),
              )
            ],
          );
        }
      },
    ),
  ];

  final List<String> currency = [
    'INR',
    'USD',
    'EUR',
    'AUD',
    "NOK",
    "BRL",
    "BGN",
    "CAD",
    "CNY",
    "NZD",
    "CZK",
    "DKK",
    "GBP",
    "HUF",
    "ISK",
    "JPY",
    "MXN",
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        if (widget.selectedIndex == 0) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return false;
        } else if (widget.selectedIndex == 1 || widget.selectedIndex == 2) {
          setState(() {
            widget.selectedIndex = 0;
          });
          return false;
        }
        return false;
      },
      child: Scaffold(
        appBar: const BuildAppBar(),
        drawer: navigationDrawer(context),

        //Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: kDefaultTitleColor,
          iconSize: getProportionateScreenWidth(25),
          selectedFontSize: getProportionateScreenWidth(12),
          unselectedFontSize: getProportionateScreenWidth(12),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'HOME',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.category_rounded,
              ),
              label: 'Categories',
            ),
            // const BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.circle,
            //   ),
            //   label: 'Discover',
            // ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
              ),
              label: 'Account',
            ),
          ],
          onTap: (index) {
            setState(() {
              widget.selectedIndex = index;
            });
          },
        ),

        body: _widgetOptions.elementAt(widget.selectedIndex),
      ),
    );
  }

  //Navigation Drawer
  Drawer navigationDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: kDefaultNavigationDrawerBackgroundColor,
      child: SafeArea(
        child: ListView(
          shrinkWrap: true,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            //Dropdown for Currency
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(5.0),
                  horizontal: getProportionateScreenWidth(10.0)),
              decoration: BoxDecoration(
                border: Border.all(color: kDefaultBorderColor, width: 0.0),
              ),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  decoration: const InputDecoration.collapsed(hintText: ''),
                  icon: const Icon(
                    Icons.unfold_more,
                    color: kDefaultBorderColor,
                  ),
                  selectedItemBuilder: (_) {
                    return currency
                        .map((e) => Text(
                              e,
                              style: TextStyle(
                                  color: kDefaultNavigationDrawerTitleColor,
                                  fontSize: getProportionateScreenWidth(15.0)),
                            ))
                        .toList();
                  },
                  elevation: 0,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: currency.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: kDefaultHeaderFontColor),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            //Login
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  return NavigationDrawerListItem(
                    title: "My Account",
                    onPress: () {
                      //Here we are using anonymous route for main Screen because
                      //we need to pass index value through constructor
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider.value(
                          value: authenticationBloc,
                          child: MainScreen(selectedIndex: 2),
                        );
                      }),(Route<dynamic> route) => true);
                    },
                  );
                }
                return NavigationDrawerListItem(
                  title: "Login",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BlocProvider.value(
                        value: authenticationBloc,
                        child: const LoginScreen(
                          myAccountRedirect: "false",
                        ),
                      );
                    }));
                  },
                );
              },
            ),

            //Home
            NavigationDrawerListItem(
                title: "Home",
                onPress: () {
                  Navigator.of(context).pop();
                  //Navigator.pushNamed(context, StudentOfferScreen.id);
                }),

            //Student Offer
            NavigationDrawerListItem(
                title: "Student Offer",
                onPress: () {
                  Navigator.pushNamed(context, StudentOfferScreen.id);
                }),

            //Training
            NavigationDrawerListItem(
                title: "Training",
                onPress: () {
                  Navigator.pushNamed(context, ListOfChildren.id);
                }),

            //Support
            NavigationDrawerListItem(
                title: "Support",
                onPress: () {
                  Navigator.pushNamed(context, ListOfProduct.id);
                }),

            //Personal Shopper
            NavigationDrawerListItem(title: "Personal Shopper", onPress: () {}),

            //Contact
            NavigationDrawerListItem(
                title: "Contact",
                onPress: () {
                  Navigator.pushNamed(context, ContactPage.id);
                }),

            //Hot Deals
            NavigationDrawerListItem(
                title: "Hot Deals",
                onPress: () {
                  Navigator.pushNamed(context, HotDealsPage.id);
                }),

            //Logout
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  return NavigationDrawerListItem(
                    title: "Logout",
                    onPress: () {
                      authenticationBloc.add(LoggedOut(
                          state.loginData.userData!.token.toString()));
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
