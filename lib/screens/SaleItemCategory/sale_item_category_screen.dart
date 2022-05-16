import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItemCategory/components/body.dart';


class SaleItemCategoryScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
     const SaleItemCategoryScreen({Key? key, required this.userdata, required this.token}) : super(key: key, );
  @override
  State<SaleItemCategoryScreen> createState() => _SaleItemCategoryScreenState();
}

class _SaleItemCategoryScreenState extends State<SaleItemCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(token: widget.token, userdata: widget.userdata, key: widget.key),
    );
  }
}
