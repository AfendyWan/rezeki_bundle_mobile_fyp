import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/api/shipping_api.dart';
import 'package:rezeki_bundle_mobile/components/default_button.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/model/user_shipping_address.dart';
import 'package:rezeki_bundle_mobile/screens/Cart/components/check_out_card.dart';
import 'package:rezeki_bundle_mobile/screens/Shipment/components/shipment_form.dart';

import 'cart_card.dart';
import 'package:async/async.dart';

class Body extends StatefulWidget {
  final User? userdata;
  final String? token;

  const Body({
    Key? key,
    required this.userdata,
    required this.token,
  }) : super(
          key: key,
        );
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var userShipping;

  List<UserShippingAddress> _userShippingList = [];
  List<String> _userStateList = [];
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
  getData() async {
     _userShippingList.clear();
      _userStateList.clear();
    userShipping =
        await getALlUserShippingAddress(widget.token, widget.userdata!.id);
    for (var data in userShipping) {
      _userShippingList.add(UserShippingAddress(
          id: data.id,
          city: data.city,
          postcode: data.postcode,
          shipping_address: data.shipping_address,
          shipping_default_status: data.shipping_default_status,
          state: data.state,
          userID: data.userID));
      for (final mapEntry in _statesMap.entries) {
       
        final key = mapEntry.key;
        final value = mapEntry.value;
        if (value.toString() == data!.state.toString()) {
        
          _userStateList.add(key);
        }
      }
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none) {
                  print('project snapshot data is: ${projectSnap.data}');
                  return const SizedBox();
                } else if (projectSnap.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _userShippingList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: Key(_userShippingList[index].id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            // await deleteCartItem(
                            //     widget.token,
                            //     _userShippingList[index].cart_id,
                            //     _userShippingList[index].sale_item_id);
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
                          child: GestureDetector(
                            onTap: (){
                                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShipmentForm(
                                  token: widget.token,
                                  userdata: widget.userdata,
                                  key: widget.key,
                                  isEdit: true,
                                  userShippingAddress: _userShippingList[index],
                                )));
                            },
                            child: Card(
                              borderOnForeground: true,
                              elevation: 0,
                              color:   _userShippingList[index].shipping_default_status.toString() == "1" ? Color.fromARGB(255, 113, 255, 153):Colors.transparent,                           child: Column(
                                children: [
                                  ListTile(
                                    dense: false,
                                    leading: Icon(Icons.place),
                                    title: Text('Delivery Addresses:'),
                                    subtitle: Text(
                                        _userShippingList[index].shipping_address.toString() +
                                            ", " +
                                            _userShippingList[index].postcode.toString() +
                                            ", " +
                                            _userShippingList[index].city.toString() +
                                            ", " + _userStateList[index]),
                                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                 
                                ],
                              ),
                            ),
                          ),
                          //CartCard(cart: _cartItemList[index]),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultButton(
                      text: "Add New Shipping Address",
                      press: () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShipmentForm(
                                  token: widget.token,
                                  userdata: widget.userdata,
                                  isEdit: false,
                                  key: widget.key,
                                )));
                        
                      },
          ),
            ),
            SizedBox(height: 10,)
          ],
        ),
        // child:
      ),
    );
  }
}
