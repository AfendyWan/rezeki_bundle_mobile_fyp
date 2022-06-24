import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rezeki_bundle_mobile/api/register_api.dart';
import 'package:rezeki_bundle_mobile/api/setting_api.dart';
import 'package:rezeki_bundle_mobile/api/shipping_api.dart';
import 'package:rezeki_bundle_mobile/api/user_api.dart';
import 'package:rezeki_bundle_mobile/components/rounded_button.dart';
import 'package:rezeki_bundle_mobile/components/text_field_container.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/city.dart';
import 'package:rezeki_bundle_mobile/model/state.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/model/user_shipping_address.dart';
import 'package:rezeki_bundle_mobile/screens/Checkout/checkout_screen.dart';
import 'package:rezeki_bundle_mobile/screens/Dashboard/dashboard.dart';
import 'package:rezeki_bundle_mobile/screens/Profile/components/change_password.dart';
import 'package:rezeki_bundle_mobile/screens/Signup/components/background.dart';

import 'package:async/async.dart';

class ShipmentForm extends StatefulWidget {
  final User? userdata;
  final String? token;
  final UserShippingAddress? userShippingAddress;
  final bool? isEdit;
  const ShipmentForm(
      {Key? key,
      required this.userdata,
      required this.token,
      required this.isEdit,
      this.userShippingAddress})
      : super(
          key: key,
        );
  @override
  State<ShipmentForm> createState() => _ShipmentFormState();
}

class _ShipmentFormState extends State<ShipmentForm> {
  bool _passwordVisible = true;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  String? selectedValue;

  var items = ['Male', 'Female'];

  //for states dropdown variables
  Negeri? _selectedStates;

  City? _selectedCities;

  var states;

  var cities;

  var check;

  List<Negeri> _statesList = [];

  List<City>? _cityList = [];

  List<City>? _onChangesCityList = [];

  var getStatus;

  var getState;

  var getCity;

  getData() async {
    _statesList.clear();

    //take state list from api GET method call
    states = await getAllStates();
    cities = await getAllCities();
    for (var data in states) {
      //transfer states list from GET method call to a new one
      _statesList.add(Negeri(id: data.id, statesName: data.statesName));
    }

    for (var data in cities) {
      //transfer city list from GET method call to a new one
      _cityList!.add(City(
          id: data.id, citiesName: data.citiesName, statesId: data.statesId));
    }

    if (_statesList.isNotEmpty) {
      //set defaul value in dropdown
      //_selectedStates = _statesList[0];
      _selectedCities = null;
    }

    check = true;
    return check;
  }

