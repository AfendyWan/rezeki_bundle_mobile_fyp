import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/login_api.dart';
import 'package:rezeki_bundle_mobile/api/sale_item_api.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/category_sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/screens/Login/components/background.dart';
import 'package:rezeki_bundle_mobile/screens/Signup/signup_screen.dart';
import 'package:rezeki_bundle_mobile/components/already_have_an_account_acheck.dart';
import 'package:rezeki_bundle_mobile/components/rounded_button.dart';
import 'package:async/async.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/text_field_container.dart';

class Body extends StatefulWidget {
  final User? userdata;
  final String? token;
  const Body({Key? key, required this.userdata, required this.token})
      : super(
          key: key,
        );
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var saleItemCategory;
  List<CategorySaleItem> _saleItemCategoryList = [];
  getData() async {
    _saleItemCategoryList.clear();
  
    saleItemCategory = await getSaleItemCategory();
  

    for (var data in saleItemCategory) {
      //transfer states list from GET method call to a new one
      _saleItemCategoryList.add(CategorySaleItem(
          id: data.id,
          description: data.description,
          name: data.name,
          quantity: data.quantity,
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
                            children: List.generate(_saleItemCategoryList.length, (index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 15, right: 15 ),
                                child:  SizedBox(
                                     width: getProportionateScreenWidth(140),
                                  child: GestureDetector(
                                      onTap: () {},
                                    child: Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          child: Container(
                                            
                                            decoration: BoxDecoration(
                                          
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                AspectRatio(
                                                   aspectRatio: 1.02,
                                                  child: Hero(
                                                    tag: saleItemCategory[index].id,
                                                    child: Image.network("http://192.168.0.157:8000"+saleItemCategory[index].url!)
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  saleItemCategory[index].name!,
                                                  style: TextStyle(color: Colors.black),
                                                  maxLines: 2,
                                                ),
                                              ]
                                            ),
                                          ),
                                        ),
                                        
                                      ]
                                    ),
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
