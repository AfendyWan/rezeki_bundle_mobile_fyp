import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:rezeki_bundle_mobile/components/default_button.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';

import 'package:rezeki_bundle_mobile/constants.dart';

import 'package:rezeki_bundle_mobile/model/order.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/OrderItem/order_item_screen.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.userdata,
    required this.token,
    required this.order,
  }) : super(key: key);

  final User? userdata;
  final String? token;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 184, 249),
          border:
              Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 10),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 252, 48, 255), offset: Offset(5, 5))
          ]),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.order_number.toString(),
              style: TextStyle(color: Colors.black, fontSize: 22),
              maxLines: 1,
            ),

            // Text.rich(
            //   TextSpan(
            //     text: cart.quantity.toString() + " * ",
            //     style: TextStyle(
            //         fontWeight: FontWeight.w600, color: kPrimaryColor),
            //     children: [
            //       cart.itemPromotionStatus == 1?
            //       TextSpan(
            //           text: "RM " + cart.itemPromotionPrice.toString(),
            //           style: Theme.of(context).textTheme.bodyText1):
            //         TextSpan(
            //           text: "RM " + cart.itemPrice.toString(),
            //           style: Theme.of(context).textTheme.bodyText1)
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
              child: Text.rich(
                TextSpan(
                  text: "Order Status: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: order.orderStatus,
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
              child: Text.rich(
                TextSpan(
                  text: "Total Price: RM ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: order.payment![0].totalPrice.toString(),
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
              child: Text.rich(
                TextSpan(
                  text: "Order data and time ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: order.orderDate.toString(),
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(35),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: Colors.white,
                          backgroundColor: kPrimaryColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderItemsScreen(
                                        token: token,
                                        userdata: userdata,
                                        order: order,
                                      )));
                        },
                        child: Text(
                          "View Order Item",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(35),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: Colors.white,
                          backgroundColor: kPrimaryColor,
                        ),
                        onPressed: () {
                        //  OpenFile.open(filePath)
                        },
                        child: Text(
                          "View Payment",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
