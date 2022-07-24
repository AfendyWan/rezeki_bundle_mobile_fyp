import 'package:flutter/material.dart';

import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/order.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/repository/order_repository.dart';


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
  OrderRepository orderRepository = OrderRepository();
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  
  // ignore: prefer_typing_uninitialized_variables
  var orderItem;
  // ignore: prefer_final_fields
  List<Order> _orderItemList = [];
  getData() async {
     _orderItemList.clear();
     Stopwatch stopwatch = new Stopwatch()..start();
     orderItem = await orderRepository.getUserOrderTransaction(widget.token, widget.userdata!.id);
     print('getUserOrderTransaction() executed in ${stopwatch.elapsed}');
    
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
