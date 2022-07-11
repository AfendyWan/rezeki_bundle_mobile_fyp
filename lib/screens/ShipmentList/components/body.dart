import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/shipping_api.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/shipment.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'shipment_card.dart';
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

  var shipment;
  List<Shipment> _shipmentList = [];
  getData() async {
    _shipmentList.clear();
    shipment = await getUserShipment(widget.token, widget.userdata!.id);

    for (var data in shipment) {
      //transfer states list from GET method call to a new one
      _shipmentList.add(Shipment(
        id: data.id,
        cart_id: data.cart_id,
        orderID: data.orderID,
        payment_id: data.payment_id,
        shippingAddress: data.shippingAddress,
        shippingCourier: data.shippingCourier,
        shippingLocalDateTime: data.shippingLocalDateTime,
        shippingOption: data.shippingOption,
        shippingStatus: data.shippingStatus,
        shippingTrackingNumber: data.shippingTrackingNumber,
        userID: data.userID,
      ));
    }
    print(_shipmentList);
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
        
              return const CircularProgressIndicator();
          } else if (projectSnap.connectionState == ConnectionState.done) {
           
            if (_shipmentList.isNotEmpty) {
              return ListView.builder(
                itemCount: _shipmentList.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ShipmentCard(
                      token: widget.token,
                      userdata: widget.userdata,
                      shipment: _shipmentList[index],
                    )),
              );
            }

            return Center(
              child: Text(
                "Shipment is Empty",
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
