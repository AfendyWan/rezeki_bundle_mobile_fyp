import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';


import 'categories.dart';
import 'discount_banner.dart';
import '../../../components/home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  final User? userdata;
  final String? token;
  const Body({Key? key, required this.userdata, required this.token}) : super(key: key, );

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
          
            DiscountBanner(),
            Categories(userdata: widget.userdata, token: widget.token),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(key: widget.key, userdata: widget.userdata, token: widget.token),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
