import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/order_item.dart';

class OrderItemCard extends StatefulWidget {
  const OrderItemCard({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  final OrderItem orderItem;

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  double? totalPricePerItem;
  String? inString;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPricePerItem =
        widget.orderItem.quantity! * double.parse(widget.orderItem.orderPrice!);

       inString = totalPricePerItem!.toStringAsFixed(2); // '2.35'
  }

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
              child: Image.network(
                  "http://192.168.0.157:8000" + widget.orderItem.imageUrl!),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.orderItem.itemName.toString(),
              style: TextStyle(color: Colors.black, fontSize: 22),
              maxLines: 1,
            ),
            Text.rich(
              TextSpan(
                text: widget.orderItem.quantity.toString() + " * ",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: "RM " + widget.orderItem.orderPrice!,
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
                      text: inString.toString(),
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
