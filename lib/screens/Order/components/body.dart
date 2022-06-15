import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Cart/components/check_out_card.dart';

import 'cart_card.dart';
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
  var cartItem;
  List<CartItem> _cartItemList = [];
  getData() async {
    _cartItemList.clear();

    cartItem = await getUserCartItem(widget.token, widget.userdata!.id);

    for (var data in cartItem) {
      //transfer states list from GET method call to a new one
      _cartItemList.add(CartItem(
          id: data.id,
          cart_id: data.cart_id,
          quantity: data.quantity,
          sale_item_id: data.sale_item_id,
          image_url: data.image_url,
          itemName: data.itemName,
          itemCategory: data.itemCategory,
          itemStock: data.itemStock,
          itemPrice: data.itemPrice,
          itemPromotionPrice: data.itemPromotionPrice,
          itemPromotionStatus: data.itemPromotionStatus,
          itemActivationStatus: data.itemActivationStatus,
          itemTotalPrice: data.itemTotalPrice));
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
              return ListView.builder(
                itemCount: _cartItemList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(_cartItemList[index].id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      await deleteCartItem(
                          widget.token,
                          _cartItemList[index].cart_id,
                          _cartItemList[index].sale_item_id);
                      setState(() {});
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(cart: _cartItemList[index]),
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
