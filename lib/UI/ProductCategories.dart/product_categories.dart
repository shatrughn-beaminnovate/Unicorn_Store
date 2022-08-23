import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/category/accessories_bloc/accessories_data_fetch_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/category/category_bloc/category_api_fetch_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_list_data.dart';
import 'package:unicorn_store/Data/Models/Category/NewCategory/category_data.dart';
import 'package:unicorn_store/UI/Components/linear_indicator.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/Accessories/list_of_children.dart';
import '../size_config.dart';
import '../constant.dart';

class ProductCategories extends StatefulWidget {
  static String id = "ProductCategories_Screen";

  const ProductCategories({Key? key}) : super(key: key);

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  bool isExpanded = false;
  int? selected = 0;
  String? categoryName;

  bool isProgress = false;

  //Creating object for category bloc
  final CategoryApiFetchBloc _categoryApiFetchBloc = CategoryApiFetchBloc();

  //Creating instance of accessories bloc
  final AccessoriesDataFetchBloc _accessoriesDataFetchBloc =
      AccessoriesDataFetchBloc();
  late AuthenticationBloc authenticationBloc;

  //Load Category
  List<CategoryData>? cat;

  //Load accessories data
  AccessoriesListData? accessoriesListData;

  String? token;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    //add Event to load all available category
    _categoryApiFetchBloc.add(LoadCategoryApiFetch());
    _accessoriesDataFetchBloc.add(const LoadAccessoriesDataFetch(
      subCategoryId: "accessories",
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          token = state.loginData.userData!.token;
        } else if (state is AuthenticationUnauthenticated) {
          token = "";
        }
        return SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MultiBlocProvider(
                      providers: [
                        BlocProvider<CategoryApiFetchBloc>(
                          create: (BuildContext context) =>
                              _categoryApiFetchBloc,
                        ),
                        BlocProvider<AccessoriesDataFetchBloc>(
                          create: (BuildContext context) =>
                              _accessoriesDataFetchBloc,
                        ),
                      ],
                      child: BlocListener<CategoryApiFetchBloc,
                          CategoryApiFetchState>(
                        listener: (context, state) {
                          if (state is CategoryApiFetchLoading) {
                            setState(() {
                              isProgress = true;
                            });
                          }
                          if (state is CategoryApiFetchLoaded) {
                            setState(() {
                              isProgress = false;
                              cat = state.category;
                            });
                          } else if (state is CategoryApiFetchError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message!),
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<CategoryApiFetchBloc,
                            CategoryApiFetchState>(
                          builder: (context, state) {
                            if (state is CategoryApiFetchLoading) {
                              return const LinearIndicatorBar();
                            }
                            if (state is CategoryApiFetchLoaded) {
                              //print(state.category);

                              return _buildCategory(context, state.category);
                            } else if (state is CategoryApiFetchError) {
                              return Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical:
                                          (MediaQuery.of(context).size.height /
                                              3)),
                                  child: const Text("No Category Found"),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //  (isProgress) ? LoadingIndicatorBar() : const Center(),
            ],
          ),
        );
      },
    );
  }

