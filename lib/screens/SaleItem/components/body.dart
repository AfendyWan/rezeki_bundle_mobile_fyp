import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/login_api.dart';
import 'package:rezeki_bundle_mobile/api/sale_item_api.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/category_sale_item.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/screens/Login/components/background.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItem/sale_item_screen.dart';
import 'package:rezeki_bundle_mobile/screens/Signup/signup_screen.dart';
import 'package:rezeki_bundle_mobile/components/already_have_an_account_acheck.dart';
import 'package:rezeki_bundle_mobile/components/rounded_button.dart';
import 'package:async/async.dart';
import 'package:flutter_svg/svg.dart';

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
      _saleItemList.add(SaleItem(
          id: data.id,
        itemName: data.itemName,
          url: data.url));
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
      body: Background(
          child: FutureBuilder(
              future: getData(),
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none) {
                  print('project snapshot data is: ${projectSnap.data}');
                  return const CircularProgressIndicator();
                } else {
                  print('project snapshot data is: ${projectSnap.data}');
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(40)),
                        const Align(
                          alignment:
                              AlignmentDirectional.center, // <-- SEE HERE
                          child: HomeHeader(),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter, // <--
                          child: GridView.count(
                            physics: const ScrollPhysics(),
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            children: List.generate(
                                _saleItemList.length, (index) {
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
                                                  SaleItemScreen(
                                                    token: widget.token,
                                                    userdata: widget.userdata,
                                                    saleItemCategoryId: _saleItemList[index].id,
                                                    key: widget.key,
                                                  )
                                            )
                                          );
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
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
