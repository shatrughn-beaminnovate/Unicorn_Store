import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/login/login_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/login_with_otp/bloc/login_with_otp_bloc.dart';
import 'package:unicorn_store/Data/Data_Providers/Login%20and%20Signup/login_details.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/LoginPage/forgot_password.dart';
import 'package:unicorn_store/UI/main_screen.dart';
import 'package:unicorn_store/UI/size_config.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/LoginPage/sign_up_form.dart';
import 'package:unicorn_store/UI/constant.dart';
import 'package:unicorn_store/main.dart';
import '../Components/default_snackbar.dart';
import 'Components/button_with_logo.dart';
import 'Components/custom_submit_button.dart';
import 'Components/form_validation.dart';
import 'Components/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  static String id = "Login_Form";
  final String? myAccountRedirect;
  final Map<String, String>? productValue;
  final String? productTypeSlug;
  final String? productPageId;
  final String? productTypeId;

  const LoginScreen(
      {Key? key,
      this.myAccountRedirect,
      this.productValue,
      this.productTypeId,
      this.productTypeSlug,
      this.productPageId})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginDetailsApi loginDetailsApi = LoginDetailsApi();

  //Calling login bloc
  LoginBloc loginBloc = LoginBloc();
  LoginWithOtpBloc loginWithOtpBloc = LoginWithOtpBloc();

  bool? error = true;
  bool? otpErrorStatus = false;
  String? otpErrorMessage = "";
  String? otpBorderColorError = "false";
  Map<String, dynamic>? sendOtpResponse;

  bool isProgress = false;

  //This is key for form that uniquely identifies form
  final _formKey = GlobalKey<FormState>();
  final _formSecondkey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _otpInput = TextEditingController();
  final TextEditingController _optNumber = TextEditingController();
  // final TextEditingController _optInput2 = TextEditingController();
  // final TextEditingController _optInput3 = TextEditingController();
  // final TextEditingController _optInput4 = TextEditingController();
  // final TextEditingController _optInput5 = TextEditingController();
  // final TextEditingController _optInput6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: const BuildAppBar(),
          body: BlocProvider<LoginBloc>(
            create: (context) => loginBloc,
            child:
                BlocListener<LoginBloc, LoginState>(listener: (context, state) {
              if (state is LoginLoading) {
                setState(() {
                  isProgress = true;
                });
              }
              if (state is LoginInitial) {
                if (widget.myAccountRedirect == "false") {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const MyApp(
                      myAccountRedirect: "true",
                    );
                  }), (Route<dynamic> route) => false);
                } else if (widget.myAccountRedirect == "true") {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const MyApp(
                      myAccountRedirect: "false",
                    );
                  }), (Route<dynamic> route) => false);
                } else if (widget.myAccountRedirect == "goToProductPageType") {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp(
                      myAccountRedirect: "goToProductPageType",
                      productValue: widget.productValue,
                      productTypeSlug: widget.productTypeSlug,
                      productPageId: widget.productPageId,
                      productTypeId: widget.productTypeId,
                    );
                  }), (Route<dynamic> route) => false);
                } else if (widget.myAccountRedirect ==
                    "goToAccessoriesProductPage") {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp(
                      myAccountRedirect: "goToAccessoriesProductPage",
                      productPageId: widget.productPageId,
                    );
                  }), (Route<dynamic> route) => false);
                }
              }
              if (state is LoginFailure) {
                setState(() {
                  isProgress = false;
                });
                //  print(state);
                ScaffoldMessenger.of(context).showSnackBar(
                  // ignore: prefer_const_constructors
                  defaultSnackBar("Incorrect username or password", Colors.red,
                      Colors.white, 2000),
                );
              }
            }, child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                // if(state is LoginLoading)
                // {
                //   return const LoadingIndicatorBar();
                // }
                return SafeArea(
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
                                    onPressed: () {
                                      _buildOTPForm(context);
                                    },
                                    icon: Icon(
                                      Icons.message_sharp,
                                      size: getProportionateScreenWidth(20.0),
                                    ),
                                    label: Text(
                                      "OTP",
                                      style: TextStyle(
                                          fontSize: getProportionateScreenWidth(
                                              15.0)),
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
                );
              },
            )),
          ),
        ),
        (isProgress) ? const LoadingIndicatorBar() : Container()
      ],
    );
  }

  Future<void> _buildOTPForm(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      //isScrollControlled: true,
      builder: (BuildContext context) {
        // print("loginWithOtpBloc:  ${loginWithOtpBloc.state}");
        return BlocProvider.value(
          value: loginWithOtpBloc,
          child: BlocListener<LoginWithOtpBloc, LoginWithOtpState>(
            listener: (context, state) {
              if (state is LoginWithOtpFailure) {
                setState(() {
                  error = state.response["status"];
                  sendOtpResponse = state.response;
                });
                //    print(sendOtpResponse);
              }
              if (state is LoginWithOtpVerify) {
                if (widget.myAccountRedirect == "false") {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const MyApp(
                      myAccountRedirect: "true",
                    );
                  }), (Route<dynamic> route) => false);
                } else if (widget.myAccountRedirect == "true") {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const MyApp(
                      myAccountRedirect: "false",
                    );
                  }), (Route<dynamic> route) => false);
                } else if (widget.myAccountRedirect == "goToProductPageType") {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp(
                      myAccountRedirect: "goToProductPageType",
                      productValue: widget.productValue,
                      productTypeSlug: widget.productTypeSlug,
                      productPageId: widget.productPageId,
                      productTypeId: widget.productTypeId,
                    );
                  }), (Route<dynamic> route) => false);
                } else if (widget.myAccountRedirect ==
                    "goToAccessoriesProductPage") {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp(
                      myAccountRedirect: "goToAccessoriesProductPage",
                      productPageId: widget.productPageId,
                    );
                  }), (Route<dynamic> route) => false);
                }
              }
              if (state is LoginWithOtpSendSuccess) {
                _listenAutoOpt();
              }
              if (state is LoginWithOtpVerifyFailure) {
                setState(() {
                  otpErrorStatus = state.response.status;
                  otpErrorMessage = "Incorrect OTP details";
                  otpBorderColorError = "true";
                });
                //   print("..............................$otpBorderColorError");

                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("Incorrect OTP Details!"),
                //     backgroundColor: Colors.red,
                //     duration: Duration(milliseconds: 2000),
                //     // behavior: SnackBarBehavior.floating,
                //   ),
                // );
              }

              if (state is LoginWithOtpError) {
                //     print(state);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                    duration: const Duration(milliseconds: 2000),
                    // behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formSecondkey,
                child: Container(
                  height: getProportionateScreenHeight(500),
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  child: SingleChildScrollView(
                    child: Column(
                      //  mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //                    <--- top side
                                color: Colors.black26,
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Enter mobile number to receive verification code.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0,
                                height: 1.5,
                                color: Colors.black45),
                          ),
                        ),

                        // const Divider(

                        //   color: Colors.black26,
                        //   thickness: 2.0,
                        // ),
                        BlocBuilder<LoginWithOtpBloc, LoginWithOtpState>(
                          builder: (context, state) {
                            if (state is LoginWithOtpLoading) {
                              return const LinearProgressIndicator(
                                minHeight: 5,
                                color: Color(0xFF1F99CF),
                                backgroundColor: Colors.transparent,
                              );
                            }
                            if (state is LoginWithOtpSendSuccess) {
                              return _buildEnterOtpDetailsForm();
                            }
                            if (state is LoginWithOtpInitial) {
                              return _buildSendOtpForm();
                            }
                            if (state is LoginWithOtpFailure) {
                              return _buildSendOtpForm();
                            }
                            if (state is LoginWithOtpVerifyFailure) {
                              return _buildEnterOtpDetailsForm();
                            }
                            if (state is LoginWithOtpError) {
                              return Container(
                                  margin: EdgeInsets.only(
                                      top: getProportionateScreenHeight(150.0)),
                                  child: Text(
                                    state.error,
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.black54),
                                  ));
                            }
                            return Container();
                          },
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEnterOtpDetailsForm() {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(30.0),
        ),
        Text(
          "Code has send to \n ${_otpInput.text}",
          textAlign: TextAlign.center,
          style: const TextStyle(
              height: 1.5, fontSize: 16.0, color: Colors.black54),
        ),
        SizedBox(
          height: getProportionateScreenHeight(25.0),
        ),
        PinFieldAutoFill(
          controller: _optNumber,
          decoration: UnderlineDecoration(
            textStyle: const TextStyle(fontSize: 20, color: Colors.black),
            colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
          ),
          //currentCode: "6",
          cursor: Cursor(color: Colors.black54, enabled: true),
          currentCode: "",
          textInputAction: TextInputAction.none,
          onCodeSubmitted: (code) {},
          onCodeChanged: (code) {
            if (code!.length == 6) {
              FocusScope.of(context).requestFocus(FocusNode());
              loginWithOtpBloc.add(VerifyOtpEvent(_otpInput.text, code));
            }
          },
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     OtpInputField(
        //       width: 40.0,
        //       controller: _optInput1,
        //       // onChanged: (value) {
        //       //   if (value.isNotEmpty) {
        //       //     setState(() {
        //       //       otpErrorMessage = "true";
        //       //     });
        //       //   }
        //       // },
        //       error: otpBorderColorError,
        //       // validator: (value) {
        //       //   if (value!.isEmpty) {
        //       //     return "Please";
        //       //   }
        //       //   return null;
        //       // },
        //     ),
        //     OtpInputField(
        //       // validator: (value) {
        //       //   if (value!.isEmpty) {
        //       //     return " ";
        //       //   }
        //       //   return null;
        //       // },
        //       // onChanged: (value) {
        //       //   if (value.isNotEmpty) {
        //       //     setState(() {
        //       //       otpErrorMessage = "true";
        //       //     });
        //       //   }
        //       // },
        //       error: otpBorderColorError,

        //       width: 40.0,
        //       controller: _optInput2,
        //     ),
        //     OtpInputField(
        //       // validator: (value) {
        //       //   if (value!.isEmpty) {
        //       //     return " ";
        //       //   }
        //       //   return null;
        //       // },
        //       // onChanged: (value) {
        //       //   if (value.isNotEmpty) {
        //       //     setState(() {
        //       //       otpErrorMessage = "true";
        //       //     });
        //       //   }
        //       // },
        //       error: otpBorderColorError,

        //       width: 40.0,
        //       controller: _optInput3,
        //     ),
        //     OtpInputField(
        //       // validator: (value) {
        //       //   if (value!.isEmpty) {
        //       //     return " ";
        //       //   }
        //       //   return null;
        //       // },
        //       // onChanged: (value) {
        //       //   if (value.isNotEmpty) {
        //       //     setState(() {
        //       //       otpErrorMessage = "true";
        //       //     });
        //       //   }
        //       // },
        //       error: otpBorderColorError,

        //       width: 40.0,
        //       controller: _optInput4,
        //     ),
        //     OtpInputField(
        //       // validator: (value) {
        //       //   if (value!.isEmpty) {
        //       //     return " ";
        //       //   }
        //       //   return null;
        //       // },
        //       // onChanged: (value) {
        //       //   if (value.isNotEmpty) {
        //       //     setState(() {
        //       //       otpErrorMessage = "true";
        //       //     });
        //       //   }
        //       // },
        //       error: otpBorderColorError,

        //       width: 40.0,
        //       controller: _optInput5,
        //     ),
        //     OtpInputField(
        //       // validator: (value) {
        //       //   if (value!.isEmpty) {
        //       //     return " ";
        //       //   }
        //       //   return null;
        //       // },
        //       // onChanged: (value) {
        //       //   if (value.isNotEmpty) {
        //       //     setState(() {
        //       //       otpErrorMessage = "true";
        //       //     });
        //       //   }
        //       // },
        //       error: otpBorderColorError,

        //       width: 40.0,
        //       controller: _optInput6,
        //     )
        //   ],
        // ),

        SizedBox(
          height: getProportionateScreenHeight(20.0),
        ),
        (otpErrorStatus!)
            ? Container()
            : Text(
                otpErrorMessage!,
                style: const TextStyle(fontSize: 14.0, color: Colors.red),
              ),
        SizedBox(
          height: getProportionateScreenHeight(40.0),
        ),
        const Text(
          "Haven't recieved the verfication code?",
          style: TextStyle(fontSize: 14.0, color: Colors.black54),
        ),
        TextButton(
            onPressed: () {
              loginWithOtpBloc.add(SendOtpEvent(_otpInput.text));
            },
            child: const Text(
              "Resend",
              style: TextStyle(fontSize: 14.0, color: Color(0xFF1F99CF)),
            )),
        // LoginButton(
        //     title: "Verify",
        //     color: const Color(0xFF1F99CF),
        //     width: SizeConfig.screenWidth! / 0.8,
        //     onPress: () {

        //       loginWithOtpBloc.add(VerifyOtpEvent(_otpInput.text, _optNumber.text));
        //     }),
        SizedBox(
          height: getProportionateScreenHeight(40.0),
        ),
      ],
    );
  }

  Widget _buildSendOtpForm() {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(100.0),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          child: PhoneFieldHint(
            controller: _otpInput,
            decoration: InputDecoration(
              //isDense: true,
              errorText: (error!)
                  ? null
                  : sendOtpResponse!["Error"] ?? sendOtpResponse!["response"],
              errorStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.red,
                fontSize: 14.0,
              ),
              floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                  (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? Colors.red
                    : const Color(0xFF1F99CF);
                return TextStyle(
                  color: color,
                  fontSize: 14.0,
                  fontFamily: "Roboto",
                );
              }),
              label: const Text("Enter Mobile Number"),

              labelStyle: TextStyle(
                  fontSize: 14.0, color: Colors.black.withOpacity(0.6)),
              contentPadding: EdgeInsets.all(getProportionateScreenWidth(12.0)),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1F99CF), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1F99CF), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          //  TextFormField(
          //   controller: _otpInput,
          //   keyboardType: TextInputType.number,
          //   cursorColor: Colors.black,
          //   onChanged: (value) {
          //     if (value.isEmpty) {
          //       setState(() {
          //         error = true;
          //       });
          //     }
          //   },
          //   decoration: InputDecoration(
          //     //isDense: true,
          //     errorText: (error!)
          //         ? null
          //         : sendOtpResponse!["Error"] ?? sendOtpResponse!["response"],
          //     errorStyle: const TextStyle(
          //       fontFamily: "Roboto",
          //       color: Colors.red,
          //       fontSize: 14.0,
          //     ),
          //     floatingLabelStyle: MaterialStateTextStyle.resolveWith(
          //         (Set<MaterialState> states) {
          //       final Color color = states.contains(MaterialState.error)
          //           ? Colors.red
          //           : const Color(0xFF1F99CF);
          //       return TextStyle(
          //         color: color,
          //         fontSize: 14.0,
          //         fontFamily: "Roboto",
          //       );
          //     }),
          //     label: const Text("Enter Mobile Number"),

          //     labelStyle: TextStyle(
          //         fontSize: 14.0, color: Colors.black.withOpacity(0.6)),
          //     contentPadding: EdgeInsets.all(getProportionateScreenWidth(12.0)),
          //     border: const OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(5.0))),
          //     enabledBorder: const OutlineInputBorder(
          //       borderSide: BorderSide(color: Color(0xFF1F99CF), width: 1.0),
          //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //     ),
          //     focusedBorder: const OutlineInputBorder(
          //       borderSide: BorderSide(color: Color(0xFF1F99CF), width: 1.0),
          //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //     ),
          //   ),
          // ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(50.0),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: LoginButton(
            width: SizeConfig.screenWidth! / 0.8,
            title: "Request OTP",
            onPress: () async {
              //  final appSignatureCode = await SmsAutoFill().getAppSignature;
              //   print("Appsignature: $appSignatureCode");
              loginWithOtpBloc.add(SendOtpEvent(_otpInput.text));
            },
            color: const Color(0xFF1F99CF),
            height: 40.0,
          ),
        ),
      ],
    );
  }

  void _listenAutoOpt() async {
    await SmsAutoFill().listenForCode();
  }
}

class OtpInputField extends StatelessWidget {
  const OtpInputField(
      {Key? key,
      required this.controller,
      required this.width,
      this.onChanged,
      this.error,
      this.validator})
      : super(key: key);

  final double width;
  final TextEditingController controller;
  final String? error;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        controller: controller,
        style: TextStyle(
          fontSize: 16.0,
          color: const Color(0xFF000000).withOpacity(0.6),
        ),
        keyboardType: const TextInputType.numberWithOptions(
          decimal: false,
          signed: true,
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(
            1,
          )
        ],
        decoration: InputDecoration(
          // errorText: error,
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(5.0)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: (error == "true") ? Colors.red : Colors.black26,
                width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1F99CF), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
