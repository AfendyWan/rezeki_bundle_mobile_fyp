import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/sale_item_api.dart';
import 'package:rezeki_bundle_mobile/components/product_card.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/category_sale_item.dart';
import 'package:async/async.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/SaleItemCategory/sale_item_category_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  final User? userdata;
  final String? token;
     const PopularProducts({Key? key, required this.userdata, required this.token}) : super(key: key, );
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var saleItemCategory;
  List<CategorySaleItem> _saleItemCategoryList = [];
  getData() async {
    _saleItemCategoryList.clear();
  
    saleItemCategory = await getFirstThreeSaleItemCategory();
  

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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Category Product",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                     builder: (context) =>
                        SaleItemCategoryScreen(
                          token: widget.token,
                          userdata: widget.userdata,
                          key: widget.key,
                        )
                  )
                );
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        FutureBuilder(
            future: getData(),
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.none) {
                print('project snapshot data is: ${projectSnap.data}');
                return CircularProgressIndicator();
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        _saleItemCategoryList.length,
                        (index) {
                          return ProductCard(
                            rightWidth: 0,
                            leftWidth: 20,
                              saleItemCategory: _saleItemCategoryList[index]); // here by default width and height is 0
                        },
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                    ],
                  ),
                );
              }
            }),
      ],
    );
  }
}
