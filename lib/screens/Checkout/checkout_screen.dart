import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Checkout/components/body.dart';


import 'components/place_order_card.dart';

class CheckoutScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  const CheckoutScreen({Key? key, required this.userdata, required this.token})
      : super(
          key: key,
        );

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Cart? cartItem;

  getData() async {
    cartItem = await getUserCart(widget.token, widget.userdata!.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return FutureBuilder(
        future: getData(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none) {
            print('project snapshot data is: ${projectSnap.data}');
            return   Scaffold(
              appBar: buildAppBar(context, 2),
             
            );
          } else if (projectSnap.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: buildAppBar(context, 1),
              body: cartItem!.cartItemQuantity.toString() != "null" ? 
              Body(
                token: widget.token,
                userdata: widget.userdata,
                isCartEmpty: 1,
                cart: cartItem,
                totalPrice: double.parse(cartItem!.totalPrice!),
              ):

               Body(
                token: widget.token,
                userdata: widget.userdata,
                isCartEmpty: 0,
                cart: cartItem,
                   totalPrice: double.parse(cartItem!.totalPrice!),
              ),
            );
          } else {
            return  Scaffold(
              appBar: buildAppBar(context, 2),
             
            );
          }
        });
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
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          checkFutureBuilder == 1 &&  cartItem!.cartItemQuantity.toString() != "null" ?
          Text(
              cartItem!.cartItemQuantity.toString() + " items",
            style: Theme.of(context).textTheme.caption,
          ):
           Text(
            "",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
  
}
