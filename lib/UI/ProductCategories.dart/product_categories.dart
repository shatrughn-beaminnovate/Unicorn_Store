import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/category/accessories_bloc/accessories_data_fetch_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/category/category_bloc/category_api_fetch_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/category/subcategory_bloc/subcategory_api_fetch_bloc.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_children.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_list_data.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory/sub_category.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory/subcategory_list.dart';
import 'package:unicorn_store/Data/Models/Category/category.dart';
import 'package:unicorn_store/Data/Models/Category/data.dart';
import 'package:unicorn_store/UI/ProductCategories.dart/Accessories/list_of_children.dart';
import '../size_config.dart';
import '../constant.dart';
import 'Accessories/list_of_product.dart';
import 'list_of_specific_product.dart';

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
  
  //Creating object for category bloc
  final CategoryApiFetchBloc _categoryApiFetchBloc = CategoryApiFetchBloc();
  final SubcategoryApiFetchBloc _subcategoryApiFetchBloc =
      SubcategoryApiFetchBloc();

  //Creating instance of accessories bloc
  final AccessoriesDataFetchBloc _accessoriesDataFetchBloc =
      AccessoriesDataFetchBloc();

  //Load Category
  Category? cat;
  SubCategoryList? subCategory;

  //Load accessories data
  AccessoriesListData? accessoriesListData;

  @override
  void initState() {
    //add Event to load all available category
    _categoryApiFetchBloc.add(LoadCategoryApiFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
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
            MultiBlocProvider(
              providers: [
                BlocProvider<CategoryApiFetchBloc>(
                  create: (BuildContext context) => _categoryApiFetchBloc,
                ),
                BlocProvider<SubcategoryApiFetchBloc>(
                  create: (BuildContext context) => _subcategoryApiFetchBloc,
                ),
                BlocProvider<AccessoriesDataFetchBloc>(
                  create: (BuildContext context) => _accessoriesDataFetchBloc,
                ),
              ],
              child: BlocListener<CategoryApiFetchBloc, CategoryApiFetchState>(
                listener: (context, state) {
                  if (state is CategoryApiFetchLoaded) {
                    setState(() {
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
                child: BlocBuilder<CategoryApiFetchBloc, CategoryApiFetchState>(
                  builder: (context, state) {
                    if (state is CategoryApiFetchInitial) {
                      return _buildLoading();
                    } else if (state is CategoryApiFetchLoading) {
                      return _buildLoading();
                    } else if (state is CategoryApiFetchLoaded) {
                      return _buildCategory(context, state.category);
                    } else if (state is CategoryApiFetchError) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  (MediaQuery.of(context).size.height / 3)),
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
    );
  }

  //List of categories
  Widget _buildCategory(BuildContext context, Category category) {
    List<Data>? categoryList = category.data;

    return ListView.builder(
      key: Key('builder ${selected.toString()}'),
      shrinkWrap: true,
      itemCount: categoryList!.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return (categoryList[index].isNavigable.toString() == "1")
            ? Container(
                margin:
                    EdgeInsets.only(bottom: getProportionateScreenHeight(10.0)),
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
                        imageUrl: "$imageDefaultURL$imageThirdUrl${categoryList[index].image}",
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
                        if (category.data![index].name == "Accessories") {
                          _accessoriesDataFetchBloc.add(
                              LoadAccessoriesDataFetch(
                                  subCategoryId:
                                      category.data![index].id.toString()));
                        } else {
                          _subcategoryApiFetchBloc.add(LoadSubcategoryApiFetch(
                              subCategoryId:
                                  categoryList[index].id.toString()));
                        }
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
                            categoryList[index].name.toString(),
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
                      (category.data![index].name == "Accessories")
                          ? BlocListener<AccessoriesDataFetchBloc,
                              AccessoriesDataFetchState>(
                              listener: (context, state) {
                                if (state is AccessoriesDataFetchLoaded) {
                                  setState(() {
                                    accessoriesListData =
                                        state.accessoriesListData;
                                  });
                                }
                              },
                              child: BlocBuilder<AccessoriesDataFetchBloc,
                                  AccessoriesDataFetchState>(
                                builder: (context, state) {
                                  if (state is AccessoriesDataFetchLoaded) {
                                    return _buildAccessoriesSubcategories(
                                        context, categoryList[index].id.toString());
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            )
                          : BlocListener<SubcategoryApiFetchBloc,
                              SubcategoryApiFetchState>(
                              listener: (context, state) {
                                if (state is SubcategoryApiFetchLoaded) {
                                  setState(() {
                                    subCategory = state.subcategory;
                                  });
                                }
                              },
                              child: BlocBuilder<SubcategoryApiFetchBloc,
                                  SubcategoryApiFetchState>(
                                builder: (context, state) {
                                  if (state is SubcategoryApiFetchInitial) {
                                    return _buildLoading();
                                  } else if (state
                                      is SubcategoryApiFetchLoading) {
                                    return Container();
                                  } else if (state
                                      is SubcategoryApiFetchLoaded) {
                                    return _buildSubcategories(
                                        context, categoryList[index].id.toString());
                                  } else if (state
                                      is SubcategoryApiFetchError) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: Text("No Subcategory Found."),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }

  //Circular progress indicator
  Widget _buildLoading() => Center(
      child: Container(
          margin: EdgeInsets.symmetric(
              vertical: (MediaQuery.of(context).size.height / 3)),
          child: const CircularProgressIndicator()));

  //List of Subcategories
  Widget _buildSubcategories(BuildContext context, String? categoryId) {
    List<Subcategory>? subcategoryList = subCategory!.data!.children;

    if (subcategoryList!.isEmpty) {
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
          return (subcategoryList[index].isNavigable.toString() == "1")
              ? GestureDetector(
                  onTap: () {
                    if (subCategory!.data!.name == "Accessories") {
                      Navigator.pushNamed(context, ListOfChildren.id,
                          arguments: {
                            "id": categoryId,
                            "name": subcategoryList[index].name.toString()
                          });
                    } else {
                      Navigator.pushNamed(context, ListOfSpecificProduct.id,
                          arguments: {
                            "id": subcategoryList[index].id.toString(),
                            "name": subcategoryList[index].name.toString()
                          });
                    }
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
  Widget _buildAccessoriesSubcategories(
      BuildContext context, String? categoryId) {
    List<AccessoriesChildren>? subcategoryList =
        accessoriesListData!.data!.children!;
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
          return (subcategoryList[index].isNavigable.toString() == "1")
              ? GestureDetector(
                  onTap: () {
                    if (accessoriesListData!
                        .data!.children![index].children!.isNotEmpty) {
                      Navigator.pushNamed(context, ListOfChildren.id,
                          arguments: {
                            "name": subcategoryList[index].name.toString(),
                            "subcategoryData": accessoriesListData!
                                .data!.children![index].children,
                          });
                    } else {
                      Navigator.pushNamed(context, ListOfProduct.id,
                          arguments: {
                            "name": subcategoryList[index].name.toString(),
                            "productData": accessoriesListData!
                                .data!.children![index].products
                          });
                    }
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
}
