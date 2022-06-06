import 'package:flutter/material.dart';

import 'package:rezeki_bundle_mobile/api/sale_item_api.dart';
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
  final List<SaleItem>? saleItemList;
  const Body({Key? key, required this.userdata, required this.token, required this.saleItemList, })
      : super(
          key: key,
        );
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
 

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
          child: SingleChildScrollView(
                    child: Column(
                      children: [
                     
                        Align(
                          alignment: AlignmentDirectional.bottomCenter, // <--
                          child: GridView.count(
                            physics: const ScrollPhysics(),
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            children: List.generate(
                                widget.saleItemList!.length, (index) {
                              return Padding(
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
                                                    saleItem:  widget.saleItemList![index],
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
                                                  tag: widget.saleItemList![index]
                                                      .id!,
                                                  child: Image.network(
                                                      "http://192.168.0.157:8000" +
                                                          widget.saleItemList![
                                                                  index]
                                                              .url!)),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              widget.saleItemList![index].itemName!,
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
                  )),
    );
  }
}
