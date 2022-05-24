import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rezeki_bundle_mobile/api/cart_api.dart';
import 'package:rezeki_bundle_mobile/components/default_button.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/components/text_field_container.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final User? userdata;
  final String? token;
  final SaleItem? saleItem;
  const Body(
      {Key? key,
      required this.userdata,
      required this.token,
      required this.saleItem})
      : super(
          key: key,
        );

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enter Item Quantity"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: TextFieldContainer(
                    child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        cursorColor: kPrimaryColor,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration:  InputDecoration(
                          icon: Icon(
                            Icons.numbers,
                            color: kPrimaryColor,
                          ),
                          hintText: widget.saleItem!.itemStock.toString(),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter quantity";
                          }
                          return null;
                        }),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(18),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    backgroundColor: kPrimaryColor,
                  ),
                  onPressed: () async {
                    if (int.parse(quantityController.text) >
                        int.parse(widget.saleItem!.itemStock.toString())) {
                      final snackBar = SnackBar(
                        content: const Text('Item quantity input is more than stock quantity'),
                        // action: SnackBarAction(
                        //   label: 'Undo',
                        //   onPressed: () {
                        //     // Some code to undo the change.
                        //   },
                        // ),
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                        await addCartItem(widget.token, widget.userdata!.id, widget.saleItem!.itemID, quantityController.text);
                         final snackBar = SnackBar(
                        content: const Text('Item had added to cart'),
                     
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                    }
                    
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(
          saleItem: widget.saleItem!,
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                saleItem: widget.saleItem,
                token: widget.token,
                userdata: widget.userdata,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    //ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {
                            createAlertDialog(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
