import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/SearchSaleItem/components/body.dart';

class SearchSaleItemScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  final List<SaleItem>? saleItem;
  const SearchSaleItemScreen(
      {Key? key, required this.userdata, required this.token, required this.saleItem})
      : super(
          key: key,
        );
  @override
  State<SearchSaleItemScreen> createState() => _SearchSaleItemScreenState();
}

class _SearchSaleItemScreenState extends State<SearchSaleItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Body(token: widget.token, userdata: widget.userdata, key: widget.key, saleItemList: widget.saleItem),
    );
  }
}
