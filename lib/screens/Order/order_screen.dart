import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/components/appbar.dart';
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';

import 'components/body.dart';


class OrderScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  const OrderScreen({Key? key, required this.userdata, required this.token})
      : super(
          key: key,
        );

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Cart? cartItem;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
              appBar: appbar(title: "Order History", context: context),
              body: 
              Body(
                token: widget.token,
                userdata: widget.userdata,)
           
              
            );
  }
  
}

