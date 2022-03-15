import 'package:flutter/material.dart';
import 'package:unicorn_store/UI/HomePage/home_page.dart';
import 'package:unicorn_store/UI/HomePage/NavigationDrawer/Contact/contact_page.dart';
import 'package:unicorn_store/UI/HomePage/NavigationDrawer/Hot%20Deals/hot_deals_page.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/Accessories/list_of_children.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/Accessories/list_of_product.dart';
import 'package:unicorn_store/UI/initial_screen.dart';
import 'package:unicorn_store/UI/LoginPage/forgot_password.dart';
import 'package:unicorn_store/UI/LoginPage/sign_up_form.dart';
import 'package:unicorn_store/UI/main_screen.dart';
import 'package:unicorn_store/UI/My%20Account/account_information_page.dart';
import 'package:unicorn_store/UI/My%20Account/Address%20Manager/address_manager_form.dart';
import 'package:unicorn_store/UI/My%20Account/Address%20Manager/address_manager_page.dart';
import 'package:unicorn_store/UI/My%20Account/Checkout%20Page/billing_address.dart';
import 'package:unicorn_store/UI/My%20Account/Checkout%20Page/checkout_page.dart';
import 'package:unicorn_store/UI/My%20Account/Checkout%20Page/confirm_order.dart';
import 'package:unicorn_store/UI/My%20Account/Checkout%20Page/payment_methods.dart';
import 'package:unicorn_store/UI/My%20Account/Checkout%20Page/shipping_address.dart';
import 'package:unicorn_store/UI/My%20Account/Order%20History/order_details.dart';
import 'package:unicorn_store/UI/My%20Account/Order%20History/reviews_and_ratings.dart';
import 'package:unicorn_store/UI/My%20Account/Order%20History/product_history.dart';
import 'package:unicorn_store/UI/My%20Account/wishlist_page.dart';
import 'package:unicorn_store/UI/OnBoarding%20Screen/on_boarding_page.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/list_of_specific_product.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/product_categories.dart';
import 'package:unicorn_store/UI/ProductPage/product_page.dart';
import 'package:unicorn_store/UI/ProductPage/product_type_page.dart';
import 'package:unicorn_store/UI/text_file.dart';
import 'HomePage/Add Cart/add_to_cart.dart';
import 'HomePage/NavigationDrawer/Student Offer/student_offer_screen.dart';
import 'LoginPage/login_form.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.id: (context) => const LoginScreen(),
  HomePage.id: (context) => const HomePage(),
  MainScreen.id: (context) => MainScreen(
        selectedIndex: 0,
      ),
  AddToCartPage.id: (context) => const AddToCartPage(),
  StudentOfferScreen.id: (context) => const StudentOfferScreen(),
  SignUpForm.id: (context) => const SignUpForm(),
  ProductDetailsScreen.id: (context) => const  ProductDetailsScreen(),
  ContactPage.id: (context) => const ContactPage(),
  TextFile.id: (context) => const TextFile(),
  AccountInformationPage.id: (context) => const AccountInformationPage(),
  AddressManagerPage.id: (context) => const AddressManagerPage(),
  AddressManagerForm.id: (context) => const AddressManagerForm(),
  WishlistPage.id: (context) => const WishlistPage(),
  ProductHistory.id: (context) => const ProductHistory(),
  ReviewAndRating.id: (context) => const ReviewAndRating(),
  ForgotPassword.id: (context) => const ForgotPassword(),
  ProductCategories.id: (context) => const ProductCategories(),
  ListOfSpecificProduct.id: (context) => const ListOfSpecificProduct(),
  ProductPage.id: (context) =>  ProductPage(),
  HotDealsPage.id: (context) => const HotDealsPage(),
  OnBoardingPage.id: (context) => const OnBoardingPage(),
  InitialScreen.id: (context) => const InitialScreen(),
  CheckoutPage.id: (context) => const CheckoutPage(),
  BillingAddress.id: (context) => const BillingAddress(),
  CheckoutPage.id: (context) => const CheckoutPage(),
  ConfirmOrder.id: (context) => const ConfirmOrder(),
  ShippingAddress.id: (context) => const ShippingAddress(),
  PaymentMethod.id: (context) => const PaymentMethod(),
  OrderDetails.id: (context) =>  OrderDetails(),
  ListOfChildren.id: (context) => const ListOfChildren(),
  ListOfProduct.id: (context) => ListOfProduct(),
};
