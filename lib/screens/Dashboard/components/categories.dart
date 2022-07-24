import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Feedback/view_feedback_screen.dart';
import 'package:rezeki_bundle_mobile/screens/Order/order_screen.dart';
import 'package:rezeki_bundle_mobile/screens/PromotionSaleItem/promotion_sale_item_screen.dart';
import 'package:rezeki_bundle_mobile/screens/ShipmentList/shipment_list_screen.dart';
import 'package:rezeki_bundle_mobile/screens/WishList/wish_list_screen.dart';

class Categories extends StatefulWidget {
    final User? userdata;
  final String? token;
  const Categories({ required this.userdata, required this.token});
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Order"},
      {"icon": "assets/icons/Shop Icon.svg", "text": "Ship"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Wish"},
      {"icon": "assets/icons/Discover.svg", "text": "Feeds"},
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
             
              if(categories[index]["text"] == "Wish"){
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                     builder: (context) =>
                        WishListScreen(
                          token: widget.token,
                          userdata: widget.userdata,
                          key: widget.key,
                        )
                  )
                );
              }else if(categories[index]["text"] == "Flash Deal"){
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                     builder: (context) =>
                        PromotionSaleItemScreen(
                          token: widget.token,
                          userdata: widget.userdata,
                          key: widget.key,
                        )
                  )
                );
              }else if(categories[index]["text"] == "Feeds"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewFeedbackScreen(
                            token: widget.token,
                            userdata: widget.userdata,
                            key: widget.key,
                          )
                    )
                  );
              }else if(categories[index]["text"] == "Order"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderScreen(
                            token: widget.token,
                            userdata: widget.userdata,
                            key: widget.key,
                          )
                    )
                  );
              }else if(categories[index]["text"] == "Ship"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShipmentListScreen(
                            token: widget.token,
                            userdata: widget.userdata,
                            key: widget.key,
                          )
                    )
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
