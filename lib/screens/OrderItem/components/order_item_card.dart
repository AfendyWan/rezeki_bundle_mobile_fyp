import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/feedback_api.dart';
import 'package:rezeki_bundle_mobile/components/rounded_button.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/components/text_field_container.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/cart_item.dart';
import 'package:rezeki_bundle_mobile/model/order.dart';
import 'package:rezeki_bundle_mobile/model/order_item.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Dashboard/dashboard.dart';

class OrderItemCard extends StatefulWidget {
  const OrderItemCard({
    Key? key,
    required this.token,
    required this.orderItem,
      required this.userdata,
      required this.order,
  }) : super(key: key);
 final User? userdata;
  final OrderItem orderItem;
  final String? token;
    final Order? order;
  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  double? totalPricePerItem;
  String? inString;
  var fileResult;
  final feedbackTitleController = TextEditingController();
  final feedbackDescriptionController = TextEditingController();
   List<PlatformFile>? listFile;
  File? getFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPricePerItem =
        widget.orderItem.quantity! * double.parse(widget.orderItem.orderPrice!);

       inString = totalPricePerItem!.toStringAsFixed(2); // '2.35'
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                  "http://192.168.0.157:8000" + widget.orderItem.imageUrl!),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             FittedBox(
          fit: BoxFit.fitWidth, 
          child: Text(  widget.orderItem.itemName.toString(),)
        ) ,
    
            Text.rich(
              TextSpan(
                text: widget.orderItem.quantity.toString() + " * ",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: "RM " + widget.orderItem.orderPrice!,
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: "Total Price: RM ",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: inString.toString(),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            widget.order!.orderStatus == "Order Delivered" || widget.orderItem.feedback_status == 0? TextButton(
              style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11)),
              primary: Colors.white,
              backgroundColor: kPrimaryColor,
              ),
              onPressed: () {
                       showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: ((context, setState) {
                                return AlertDialog(
                                    scrollable: true,
                                    title: Text('Submit Feedback '),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: <Widget>[
                                               TextFieldContainer(
                                                  child: TextFormField(                                 
                                                      controller: feedbackTitleController,
                                                      onChanged: (value) {},
                                                      cursorColor: kPrimaryColor,
                                                      decoration: const InputDecoration(
                                                        icon: Icon(
                                                          Icons.title,
                                                          color: kPrimaryColor,
                                                        ),
                                                        hintText: "Feedback Title",
                                                        border: InputBorder.none,
                                                      ),
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return "Please enter feedback title";
                                                        }
                                                        return null;
                                                      }),
                                                ),    
                                                 TextFieldContainer(
                                                  child: TextFormField(                                 
                                                      controller: feedbackDescriptionController,
                                                      onChanged: (value) {},
                                                      cursorColor: kPrimaryColor,
                                                      decoration: const InputDecoration(
                                                        icon: Icon(
                                                          Icons.description,
                                                          color: kPrimaryColor,
                                                        ),
                                                        hintText: "Feedback Description",
                                                        border: InputBorder.none,
                                                      ),
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return "Please enter feedback description";
                                                        }
                                                        return null;
                                                      }),
                                                ),                                                   
                                                TextFieldContainer(
                                                  child: TextFormField(
                                                    initialValue:
                                                        fileResult == null
                                                            ? "Upload Feedback"
                                                            : "Feedback Ready",
                                                    decoration: InputDecoration(
                                                      icon: fileResult == null
                                                          ? Icon(
                                                              Icons.file_upload,
                                                              color:
                                                                  kPrimaryColor,
                                                            )
                                                          : Icon(
                                                              Icons.done,
                                                              color:
                                                                  kPrimaryColor,
                                                            ),
                                                      hintText: "Date",
                                                      border: InputBorder.none,
                                                    ),
                                                    showCursor: true,
                                                    readOnly: true,
                                                    onTap: () async {
                                                      fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
                                                     
                                                      if (fileResult == null) {
                                                        return;
                                                      }
                                                       setState(() {
                                                        listFile = fileResult.files;
                                                       });
                                                       
                                                    
                                                  
                                                      //openFile(file);
                                                    },
                                                    validator: (value) {
                                                      if (fileResult == null) {
                                                        return "Please upload feedback files";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                RoundedButton(
                                                  text: "SUBMIT",
                                                   press: ()async {
                                                       if (_formKey.currentState!.validate()) {
                                                         var result = await addFeedback(widget.token, widget.orderItem.order_id, 
                                                          feedbackTitleController.text, feedbackDescriptionController.text,
                                                          widget.userdata!.id, widget.orderItem.sale_item_id, listFile,
                                                          );
                                                         
                                                          if (result == "success"){
                                                                 final snackBar = SnackBar(
                                                        content: const Text(
                                                            'Your feedback had been submitted successfully'),
                                                        // action: SnackBarAction(
                                                        //   label: 'Undo',
                                                        //   onPressed: () {
                                                        //     // Some code to undo the change.
                                                        //   },
                                                        // ),
                                                      );

                                                      // Find the ScaffoldMessenger in the widget tree
                                                      // and use it to show a SnackBar.
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DashboardScreen(
                                                                    token: widget
                                                                        .token,
                                                                    userdata: widget
                                                                        .userdata,
                                                                    key: widget
                                                                        .key,
                                                                  )));
                                                          }
                                                       }
                                                   }
                                                )
                                              ],
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ));
                              }),
                            );
                          },
                        );   
              },
              child:  Text(
                "Submit Feedback",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              )
            ):SizedBox()
          ],
        )
      ],
    );
  }
}
