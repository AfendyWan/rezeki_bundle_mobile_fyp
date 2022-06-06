import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/sale_item_api.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/SearchSaleItem/search_sale_item_screen.dart';

class SearchField extends StatefulWidget {
    final User? userdata;
  final String? token;
  const SearchField({Key? key, required this.userdata, required this.token}) : super(key: key, );


  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) async {
         List<SaleItem> saleItemList;
         saleItemList = await searchSaleItem(widget.token, value);
                 Navigator.push(
                         
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                SearchSaleItemScreen(
                                    token: widget.token,
                                    userdata: widget.userdata,
                                    saleItem: saleItemList,
                                  )
                              )
                            );  
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
