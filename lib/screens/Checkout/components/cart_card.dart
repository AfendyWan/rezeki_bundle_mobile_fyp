import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';




class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartItem cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network("http://192.168.0.157:8000" + cart.image_url!),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.itemName.toString(),
              style: TextStyle(color: Colors.black, fontSize: 22),
              maxLines: 1,
            ),
           
            Text.rich(
              TextSpan(
                text: cart.quantity.toString() + " * ",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  cart.itemPromotionStatus == 1? 
                  TextSpan(
                      text: "RM " + cart.itemPromotionPrice.toString(),
                      style: Theme.of(context).textTheme.bodyText1):
                    TextSpan(
                      text: "RM " + cart.itemPrice.toString(),
                      style: Theme.of(context).textTheme.bodyText1)                
                ],
              ),
            ),
           Text.rich(
              TextSpan(
                text: "Total Price: RM ",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text:  cart.itemTotalPrice,
                      style: Theme.of(context).textTheme.bodyText1),
                
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
