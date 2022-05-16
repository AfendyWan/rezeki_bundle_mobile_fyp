import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';

import '../screens/Dashboard/components/icon_btn_with_counter.dart';
import '../screens/Dashboard/components/search_field.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      backgroundColor: Colors.transparent,
      elevation:0,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding:(
            EdgeInsets.fromLTRB(getProportionateScreenWidth(20), 0, getProportionateScreenWidth(20), 0)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(40),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchField(),
                IconBtnWithCounter(
                    svgSrc: "assets/icons/Cart Icon.svg", press: () {}),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Bell.svg",
                  numOfitem: 3,
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
