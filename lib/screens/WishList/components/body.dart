import 'package:flutter/material.dart';

import 'package:rezeki_bundle_mobile/api/sale_item_api.dart';
import 'package:rezeki_bundle_mobile/api/wish_list_api.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';

import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/screens/Dashboard/components/section_title.dart';
import 'package:rezeki_bundle_mobile/screens/Login/components/background.dart';

import 'package:async/async.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItemDetails/sale_item_details_screen.dart';

import '../../../components/text_field_container.dart';

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
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var isWishList;

  getItemIsWishList(itemID) async {
    print("going");
    isWishList = await getIsWishList(widget.token, widget.userdata!.id, itemID);
    return isWishList;
  }

  var saleItem;
  List<SaleItem> _saleItemList = [];
  getData() async {
    _saleItemList.clear();

    saleItem = await getUserWishList(widget.userdata!.id);

    for (var data in saleItem) {
      //transfer states list from GET method call to a new one
      if (data.itemActivationStatus == 1) {
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
      appBar: HomeHeader(token: widget.token, userdata: widget.userdata,),
      body: Background(
          child: FutureBuilder(
              future: getData(),
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none) {
                  return const CircularProgressIndicator();
                } else if (projectSnap.connectionState ==
                    ConnectionState.done) {
                  if (_saleItemList.isEmpty) {
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: SectionTitle(
                        title: "Wish list is empty",
                        press: () {},
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.bottomCenter, // <--
                            child: GridView.count(
                              physics: const ScrollPhysics(),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              children:
                                  List.generate(_saleItemList.length, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: SizedBox(
                                    width: getProportionateScreenWidth(140),
                                    child: GestureDetector(
                                      onLongPress: () async {
                                        print("yea");
                                        isWishList = await getItemIsWishList(
                                            _saleItemList[index].itemID);

                                        print(isWishList);
                                        print("yea1");
                                        print(_saleItemList[index].itemID,);
                                            

                                        var result;
                                        result = await toggleWishList(
                                            widget.token,
                                            widget.userdata!.id,
                                            _saleItemList[index].itemID,
                                            isWishList);
                                        setState(() {
                                          
                                        });
                                        print(result);
                                        print("yea2");
                                      },
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
                                            )).then((value) => setState(() {}));
                                      },
                                      child: Column(children: [
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
                                                            _saleItemList[index]
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
                                );
                              }),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Text(
                      "Wish list is empty",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              })),
    );
  }
}
