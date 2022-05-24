import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/PromotionSaleItem/components/body.dart';


class PromotionSaleItemScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
     const PromotionSaleItemScreen({Key? key, required this.userdata, required this.token}) : super(key: key, );
  @override
  State<PromotionSaleItemScreen> createState() => _PromotionSaleItemScreenState();
}

class _PromotionSaleItemScreenState extends State<PromotionSaleItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(token: widget.token, userdata: widget.userdata, key: widget.key),
    );
  }
}
