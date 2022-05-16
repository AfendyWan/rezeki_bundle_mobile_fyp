import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItem/components/body.dart';


class SaleItemScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  final int? saleItemCategoryId;
  
     const SaleItemScreen({Key? key, required this.userdata, required this.saleItemCategoryId, required this.token}) : super(key: key, );
  @override
  State<SaleItemScreen> createState() => _SaleItemScreenState();
}

class _SaleItemScreenState extends State<SaleItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(token: widget.token, userdata: widget.userdata,  saleItemCategoryId: widget.saleItemCategoryId, key: widget.key),
    );
  }
}
