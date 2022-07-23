import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unicorn_store/UI/HomePage/Add%20Cart/add_to_cart.dart';
import 'package:unicorn_store/UI/HomePage/Search%20Button/custom_search_delegate.dart';
import 'package:unicorn_store/UI/size_config.dart';

class BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  const BuildAppBar({
    Key? key,
  }) : super(key: key);

  // ignore: annotate_overrides
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      actions: [
        const Spacer(),
        Expanded(flex: 5, child: SvgPicture.asset("assets/Unicorn-logo.svg")),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Shopping_card Icon
                Stack(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.shopping_cart_sharp,
                        size: getProportionateScreenWidth(25),
                        color: Colors.white,
                      ),
                      tooltip: 'Shopping_cart',
                      onPressed: () {
                        Navigator.pushNamed(context, AddToCartPage.id);
                      },
                    ),
                    Positioned(
                      right: 8,
                      top: 0,
                      child: Container(
                        width: getProportionateScreenWidth(18.0),
                        height: getProportionateScreenWidth(18.0),
                        decoration: const BoxDecoration(
                          color: Colors.lightGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(
                          "0",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12.0)),
                        )),
                      ),
                    )
                  ],
                ),
                SizedBox(width: getProportionateScreenWidth(5.0)),
                //SearchButton
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.search,
                    size: getProportionateScreenWidth(25),
                    color: Colors.white,
                  ),
                  tooltip: 'Search',
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
