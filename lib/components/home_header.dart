import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/login_api.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Cart/cart_screen.dart';
import 'package:rezeki_bundle_mobile/screens/Login/login_screen.dart';

import '../screens/Dashboard/components/icon_btn_with_counter.dart';
import '../screens/Dashboard/components/search_field.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  final User? userdata;
  final String? token;
  const HomeHeader({Key? key, required this.userdata, required this.token})
      : super(
          key: key,
        );

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: (EdgeInsets.fromLTRB(getProportionateScreenWidth(20), 0,
            getProportionateScreenWidth(20), 0)),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchField( token: token,
                                    userdata: userdata,),
                IconBtnWithCounter(
                    svgSrc: "assets/icons/Cart Icon.svg",
                    press: () {
                        Navigator.push(
                         
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                CartScreen(
                                    token: token,
                                    userdata: userdata,
                                  )
                              )
                            );                     
                    }),
                  Container(
             
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
                    child: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      await logout(token, userdata!.email, userdata!.password, userdata!.id);
                Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }
                    //  Navigator.pushNamed(context, HomeScreen.routeName),
                    ),
                  ),
                // IconBtnWithCounter(
                //   svgSrc: "assets/icons/Bell.svg",
                //   numOfitem: 3,
                //   press: () {},
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
