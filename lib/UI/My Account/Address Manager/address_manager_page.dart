import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/my_account/address%20manager/address_manager_details_api_fetch_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/my_account/address%20manager/set_default_address_bloc.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Login/login_data.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/address.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/address_list.dart';
import 'package:unicorn_store/UI/Components/loading_indicator_bar.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/LoginPage/Components/custom_submit_button.dart';
import 'package:unicorn_store/UI/My%20Account/Address%20Manager/address_manager_form.dart';
import 'package:unicorn_store/UI/size_config.dart';

import '../../constant.dart';

class AddressManagerPage extends StatefulWidget {
  static String id = "Address_Manager";
  const AddressManagerPage({Key? key}) : super(key: key);

  @override
  State<AddressManagerPage> createState() => _AddressManagerPageState();
}

class _AddressManagerPageState extends State<AddressManagerPage> {
  String? billing;
  String? shipping;

  String? secondBillingValue = " ";
    String? secondShippingValue = " ";

  List<Address>? address;
  //Creating object for category bloc
  final AddressManagerDetailsApiFetchBloc _addressManagerDetailsApiFetchBloc =
      AddressManagerDetailsApiFetchBloc();
  final SetDefaultAddressBloc _setDefaultAddressBloc = SetDefaultAddressBloc();

  // ignore: prefer_typing_uninitialized_variables
  var userData;

  //Creating instance for LoginData
  LoginData? loginData;

  @override
  void didChangeDependencies() {
     userData = ModalRoute.of(context)?.settings.arguments;
    loginData = userData["loginData"];
    _addressManagerDetailsApiFetchBloc
        .add(LoadAddressDetailsApiFetch(customerId: "25",token:loginData!.token!));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(),
      body: SafeArea(
        child:

            //When Address is Empty
            // Container(
            //   child: Center(
            //     child: Text(
            //       "No Address Available.",
            //       style: TextStyle(
            //           fontSize: getProportionateScreenWidth(15.0),
            //           color: kDefaultHeaderFontColor),
            //     ),
            //   ),
            // ),

            MultiBlocProvider(
          providers: [
            BlocProvider<AddressManagerDetailsApiFetchBloc>(
              create: (BuildContext context) =>
                  _addressManagerDetailsApiFetchBloc,
            ),
            BlocProvider<SetDefaultAddressBloc>(
              create: (BuildContext context) => _setDefaultAddressBloc,
            ),
          ],
          child: BlocListener<AddressManagerDetailsApiFetchBloc,
              AddressManagerDetailsApiFetchState>(
            listener: (context, state) {
              if (state is DeleteCustomerAddressSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Your address has been deleted!"),
                    backgroundColor: Colors.green,
                    duration: Duration(milliseconds: 2000),
                    // behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: BlocBuilder<AddressManagerDetailsApiFetchBloc,
                AddressManagerDetailsApiFetchState>(builder: (context, state) {
              if (state is AddressManagerDetailsApiFetchInitial) {
                return LoadingIndicatorBar();
              } else if (state is AddressManagerDetailsApiFetchLoading) {
                return LoadingIndicatorBar();
              } else if (state is AddressManagerDetailsApiFetchLoaded) {
                return _buildAddressManagerList(context, state.addressList);
                // } else if (state is DefaultAdressSetState) {
                //   return _buildAddressManagerList(context, state.addressList);
                //
              } else if (state is AddressManagerDetailsApiFetchError) {
                return const Center(
                  child: Text("No Address Found"),
                );
              } else if (state is DeleteCustomerAddressSuccess) {
                return _buildAddressManagerList(context, state.addressList);
              } else {
                return Container();
              }
            }),
          ),
        ),
      ),
    );
  }



  //List of User Address
  Widget _buildAddressManagerList(
      BuildContext context, AddressList addressList) {
    address = addressList.address;
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              LoginButton(
                title: "Add Address",
                onPress: () {
                  Navigator.pushNamed(context, AddressManagerForm.id,
                      arguments: {
                        "customerId": address![0].customerId.toString(),
                        "addressId": "",
                        "loginData":loginData
                      });
                },
                color: const Color(0xFF1F99CF),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: address!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (address![index].defaultBillingAddress ==
                        address![index].id) {
                      billing = address![index].id.toString();
                    }
                    if (address![index].defaultsShippingAddress ==
                        address![index].id) {
                      shipping = address![index].id.toString();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          color: kDefaultBorderColor,
                          thickness: 1,
                        ),

                        //First name and last name
                        Text(
                          "${address![index].addressFieldData!.firstname}"
                          " "
                          "${address![index].addressFieldData!.lastname}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0),
                              color: const Color(0xFF444444)),
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(5.0),
                        ),

                        //Phone number
                        Text(
                          "${address![index].addressFieldData!.phone}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0),
                              color: const Color(0xFF444444)),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5.0),
                        ),

