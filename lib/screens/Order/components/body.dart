import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/api/order_api.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/order.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Cart/components/check_out_card.dart';

import 'order_cart.dart';
import 'package:async/async.dart';

class Body extends StatefulWidget {
  final User? userdata;
  final String? token;

  const Body(
      {Key? key,
      required this.userdata,
      required this.token,
      })
      : super(
          key: key,
        );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  var orderItem;
  List<Order> _orderItemList = [];
  getData() async {
     _orderItemList.clear();
     orderItem = await getUserOrderTransaction(widget.token, widget.userdata!.id);
    
    for (var data in orderItem) {
      //transfer states list from GET method call to a new one
      _orderItemList.add(Order(
          id: data.id,
        orderDate:  data.orderDate,
        orderStatus: data.orderStatus,
        order_number: data.order_number,
        payment: data.payment,
        paymentID: data.paymentID,
        shipmentID: data.shipmentID,
        userID: data.userID,));
    }

  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body:  Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: FutureBuilder(
          future: getData(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none) {
              print('project snapshot data is: ${projectSnap.data}');
              return const SizedBox();
            } else if (projectSnap.connectionState == ConnectionState.done) {
              if (_orderItemList.isNotEmpty) {
                return ListView.builder(
                itemCount: _orderItemList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: OrderCard(
                    token: widget.token,
                    userdata: widget.userdata,
                    order:  _orderItemList[index],)
                ),
              );
              } 
                     return Center(
              child: Text(
                "Order is Empty",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black,
                ),
              ),
            );
            } else {
              return const SizedBox();
            }
          },
        ),
        // child:
      )
      // :
      // Center(child: Text(
      //   "Cart is Empty",
      //   style: TextStyle(fontSize: 24),
      //    textAlign: TextAlign.center,
      // )),

    );
  }
}
