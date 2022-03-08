import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/login/login_bloc.dart';
import 'package:unicorn_store/Data/Data_Providers/Login%20and%20Signup/login_details.dart';
import 'package:unicorn_store/UI/LoginPage/forgot_password.dart';
import 'package:unicorn_store/UI/main_screen.dart';
import 'package:unicorn_store/UI/size_config.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/LoginPage/sign_up_form.dart';
import 'package:unicorn_store/UI/constant.dart';
import 'package:unicorn_store/main.dart';
import 'Components/button_with_logo.dart';
import 'Components/custom_submit_button.dart';
import 'Components/form_validation.dart';
import 'Components/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  static String id = "Login_Form";
  final String? myAccountRedirect;
  final Map<String, String>? productValue;
  final String? productTypeId;
  final String? productPageId;

  const LoginScreen({Key? key, this.myAccountRedirect, this.productValue,this.productTypeId,this.productPageId})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginDetailsApi loginDetailsApi = LoginDetailsApi();

  //Calling login bloc
  LoginBloc loginBloc = LoginBloc();

  //This is key for form that uniquely identifies form
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print('@@@@@@@@@@@@@@@@@@@@@@ Login Data  ${widget.productValue}');
    return Scaffold(
      appBar: const BuildAppBar(),
      body: BlocProvider<LoginBloc>(
        create: (context) => loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginInitial) {
                if (widget.myAccountRedirect == "false") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MyApp(
                      myAccountRedirect: "true",
                    );
                  }));
                } else if (widget.myAccountRedirect == "true") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MyApp(
                      myAccountRedirect: "false",
                    );
                  }));
                } else if (widget.myAccountRedirect == "goToProductPageType") {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return MyApp(
                      myAccountRedirect: "goToProductPageType",
                      productValue: widget.productValue,
                      productTypeId: widget.productTypeId,
                      productPageId: widget.productPageId,
                    );
                  }));
                }
              }
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Your Username or Password is incorrect"),
                    backgroundColor: Colors.red,
                    duration: Duration(milliseconds: 2000),
                    // behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20.0),
                      vertical: getProportionateScreenHeight(20.0)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(15.0),
                        ),

                        //Login Page
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(25)),
                        ),
                        const Divider(
                          color: kDefaultBorderColor,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(35.0),
                        ),

                        //Email Field
                        TextInputField(
                          textInputType: TextInputType.emailAddress,
                          title: "E-Mail",
                          validator: (value) {
                            return FormValidation.emailValidation(value);
                          },
                          textEditingController: _email,
                          isMandatory: true,
                          obscureText: false,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),

                        //Password Field
                        TextInputField(
                          title: "Password",
                          validator: (value) {
                            return FormValidation.passwordValidation(value);
                          },
                          textInputType: TextInputType.text,
                          textEditingController: _password,
                          isMandatory: true,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),

                        //Forgot Password
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, MainScreen.id);
                              },
                              child: Text(
                                "Return To Store",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize:
                                        getProportionateScreenWidth(14.0)),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ForgotPassword.id,
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize:
                                        getProportionateScreenWidth(14.0)),
                              ),
                            ),
                          ],
                        ),

                        const Divider(
                          color: kDefaultBorderColor,
                          thickness: 1,
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(35.0),
                        ),

                        //Login Button
                        LoginButton(
                          title: "Login",
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              loginBloc.add(LoginButtonPressed(
                                  username: _email.text,
                                  password: _password.text));
                            }
                          },
                          color: const Color(0xFF1F99CF),
                          height: 40.0,
                          width: double.infinity,
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),

                        //Sign in With
                        Text("- OR -",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0),
                            )),
                        SizedBox(
                          height: getProportionateScreenHeight(15.0),
                        ),
                        Text(
                          "Sign in with",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0)),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Login With Google Button
                            ButtonWithLogo(
                              title: "Google",
                              imageSrc: "assets/google_logo.png",
                              onPress: () {},
                            ),

                            //Login With OTP Button
                            SizedBox(
                              height: 40,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.message_sharp,
                                  size: getProportionateScreenWidth(20.0),
                                ),
                                label: Text(
                                  "OTP",
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(15.0)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color(0xFF1F99CF), // background
                                  onPrimary: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ), // <-- Radius
                                  ), // foreground
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),
                        //Login With Apple Button
                        ButtonWithLogo(
                          width: double.infinity,
                          title: "Sign in with Apple Id",
                          imageSrc: "assets/apple_logo.png",
                          onPress: () {},
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(25.0),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Don\'t have an Account? ',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15.0),
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          getProportionateScreenWidth(15.0),
                                      color: Colors.green),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, SignUpForm.id);
                                    }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