                        //Address1 and Address2
                        Text(
                          "${address![index].addressFieldData!.address1}"
                          ","
                          "  "
                          "${address![index].addressFieldData!.address2}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0),
                              color: const Color(0xFF444444)),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5.0),
                        ),

                        //Zip Code
                        Text(
                          "${address![index].addressFieldData!.zip}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0),
                              color: const Color(0xFF444444)),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5.0),
                        ),

                        //Country Name
                        Text(
                          "${address![index].addressFieldData!.country}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15.0),
                              color: const Color(0xFF444444)),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(30.0),
                        ),
                        //Default billing and shipping address
                        BlocBuilder<SetDefaultAddressBloc,
                            SetDefaultAddressState>(
                          builder: (context, state) {
                            return _buildDefaultBillingRadio(address, index);
                          },
                        ),

                        //Edit and Delete Button
                        Row(
                          children: [
                            LoginButton(
                              title: "Edit",
                              onPress: () {
                                Navigator.pushNamed(
                                    context, AddressManagerForm.id,
                                    arguments: {
                                      "customerId":
                                          address![index].customerId.toString(),
                                      "addressId": address![index].id.toString(),
                                      "loginData":loginData
                                    });
                              },
                              color: const Color(0xFF1F99CF),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(5.0),
                            ),
                            LoginButton(
                              title: "Delete",
                              onPress: () {
                                if (addressList.address!.length == 1) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "You Must leave at least 1 address in the Address Manager."),
                                      backgroundColor: Colors.red,
                                      duration: Duration(milliseconds: 1500),
                                      // behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Delete Address'),
                                      content: const Text(
                                          'Are you sure you want to delete this address?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _addressManagerDetailsApiFetchBloc
                                                .add(DeleteCustomerAddressEvent(
                                              addressId:
                                                  address![index].id.toString(),
                                              customerId: address![index]
                                                  .customerId
                                                  .toString(),
                                              token: loginData!.token!
                                            ));

                                            Navigator.pop(context, 'OK');
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              color: Colors.grey[400]!,
                              onPrimary: Colors.black38,
                            ),
                          ],
                        )
                      ],
                    );
                  }),
            ])));
  }

  //Radio button for Default Billing address and Default Shipping address
  Widget _buildDefaultBillingRadio(List<Address>? address, int index) {
    
    return Column(children: [
      //Default Billing
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(20.0),
            width: getProportionateScreenHeight(20.0),
            child: Radio<String>(
              value: address![index].id.toString(),
              groupValue: (secondBillingValue == " ") ? billing : secondBillingValue,
              onChanged: (String? value) {
                setState(() {
                  secondBillingValue = value;
                });
                _setDefaultAddressBloc.add(SetDefaultAddresssDetails(
                    customerId: address[index].customerId.toString(),
                    addressId: address[index].id.toString(),
                    addressType: "billing",
                    token: loginData!.token!));
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10.0),
          ),
          Text(
            'Default Billing',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15.0),
                color: const Color(0xFF444444)),
          ),
        ],
      ),
      SizedBox(
        height: getProportionateScreenHeight(10.0),
      ),

      //Default Shipping
      Row(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(20.0),
            width: getProportionateScreenHeight(20.0),
            child: Radio<String>(
              value: address[index].id.toString(),
              groupValue: (secondShippingValue == " ") ? shipping : secondShippingValue,
              onChanged: (String? value) {
                _setDefaultAddressBloc.add(SetDefaultAddresssDetails(
                    customerId: address[index].customerId.toString(),
                    addressId: address[index].id.toString(),
                    addressType: "shipping",
                    token: loginData!.token!));

                setState(() {
                  secondShippingValue = value;
                });
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10.0),
          ),
          Text(
            'Default Shipping',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15.0),
                color: const Color(0xFF444444)),
          ),
        ],
      ),

      SizedBox(
        height: getProportionateScreenHeight(15.0),
      ),
    ]);
  }
}
