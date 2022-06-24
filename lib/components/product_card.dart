import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/category_sale_item.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItem/sale_item_screen.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItemCategory/sale_item_category_screen.dart';

import '../constants.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
        required this.token,
    required this.userdata,
    required this.rightWidth,
    required this.leftWidth,
    required this.saleItemCategory,
  }) : super(key: key);
  final double rightWidth;
  final double leftWidth;
  final double width, aspectRetio;
  final CategorySaleItem saleItemCategory;
  final String token;
  final User userdata;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(widget.leftWidth),
        right: getProportionateScreenWidth(widget.rightWidth),
      ),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SaleItemScreen(
                                saleItemCategoryId: widget.saleItemCategory.id,
                                    token: widget.token,
                                    userdata: widget.userdata,
                                    key: widget.key,
                                  )));           
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                      tag: widget.saleItemCategory.id!,
                      child: Image.network("http://192.168.0.157:8000" +
                          widget.saleItemCategory.url!)),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.saleItemCategory.name!,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.saleItemCategory.description!}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
   
                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        // color: saleItemCategory.
                        //     ? kPrimaryColor.withOpacity(0.15)
                        //     : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      // child: SvgPicture.asset(
                      //   "assets/icons/Heart Icon_2.svg",
                      //   // color: product.isFavourite
                      //   //     ? Color(0xFFFF4848)
                      //   //     : Color(0xFFDBDEE4),
                      // ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
