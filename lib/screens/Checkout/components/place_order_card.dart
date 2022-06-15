import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:rezeki_bundle_mobile/api/setting_api.dart';
import 'package:rezeki_bundle_mobile/api/shipping_api.dart';
import 'package:rezeki_bundle_mobile/components/default_button.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/components/text_field_container.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/cart.dart';
import 'package:rezeki_bundle_mobile/model/settings.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:async/async.dart';
import 'package:rezeki_bundle_mobile/model/user_shipping_address.dart';
import 'package:open_file/open_file.dart';

class PlaceOrderCard extends StatefulWidget {
  final User? userdata;

  final String? token;
  final Cart? cartdata;
  const PlaceOrderCard(
      {Key? key,
      required this.userdata,
      required this.token,
      required this.cartdata})
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
        if (_userShippingAddress!.state == "10" ||
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

  DateTime? date;
  TimeOfDay? time;
  var getSettingValue;
  var getSettingKey;
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
                                  getSettingValue = v!.value;
                                  getSettingKey = v.key;
                                  print(getSettingKey);
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
                      widget.cartdata.toString() == "null"
                          ? TextSpan(
                              text: "RM 0.00",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          : TextSpan(
                              text: "RM " +
                                  widget.cartdata!.totalPrice.toString(),
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: ((context, setState) {
                               return  AlertDialog(
                                    scrollable: true,
                                    title: Text('Payment Form'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          children: <Widget>[
                                            getSettingKey.toString() == "local delivery" ? TextFieldContainer(
                                              child: DropdownButtonFormField<
                                                  String>(
                                                decoration:
                                                    const InputDecoration(
                                                        icon: Icon(
                                                          Icons.toys,
                                                          color: kPrimaryColor,
                                                        ),
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 4,
                                                                horizontal: 8)),
                                                hint: const Text(
                                                  "Shipping Courier",
                                                ),
                                                value: selectedValue,
                                                items:
                                                    items.map((String items) {
                                                  return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items));
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    getShippingCourier = value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return "Please select default status";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ):SizedBox(),
                                            TextFieldContainer(
                                              child: TextFormField(
                                                initialValue:  fileResult == null? "Upload Receipt": "Receipt Ready",
                                                decoration: InputDecoration(
                                                  icon: fileResult == null
                                                      ? Icon(
                                                          Icons.file_upload,
                                                          color: kPrimaryColor,
                                                        )
                                                      : Icon(
                                                          Icons.done,
                                                          color: kPrimaryColor,
                                                        ),
                                                  hintText: "Date",
                                                  border: InputBorder.none,
                                                ),
                                                showCursor: true,
                                                readOnly: true,
                                                onTap: () async {
                                                
                                                  fileResult = await FilePicker
                                                      .platform
                                                      .pickFiles();
                                                  setState(() {});
                                                  if (fileResult == null) {
                                                    return;
                                                  }

                                                  final file =
                                                      fileResult.files.first;
                                                  //penFile(file);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
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