  var fullNameTextController = TextEditingController();
  var phoneNumberTextController = TextEditingController();
  var shippingAddressTextController = TextEditingController();
  var postCodeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit == true) {
       fullNameTextController = TextEditingController(
          text: widget.userShippingAddress!.full_name);
      phoneNumberTextController = TextEditingController(
          text: widget.userShippingAddress!.phone_number);
      shippingAddressTextController = TextEditingController(
          text: widget.userShippingAddress!.shipping_address);
      postCodeTextController = TextEditingController(
          text: widget.userShippingAddress!.postcode.toString());
    }
  }

  int val = -1;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? selectedValue;
    var items = ['Yes', 'No'];
    return Scaffold(
      appBar: buildAppBar(context, widget.isEdit!),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                  future: _memoizer.runOnce(() => getData()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                           TextFieldContainer(
                              child: TextFormField(                                 
                                  controller: fullNameTextController,
                                  onChanged: (value) {},
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Your Full Name",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your shipping address";
                                    }
                                    return null;
                                  }),
                            ),
                          TextFieldContainer(
                              child: TextFormField(
                                  controller: phoneNumberTextController,
                                  onChanged: (value) {},
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.phone,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Your Phone Number",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your phone number";
                                    }
                                    return null;
                                  }),
                            ),
                            TextFieldContainer(
                              child: TextFormField(
                                  maxLines: 6,
                                  controller: shippingAddressTextController,
                                  onChanged: (value) {},
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.local_shipping_rounded,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Your Shipping Address",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your shipping address";
                                    }
                                    return null;
                                  }),
                            ),
                            TextFieldContainer(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.workspaces,
                                      color: kPrimaryColor,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8)),
                                hint: const Text(
                                  "Shipping default status",
                                ),
                                value: selectedValue,
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    getStatus = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Please select default status";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // TextFieldContainer(
                            //   child: TextFormField(
                            //       controller: phoneNumberTextController,
                            //       onChanged: (value) {},
                            //       cursorColor: kPrimaryColor,
                            //       decoration: const InputDecoration(
                            //         icon: Icon(
                            //           Icons.phone,
                            //           color: kPrimaryColor,
                            //         ),
                            //         hintText: "Your Phone Number",
                            //         border: InputBorder.none,
                            //       ),
                            //       validator: (value) {
                            //         if (value == null || value.isEmpty) {
                            //           return "Please enter your phone number";
                            //         }
                            //         return null;
                            //       }),
                            // ),

                            TextFieldContainer(
                              child: TextFormField(
                                  controller: postCodeTextController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  onChanged: (value) {},
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.house,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Your Postcode",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your postcode";
                                    }
                                    return null;
                                  }),
                            ),
                            TextFieldContainer(
                              child: DropdownButtonFormField<Negeri>(
                                isExpanded: true,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.flag,
                                      color: kPrimaryColor,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8)),
                                hint: Text(
                                  "Please select your state",
                                ),
                                value: _selectedStates,
                                items: _statesList.map((Negeri negeri) {
                                  return DropdownMenuItem(
                                      value: negeri,
                                      child: Text(negeri.statesName!));
                                }).toList(),
                                onChanged: (value) async {
                                  setState(() {
                                    getState = value?.id;
                                    _onChangesCityList?.clear();

                                    if (_cityList != null) {
                                      for (var data in _cityList!) {
                                        if (data.statesId == value?.id) {
                                          _onChangesCityList?.add(City(
                                              id: data.id,
                                              citiesName: data.citiesName,
                                              statesId: data.statesId));
                                        }
                                      }
                                      _selectedCities = _onChangesCityList![0];
                                      getCity =
                                          _onChangesCityList![0].citiesName;
                                    }
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Please select your state";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            TextFieldContainer(
                              child: DropdownButtonFormField<City>(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.home_work_rounded,
                                      color: kPrimaryColor,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8)),
                                hint: Text(
                                  "Please select your city",
                                ),
                                value: _selectedCities,
                                items: _onChangesCityList?.map((City city) {
                                  return DropdownMenuItem(
                                      value: city,
                                      child: Text(city.citiesName!));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    getCity = value!.citiesName;
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

                            RoundedButton(
                              text: "Save",
                              press: () async {
                                print(getCity);
                                if (_formKey.currentState != null) {
                                  if (_formKey.currentState!.validate()) {
                                    print(shippingAddressTextController.text);
                                    var convertStatusToInt;
                                    if (getStatus == "Yes") {
                                      convertStatusToInt = 1;
                                    } else {
                                      convertStatusToInt = 0;
                                    }
                                    var result;
                                    if (widget.isEdit == true) {
                                      result = await updateUserShipping(
                                          widget.token,
                                          fullNameTextController.text,
                                          phoneNumberTextController.text,
                                          widget.userShippingAddress!.id,
                                          widget.userdata!.id,
                                          shippingAddressTextController.text,
                                          getState,
                                          getCity,
                                          postCodeTextController.text,
                                          convertStatusToInt);
                                    } else {
                                       result = await addUserShippingAddress(
                                          widget.token,
                                          fullNameTextController.text,
                                          phoneNumberTextController.text,
                                          widget.userdata!.id,
                                          shippingAddressTextController.text,
                                          getState,
                                          getCity,
                                          postCodeTextController.text,
                                          convertStatusToInt);
                                    }

                                    if (result == "success") {
                                      setState(() {});
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Shipment updated successfully"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DashboardScreen(
                                                                  token: widget
                                                                      .token,
                                                                  userdata: widget
                                                                      .userdata,
                                                                  key: widget
                                                                      .key,
                                                                ),
                                                              ))
                                                          .then((value) =>
                                                              setState(() {}));
                                                    },
                                                    child: const Text("OK"))
                                              ],
                                            );
                                          });
                                    }
                                  } else {}
                                }
                              },
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: size.width * 0.8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: ElevatedButton(
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 255, 88, 166),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 20),
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(child: const CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
    // return SingleChildScrollView(
    //   padding: EdgeInsets.symmetric(vertical: 20),
    //   child: Column(
    //     children: [
    //       ProfilePic(),
    //       SizedBox(height: 20),
    //       ProfileMenu(
    //         text: "My Account",
    //         icon: "assets/icons/User Icon.svg",
    //         press: () => {},
    //       ),
    //       ProfileMenu(
    //         text: "Notifications",
    //         icon: "assets/icons/Bell.svg",
    //         press: () {},
    //       ),
    //       ProfileMenu(
    //         text: "Settings",
    //         icon: "assets/icons/Settings.svg",
    //         press: () {},
    //       ),
    //       ProfileMenu(
    //         text: "Help Center",
    //         icon: "assets/icons/Question mark.svg",
    //         press: () {},
    //       ),
    //       ProfileMenu(
    //         text: "Log Out",
    //         icon: "assets/icons/Log out.svg",
    //         press: () {},
    //       ),
    //     ],
    //   ),
    // );
  }
}

AppBar buildAppBar(BuildContext context, bool isEdit) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),
    backgroundColor: Color.fromARGB(221, 255, 212, 253),
    elevation: 0,
    centerTitle: true,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        isEdit == true
            ? const Text(
                "Edit Shipping Address",
                style: TextStyle(color: Colors.black),
              )
            : const Text(
                "Add New Shipping Address",
                style: TextStyle(color: Colors.black),
              )
      ],
    ),
  );
}
