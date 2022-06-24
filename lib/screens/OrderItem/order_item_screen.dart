import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/order.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/OrderItem/components/body.dart';



class OrderItemsScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  final Order? order;
  const OrderItemsScreen({Key? key, required this.userdata, required this.token, required this.order})
      : super(
          key: key,
        );

  @override
  State<OrderItemsScreen> createState() => _OrderItemsScreenState();
}

class _OrderItemsScreenState extends State<OrderItemsScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
              appBar: buildAppBar(context),
              body: 
                  Body(
                      token: widget.token,
                      userdata: widget.userdata,
                    order: widget.order,
                    )
         
            );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Color.fromARGB(221, 255, 212, 253),
      elevation: 0,
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Order Items",
            style: TextStyle(color: Colors.black),
          ),

        ],
      ),
    );
  }
}
