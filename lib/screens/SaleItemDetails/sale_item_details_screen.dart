import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItemDetails/components/body.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItemDetails/components/custom_app_bar.dart';



class SaleItemDetailsScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  final SaleItem? saleItem;
  static String routeName = "/details";
  const SaleItemDetailsScreen({Key? key, required this.userdata, required this.token,  required this.saleItem})
      : super(
          key: key,
        );
  @override
  State<SaleItemDetailsScreen> createState() => _SaleItemDetailsScreenState();
}

class _SaleItemDetailsScreenState extends State<SaleItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: 5.0),
      ),
      body: Body(token: widget.token, saleItem: widget.saleItem, userdata: widget.userdata),
    );
  }
}

