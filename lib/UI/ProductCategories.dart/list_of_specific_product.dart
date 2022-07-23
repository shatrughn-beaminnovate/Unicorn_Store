import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/category/subcategory_types_bloc/subcategory_types_api_fetch_bloc.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory_Types/sub_category_types.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory_Types/subcategory_types_list.dart';
import 'package:unicorn_store/UI/HomePage/Components/build_app_bar.dart';
import 'package:unicorn_store/UI/HomePage/Components/price_tag.dart';
import '../Components/linear_indicator.dart';
import '../ProductPage/product_type_page.dart';
import '../size_config.dart';
import '../constant.dart';

class ListOfSpecificProduct extends StatefulWidget {
  static String id = "ListOfSpecificProduct";
  const ListOfSpecificProduct({Key? key}) : super(key: key);

  @override
  State<ListOfSpecificProduct> createState() => _ListOfSpecificProductState();
}

class _ListOfSpecificProductState extends State<ListOfSpecificProduct> {
  //Creating object for bloc
  final SubcategoryTypesApiFetchBloc _subcategoryTypesApiFetchBloc =
      SubcategoryTypesApiFetchBloc();

  // ignore: prefer_typing_uninitialized_variables
  var subcategoryData;
  String? token;

  @override
  void didChangeDependencies() {
    subcategoryData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    token=subcategoryData["token"];
    _subcategoryTypesApiFetchBloc.add(LoadSubcategoryTypesApiFetch(
        subCategoryTypesId: subcategoryData["id"]));
      
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _subcategoryTypesApiFetchBloc,
          child: BlocBuilder<SubcategoryTypesApiFetchBloc,
              SubcategoryTypesApiFetchState>(
            builder: (context, state) {
             if (state is SubcategoryTypesApiFetchLoading) {
                return const LinearIndicatorBar();
              } else if (state is SubcategoryTypesApiFetchLoaded) {
                return _buildProductList(context, state.subcategoryTypes);
              } else if (state is SubcategoryTypesApiFetchError) {
                return const Center(
                  child: Text("No Product Found"),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  //List of Product
  Widget _buildProductList(
      BuildContext context, SubcategoryTypesList subcategoryTypesList) {
    List<SubcategoryTypes>? subcategoryTypes = subcategoryTypesList.data;

    return Container(
      padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subcategoryData["name"],
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

          //List of Products
          Expanded(
            child: ListView.builder(
                itemCount: subcategoryTypes!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProductDetailsScreen.id,
                          arguments: {
                            "productTypeId": subcategoryTypes[index].types_id,
                            "token": token,
                            "productTypeSlug":subcategoryTypes[index].types_slug,
                            "productValue": " "
                          });
                    },
                    child: Container(
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
                              height: getProportionateScreenHeight(200),
                              width: getProportionateScreenWidth(200),
                              imageUrl:
                                  "$imageDefaultURL$imageSecondUrl${subcategoryTypes[index].type_image}",
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) => const Image(
                                  image: AssetImage("assets/NoImage.jpg"))),
                          SizedBox(
                            height: getProportionateScreenHeight(15.0),
                          ),
                          Text(
                            subcategoryTypes[index].types_name.toString(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15.0),
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15.0),
                          ),
                          Text(
                            "Apple",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15.0),
                                color: kDefaultTitleFontColor),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Starting from',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(15.0),
                                    color: kDefaultTitleFontColor),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(10.0),
                              ),
                              PriceTag(
                                price: subcategoryTypes[index]
                                    .saleprice
                                    .toString(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15.0),
                          ),
                          (subcategoryTypes[index].saleprice !=
                                      subcategoryTypes[index].price &&
                                  subcategoryTypes[index].price != 0)
                              ? Column(
                                  children: [
                                    PriceTag(
                                      price: subcategoryTypes[index]
                                          .price
                                          .toString(),
                                      textDecoration:
                                          TextDecoration.lineThrough,
                                      color: kDefaultTitleFontColor,
                                    ),
                                    SizedBox(
                                      height:
                                          getProportionateScreenHeight(15.0),
                                    ),
                                    Text(
                                      "${subcategoryTypes[index].discount}% off",
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(15.0),
                                          color: Colors.green),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: getProportionateScreenHeight(20.0),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
