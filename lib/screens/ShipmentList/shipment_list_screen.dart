import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';

import 'components/body.dart';


class ShipmentListScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  const ShipmentListScreen({Key? key, required this.userdata, required this.token})
      : super(
          key: key,
        );

  @override
  State<ShipmentListScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<ShipmentListScreen> {
  Cart? cartItem;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
              appBar: buildAppBar(context, 1),
              body: 
              Body(
                token: widget.token,
                userdata: widget.userdata,)
           
              
            );
  }

  AppBar buildAppBar(BuildContext context, int checkFutureBuilder) {
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
            "Shipment",
            style: TextStyle(color: Colors.black),
          ),
   
        ],
      ),
    );
  }
  
}
