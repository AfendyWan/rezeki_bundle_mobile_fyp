import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:rezeki_bundle_mobile/api/payment_api.dart';
import 'package:rezeki_bundle_mobile/api/setting_api.dart';
import 'package:rezeki_bundle_mobile/api/shipping_api.dart';
import 'package:rezeki_bundle_mobile/components/default_button.dart';
import 'package:rezeki_bundle_mobile/components/rounded_button.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/components/text_field_container.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/settings.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:async/async.dart';
import 'package:rezeki_bundle_mobile/model/user_shipping_address.dart';
import 'package:open_file/open_file.dart';
import 'package:rezeki_bundle_mobile/screens/Dashboard/dashboard.dart';

class PlaceOrderCard extends StatefulWidget {
  final User? userdata;

  final String? token;
  final double? totalPrice;
  const PlaceOrderCard(
      {Key? key,
      required this.userdata,
      required this.token,
      required this.totalPrice})
      : super(
          key: key,
        );

  @override
  State<PlaceOrderCard> createState() => _PlaceOrderCardState();
}

class _PlaceOrderCardState extends State<PlaceOrderCard> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var fileResult;
  List<Setting> _settingList = [];

  var settings;
  UserShippingAddress? _userShippingAddress;
  Setting? _selectSetting;
  getData() async {
    _settingList.clear();

    //take state list from api GET method call
    settings = await getAdminSettings();
    _userShippingAddress =
        await getDefaultShippingAddress(widget.token, widget.userdata!.id);

    for (var data in settings) {
      if (data.key == "local delivery") {
        if (_userShippingAddress!.state == "10" &&
            _userShippingAddress!.city == "Sandakan") {
          _settingList.add(Setting(key: data.key, value: data.value));
        }
      }

      if (data.key == "Sabah courier delivery shipping fee") {
        if (_userShippingAddress!.state == "10") {
          _settingList.add(Setting(key: data.key, value: data.value));
        }
      }
      if (data.key == "Sarawak courier delivery shipping fee") {
        if (_userShippingAddress!.state == "11") {
          _settingList.add(Setting(key: data.key, value: data.value));
        }
      }
      if (data.key == "Peninsular courier delivery shipping fee") {
        if (_userShippingAddress!.state != "10") {
          if (_userShippingAddress!.state != "11") {
            _settingList.add(Setting(key: data.key, value: data.value));
          }
        }
      }
    }

    return _settingList;
  }

  File? getFile;
  DateTime? date;
  TimeOfDay? time;
  var getSettingValue;
  var getSettingKey;

  final _formKey = GlobalKey<FormState>();

  double? tempTotalPrice;

  @override
  void initState() {
    super.initState();
    tempTotalPrice = widget.totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? selectedValue;
    var items = [
      'Pos Laju',
      'GDex',
      'ABX Express',
      'J&T Express',
      'Skynet Express',
      'Citylink',
      'DHL Express',
      'FedEx',
      'Easy Parcel'
    ];
    var getShippingCourier;
    String getDate() {
      if (date == null) {
        return "Select date";
      } else {
        var months = date!.month.toString().padLeft(2, '0');
        var days = date!.day.toString().padLeft(2, '0');
        return "${date!.year}-${months}-${days}";
      }
    }

    String getTime() {
      if (time == null) {
        return "Select time";
      } else {
        var hours = time!.hour.toString().padLeft(2, '0');
        var minutes = time!.minute.toString().padLeft(2, '0');
        return "${hours}:${minutes}";
      }
    }

    _selectDate(BuildContext context) async {
      final initialDate = DateTime.now();

      final newDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: initialDate,
          lastDate: DateTime(DateTime.now().year + 1));
      if (newDate == null) {
        return;
      }

      setState(() {
        date = newDate;
      });
    }

    _selectTime(BuildContext context) async {
      final initialTime = TimeOfDay(hour: 9, minute: 00);

      final newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );
      if (newTime == null) {
        return;
      }

      setState(() {
        time = newTime;
      });
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: _memoizer.runOnce(() => getData()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const SizedBox();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: DropdownButtonFormField<Setting>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.home_work_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8)),
                              hint: Text(
                                "Please Select Delivery option",
                              ),
                              value: _selectSetting,
                              items: _settingList.map((Setting setting) {
                                return DropdownMenuItem(
                                  value: setting,
                                  child: setting.key == "local delivery"
                                      ? Text(
                                          "Local Delivery RM" + setting.value!)
                                      : Text("Courier Delivery RM" +
                                          setting.value!),
                                );
                              }).toList(),
                              onChanged: (v) {
                                setState(() {
                                  tempTotalPrice = widget.totalPrice;
                                  getSettingValue = v!.value;
                                  getSettingKey = v.key;
                                  print(getSettingKey);
                                  tempTotalPrice = (tempTotalPrice! +
                                      double.parse(getSettingValue));
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Please select your city";
                                }
                                return null;
                              },
                            ),
                          ),
                          getSettingKey.toString() == "local delivery"
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: kPrimaryLightColor,
                                    borderRadius: BorderRadius.circular(29),
                                  ),
                                  child: TextFormField(
                                    key: Key(getDate()),
                                    initialValue: getDate(),
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.calendar_month_rounded,
                                        color: kPrimaryColor,
                                      ),
                                      hintText: "Date",
                                      border: InputBorder.none,
                                    ),
                                    showCursor: true,
                                    readOnly: true,
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                  ))
                              : SizedBox(),
                          getSettingKey.toString() == "local delivery"
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: kPrimaryLightColor,
                                    borderRadius: BorderRadius.circular(29),
                                  ),
                                  child: TextFormField(
                                    key: Key(getTime()),
                                    initialValue: getTime(),
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.timer,
                                        color: kPrimaryColor,
                                      ),
                                      hintText: "Time",
                                      border: InputBorder.none,
                                    ),
                                    showCursor: true,
                                    readOnly: true,
                                    onTap: () {
                                      _selectTime(context);
                                    },
                                  ))
                              : SizedBox(),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                }),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      widget.totalPrice == ""
                          ? TextSpan(
                              text: "RM 0.00",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          : TextSpan(
                              text: "RM " + tempTotalPrice.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                      text: "Place Order",
                      press: () {
                        // print(getSettingKey);
                        // print(date);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: ((context, setState) {
                                return AlertDialog(
                                    scrollable: true,
                                    title: Text('Payment of Total: RM ' +
                                        tempTotalPrice.toString()),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: <Widget>[
                                                getSettingKey.toString() !=
                                                        "local delivery"
                                                    ? TextFieldContainer(
                                                        child:
                                                            DropdownButtonFormField<
                                                                String>(
                                                          decoration:
                                                              const InputDecoration(
                                                                  icon: Icon(
                                                                    Icons.toys,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                  enabledBorder:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          vertical:
                                                                              4,
                                                                          horizontal:
                                                                              8)),
                                                          hint: const Text(
                                                            "Shipping Courier",
                                                          ),
                                                          value: selectedValue,
                                                          items: items.map(
                                                              (String items) {
                                                            return DropdownMenuItem(
                                                                value: items,
                                                                child: Text(
                                                                    items));
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              getShippingCourier =
                                                                  value;
                                                            });
                                                          },
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return "Please select default status";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                TextFieldContainer(
                                                  child: TextFormField(
                                                    initialValue:
                                                        fileResult == null
                                                            ? "Upload Receipt"
                                                            : "Receipt Ready",
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
                                                      fileResult =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles();
                                                      setState(() {});
                                                      if (fileResult == null) {
                                                        return;
                                                      }

                                                      final file = fileResult
                                                          .files.first;
                                                      getFile = File(fileResult
                                                          .files.single.path);
                                                      //openFile(file);
                                                    },
                                                    validator: (value) {
                                                      if (fileResult == null) {
                                                        return "Please upload payment receipt";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          RoundedButton(
                                            text: "SUBMIT",
                                            press: () {
                                              if (_formKey.currentState !=
                                                  null) {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (getSettingKey ==
                                                      "local delivery") {
                                                    if (date == null ||
                                                        time == null) {
                                                      final snackBar = SnackBar(
                                                        content: const Text(
                                                            'Please input date and time'),
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
                                                    } else if (time!.hour >
                                                            17 ||
                                                        time!.hour < 9) {
                                                      final snackBar = SnackBar(
                                                        content: const Text(
                                                            'Local delivery working hours is from 0900 till 1700'),
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
                                                    } else {
                                                      submitPayment(
                                                          widget.token, widget.userdata!.id, getFile, tempTotalPrice, widget.totalPrice, getSettingValue, getSettingKey, "",  getDate(), getTime());
                                                                final snackBar = SnackBar(
                                                        content: const Text(
                                                            'Your payment receipt had been submitted'),
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
                                                                      builder: (context) => DashboardScreen(
                                                                            token: widget.token,
                                                                            userdata: widget.userdata,
                                                                            key: widget.key,
                                                                          )));
                                                     //submitPayment(token, userID, paymentReceipt, totalPrice, subTotalPrice, shippingPrice, deliveryOptionName, couriers, deliveryDateTime )
                                                    }
                                                 
                                                  } else {
                                                      submitPayment(
                                                          widget.token, widget.userdata!.id, getFile, tempTotalPrice, widget.totalPrice, getSettingValue, getSettingKey, getShippingCourier, "", "");
                                                                                final snackBar = SnackBar(
                                                        content: const Text(
                                                            'Your payment receipt had been submitted'),
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
                                                                      builder: (context) => DashboardScreen(
                                                                            token: widget.token,
                                                                            userdata: widget.userdata,
                                                                            key: widget.key,
                                                                          )));

                                                  }
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ));
                              }),
                            );
                          },
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
