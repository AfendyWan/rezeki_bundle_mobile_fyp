import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';




class ProductDescription extends StatefulWidget {
  final User? userdata;
  final String? token;
  final SaleItem? saleItem;
  const ProductDescription({
    Key? key,
    required this.userdata,
    required this.token,
    required this.saleItem,
    this.pressOnSeeMore,
  }) : super(key: key);

   final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            widget.saleItem!.itemName!,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          // child: Container(
          //   padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          //   width: getProportionateScreenWidth(64),
          //   decoration: BoxDecoration(
          //     color:
          //         product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(20),
          //       bottomLeft: Radius.circular(20),
          //     ),
          //   ),
          //   child: SvgPicture.asset(
          //     "assets/icons/Heart Icon_2.svg",
          //     color:
          //         product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
          //     height: getProportionateScreenWidth(16),
          //   ),
          // ),
        ),
        Padding(
          padding: EdgeInsets.only(
             top: getProportionateScreenHeight(20),
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
           widget.saleItem!.itemDescription!,
            maxLines: 3,
          ),
        ),
        widget.saleItem!.itemPromotionStatus == 0 ||  widget.saleItem!.itemPromotionStatus == null?
        Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(20),
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
           "RM" + widget.saleItem!.itemPrice!,         
            style: TextStyle(
              fontSize: 24
            ),
          ),
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(20),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
               "Promotion Now!!",         
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(1),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
               "Only @ RM" + widget.saleItem!.itemPromotionPrice!,         
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(1),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
                bottom: getProportionateScreenHeight(10),
              ),
              child: Text(
                widget.saleItem!.itemPromotionStartDate! + " - " +  widget.saleItem!.itemPromotionEndDate!,         
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                 Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(10),
            left: getProportionateScreenWidth(20),
            
          ),
          child: Text(
            "Colors: " + widget.saleItem!.itemColor!.toString(),         
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
         Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(10),
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(40),
          ),
          child: Text(
           "Sizes: " + widget.saleItem!.itemSize!.toString(),         
            style: TextStyle(
              fontSize: 20
            ),
          ),
        ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(10),
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
           "Currently only " + widget.saleItem!.itemStock!.toString() + " stocks available",         
            style: TextStyle(
              fontSize: 15
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: const [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}
