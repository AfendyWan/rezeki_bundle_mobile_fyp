import 'package:flutter/material.dart';

import 'package:rezeki_bundle_mobile/api/order_api.dart';

import 'package:rezeki_bundle_mobile/components/size_config.dart';

import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/order.dart';
import 'package:rezeki_bundle_mobile/model/order_item.dart';

import 'package:rezeki_bundle_mobile/model/user.dart';

import 'order_item_card.dart';
import 'package:async/async.dart';

class Body extends StatefulWidget {
  final User? userdata;
  final String? token;

  final Order? order;

  const Body({
    Key? key,
    required this.userdata,
    required this.token,
    required this.order,
  }) : super(
          key: key,
        );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  var orderItem;
  var states;
  List<OrderItem> _orderitemList = [];

  var userStates;
  getData() async {
    _orderitemList.clear();

    orderItem = await viewUserOrderItems(widget.token, widget.order!.id);
  
    for (var data in orderItem) {
      //transfer states list from GET method call to a new one
      _orderitemList.add(OrderItem(
          id: data.id,
          orderPrice: data.orderPrice,
          order_id: data.order_id,
          quantity: data.quantity,
          sale_item_id: data.sale_item_id,
          itemName: data.itemName,
          imageUrl: data.imageUrl));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: FutureBuilder(
          future: getData(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none) {
              print('project snapshot data is: ${projectSnap.data}');
              return const SizedBox();
            } else if (projectSnap.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        itemCount: _orderitemList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child:
                              OrderItemCard(orderItem: _orderitemList[index], token: widget.token, userdata: widget.userdata, order: widget.order,),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        // child:
      ),
    );
  }
}
