import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/api/setting_api.dart';
import 'package:rezeki_bundle_mobile/api/shipping_api.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/state.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/model/user_shipping_address.dart';
import 'package:rezeki_bundle_mobile/screens/Checkout/components/place_order_card.dart';
import 'package:rezeki_bundle_mobile/screens/Shipment/shipment_screen.dart';

import 'cart_card.dart';
import 'package:async/async.dart';

class Body extends StatefulWidget {
  final User? userdata;
  final String? token;
  final int? isCartEmpty;
  const Body(
      {Key? key,
      required this.userdata,
      required this.token,
      required this.isCartEmpty})
      : super(
          key: key,
        );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  UserShippingAddress? _userShippingAddress;
  var cartItem;
  var states;
  List<CartItem> _cartItemList = [];
  final _statesMap = {
    "Johor": 1,
    "Kedah": 2,
    "Kelantan": 3,
    "Melaka": 4,
    "Negeri Sembilan": 5,
    "Pahang": 6,
    "Perak": 7,
    "Perlis": 8,
    "Pulau Pinang": 9,
    "Sabah": 10,
    "Sarawak": 11,
    "Selangor": 12,
    "Terengganu": 13,
  };
  var userStates;
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
    _userShippingAddress =
        await getDefaultShippingAddress(widget.token, widget.userdata!.id);
    for (final mapEntry in _statesMap.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;
      if (value.toString() == _userShippingAddress!.state.toString()) {
        userStates = key;
      
        print(userStates);
      }
      //  print(_userShippingAddress!.state);
      //  print(value);
      // print('Key: $key, Value: $value'); // Key: a, Value: 1 ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isCartEmpty == 1
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: FutureBuilder(
                future: getData(),
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.none) {
                    print('project snapshot data is: ${projectSnap.data}');
                    return const SizedBox();
                  } else if (projectSnap.connectionState ==
                      ConnectionState.done) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: (){
                                         Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShipmentScreen(
                                                  token: widget.token,
                                                  userdata: widget.userdata,
                                                  key: widget.key,
                                                )
                                          )
                                        );
                                },
                                child: ListTile(
                                  dense: false,
                                  leading: Icon(Icons.place),
                                  title: Text('Delivery Addresses:'),
                                  subtitle: Text(_userShippingAddress!
                                          .shipping_address
                                          .toString() +
                                      ", " +
                                      _userShippingAddress!.postcode.toString() +
                                      ", " +
                                      _userShippingAddress!.city.toString() +
                                      ", " +userStates),
                                  trailing: Icon(Icons.arrow_forward_ios_rounded
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFE6E6),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        SvgPicture.asset(
                                            "assets/icons/Trash.svg"),
                                      ],
                                    ),
                                  ),
                                  child: CartCard(cart: _cartItemList[index]),
                                ),
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
            )
          : Center(
              child: Text(
              "Cart is Empty",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            )),
      bottomNavigationBar: PlaceOrderCard(
        userdata: widget.userdata,
        token: widget.token,
        cartdata: cartItem,
      ),
    );
  }
}
