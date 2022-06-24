import 'package:flutter/material.dart';

import 'package:rezeki_bundle_mobile/api/sale_item_api.dart';
import 'package:rezeki_bundle_mobile/components/appbar.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';

import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/screens/Login/components/background.dart';

import 'package:async/async.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItemDetails/sale_item_details_screen.dart';


import '../../../components/text_field_container.dart';

class Body extends StatefulWidget {
  final User? userdata;
  final String? token;
  final int? saleItemCategoryId;
  const Body({Key? key, required this.userdata, required this.token,  required this.saleItemCategoryId})
      : super(
          key: key,
        );
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var saleItem;
  List<SaleItem> _saleItemList = [];
  getData() async {
    _saleItemList.clear();

    saleItem = await getSaleItemList(widget.saleItemCategoryId);

    for (var data in saleItem) {
      //transfer states list from GET method call to a new one
      if (data.itemActivationStatus == 1){
          _saleItemList.add(SaleItem(
          id: data.id,
          itemID: data.itemID,
          itemName: data.itemName,
          itemDescription: data.itemDescription,
          itemCategory: data.itemCategory,
          itemStock: data.itemStock,
          itemColor: data.itemColor,
          itemSize: data.itemSize,
          itemBrand: data.itemBrand,
          itemPrice: data.itemPrice,
          itemPromotionStatus: data.itemPromotionStatus,
          itemPromotionPrice: data.itemPromotionPrice,
          itemPromotionStartDate: data.itemPromotionStartDate,
          itemPromotionEndDate: data.itemPromotionEndDate,
          itemActivationStatus: data.itemActivationStatus,
          url: data.url));
      }    
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbar(title: "Sale Item", context: context),
      body: Background(
          child: FutureBuilder(
              future: getData(),
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none) {
                  print('project snapshot data is: ${projectSnap.data}');
                  return const CircularProgressIndicator();
                } else {
                  print('project snapshot data is: ${projectSnap.data}');
                  return GridView.builder(
                     itemCount: _saleItemList.length,
                      gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                    physics: const ScrollPhysics(),
                     itemBuilder: (context, index) => Card(
                            child: GridTile(child:     Center(
                              child:  Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: SizedBox(
                          width: getProportionateScreenWidth(140),
                          child: GestureDetector(
                            onTap: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        SaleItemDetailsScreen(
                                            token: widget.token,
                                            userdata: widget.userdata,
                                            saleItem: _saleItemList[index],
                                            key: widget.key,
                                        ),
                                    )
                                  );
                            },
                            child: Column(
                              children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10.0),
                                ),
                                margin: EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(15),
                                  ),
                                  child: Column(children: [
                                    AspectRatio(
                                      aspectRatio: 1.02,
                                      child: Hero(
                                          tag: _saleItemList[index]
                                              .id!,
                                          child: Image.network(
                                              "http://192.168.0.157:8000" +
                                                  _saleItemList[
                                                          index]
                                                      .url!)),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      _saleItemList[index].itemName!,
                                      style: TextStyle(
                                          color: Colors.black),
                                      maxLines: 2,
                                    ),
                                  ]),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                            )))
                   
             
                  );
                }
              })),
    );
  }
}