  //List of categories
  Widget _buildCategory(BuildContext context, List<CategoryData> category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(15.0),
        ),
        Text("   Categories",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(25.0),
                color: kDefaultTitleFontColor)),
        const Divider(
          color: kDefaultBorderColor,
          thickness: 1,
        ),
        ListView.builder(
          key: Key('builder ${selected.toString()}'),
          shrinkWrap: true,
          itemCount: category.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return (category[index].is_navigable.toString() == "1")
                ? Container(
                    margin: EdgeInsets.only(
                        bottom: getProportionateScreenHeight(10.0)),
                    // color: index.isEven?Colors.white:Colors.grey[300],
                    color: Colors.white,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.only(
                            left: getProportionateScreenWidth(40.0),
                            right: getProportionateScreenWidth(40.0),
                            bottom: getProportionateScreenHeight(20.0),
                            top: getProportionateScreenHeight(20.0)),

                        // ignore: avoid_unnecessary_containers
                        trailing: CachedNetworkImage(
                            imageUrl:
                                "$categoryImageUrl/categories/small/${category[index].image}",
                            placeholder: (context, url) => const SizedBox(
                                  height: 50,
                                  width: 50,
                                ),
                            errorWidget: (context, url, error) => const Image(
                                image: AssetImage("assets/NoImage.jpg"))),
                        initiallyExpanded:
                            isExpanded && index == selected, //attention
                        onExpansionChanged: (state) {
                          if (state) {
                            setState(() {
                              isExpanded = state;
                              selected = index;
                            });
                          } else {
                            setState(() {
                              selected = -1;
                            });
                          }
                        },
                        title: Row(
                          children: [
                            Flexible(
                              child: Text(
                                category[index].name.toString(),
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(20.0),
                                    overflow: TextOverflow.ellipsis,
                                    color: (isExpanded && selected == index)
                                        ? kDefaultSecondaryButtonColor
                                        : kDefaultTitleFontColor),
                              ),
                            ),
                            SizedBox(width: getProportionateScreenWidth(5.0)),
                            (isExpanded && selected == index)
                                ? RotatedBox(
                                    quarterTurns: 135,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: getProportionateScreenHeight(12.0),
                                      color: kDefaultSecondaryButtonColor,
                                    ))
                                : RotatedBox(
                                    quarterTurns: 45,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: getProportionateScreenHeight(12.0),
                                      color: kDefaultTitleFontColor,
                                    )),
                          ],
                        ),
                        children: [
                          // (category[index].name == "Accessories")
                          //     ? BlocListener<AccessoriesDataFetchBloc,
                          //         AccessoriesDataFetchState>(
                          //         listener: (context, state) {
                          //           if (state is AccessoriesDataFetchLoaded) {
                          //             setState(() {
                          //               accessoriesListData =
                          //                   state.accessoriesListData;
                          //             });
                          //           }
                          //         },
                          //         child: BlocBuilder<AccessoriesDataFetchBloc,
                          //             AccessoriesDataFetchState>(
                          //           builder: (context, state) {
                          //             if (state is AccessoriesDataFetchLoaded) {
                          //               accessoriesListData =
                          //                   state.accessoriesListData;
                          //               return _buildAccessoriesSubcategories(
                          //                   context,
                          //                   category[index].id.toString());
                          //             } else {
                          //               return Container();
                          //             }
                          //           },
                          //         ),
                          //       )
                          //     :
                          _buildSubcategories(
                              context, category[index].children!)
                        ],
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ],
    );
  }

  //List of Subcategories
  Widget _buildSubcategories(
      BuildContext context, List<CategoryData> subcategoryList) {
    if (subcategoryList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 35.0),
        child: Text("No Subcategory Found."),
      );
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: subcategoryList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return (subcategoryList[index].is_navigable.toString() == "1")
              ? GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ListOfChildren.id, arguments: {
                      "id": subcategoryList[index].id.toString(),
                      "name": subcategoryList[index].name.toString(),
                      "subcategoryData": subcategoryList[index].children,
                      "token": token,
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(25.0)),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            subcategoryList[index].name.toString(),
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15.0),
                                color: kDefaultTitleFontColor),
                          ),
                          dense: true,
                        ),
                        const Divider(
                          color: kDefaultBorderColor,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                )
              : Container();
        });
  }

  //List of Subcategories
  // Widget _buildAccessoriesSubcategories(
  //     BuildContext context, String? categoryId) {
  //   List<AccessoriesChildren>? subcategoryList =
  //       accessoriesListData!.data!.children!;
  //   if (subcategoryList.isEmpty) {
  //     return const Padding(
  //       padding: EdgeInsets.only(bottom: 35.0),
  //       child: Text("No Subcategory Found."),
  //     );
  //   }
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: subcategoryList.length,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (context, index) {
  //         return (subcategoryList[index].isNavigable.toString() == "1")
  //             ? GestureDetector(
  //                 onTap: () {
  //                   if (accessoriesListData!
  //                       .data!.children![index].children!.isNotEmpty) {
  //                     Navigator.pushNamed(context, ListOfChildren.id,
  //                         arguments: {
  //                           "name": subcategoryList[index].name.toString(),
  //                           "subcategoryData": accessoriesListData!
  //                               .data!.children![index].children,
  //                           "token": token,
  //                         });
  //                   } else {
  //                     Navigator.pushNamed(context, ListOfProduct.id,
  //                         arguments: {
  //                           "name": subcategoryList[index].name.toString(),
  //                           "productData": accessoriesListData!
  //                               .data!.children![index].products,
  //                           "token": token,
  //                         });
  //                   }
  //                 },
  //                 child: Padding(
  //                   padding: EdgeInsets.only(
  //                       left: getProportionateScreenWidth(25.0)),
  //                   child: Column(
  //                     children: [
  //                       ListTile(
  //                         title: Text(
  //                           subcategoryList[index].name.toString(),
  //                           style: TextStyle(
  //                               fontSize: getProportionateScreenWidth(15.0),
  //                               color: kDefaultTitleFontColor),
  //                         ),
  //                         dense: true,
  //                       ),
  //                       const Divider(
  //                         color: kDefaultBorderColor,
  //                         thickness: 1,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             : Container();
  //       });
  // }






}
