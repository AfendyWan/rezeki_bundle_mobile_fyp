import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rezeki_bundle_mobile/api/register_api.dart';
import 'package:rezeki_bundle_mobile/api/setting_api.dart';
import 'package:rezeki_bundle_mobile/api/user_api.dart';
import 'package:rezeki_bundle_mobile/components/rounded_button.dart';
import 'package:rezeki_bundle_mobile/components/text_field_container.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/city.dart';
import 'package:rezeki_bundle_mobile/model/state.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Profile/components/change_password.dart';
import 'package:rezeki_bundle_mobile/screens/Signup/components/background.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:async/async.dart';

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
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  //for gender dropdown variables
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

  var getGender;

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

  int val = -1;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailTextController =
        TextEditingController(text: widget.userdata!.email);

    final firstNameTextController =
        TextEditingController(text: widget.userdata!.first_name);

    final lastNameTextController =
        TextEditingController(text: widget.userdata!.last_name);

    final phoneNumberTextController =
        TextEditingController(text: widget.userdata!.phone_number);

    final postCodeTextController =
        TextEditingController(text: widget.userdata!.postcode.toString());

    final passwordTextController = TextEditingController();

    final confirmPasswordTextController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ProfilePic(
                token: widget.token,
                userdata: widget.userdata,
              ),
              SizedBox(height: size.height * 0.03),
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
                                  controller: firstNameTextController,
                                  onChanged: (value) {},
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Your First Name",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your first name";
                                    }
                                    return null;
                                  }),
                            ),
                            TextFieldContainer(
                              child: TextFormField(
                                  controller: lastNameTextController,
                                  onChanged: (value) {},
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Your Last Name",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your last name";
                                    }
                                    return null;
                                  }),
                            ),
                            TextFieldContainer(
                              child: TextFormField(
                                  controller: emailTextController,
                                  onChanged: (value) {},
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.email,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Your Email",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your email";
                                    }
                                    return null;
                                  }),
                            ),
                            TextFieldContainer(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.accessibility_new_rounded,
                                      color: kPrimaryColor,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8)),
                                hint: const Text(
                                  "Please select your gender",
                                ),
                                value: selectedValue,
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    getGender = value;
                                    print(getGender);
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Please select your gender";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Container(
                            //       height: 50,
                            //       width: 140,
                            //       child: ListTile(
                            //         title: Text("Male"),
                            //         leading: Radio(
                            //           value: 1,
                            //           groupValue: val,
                            //           onChanged: (value) {
                            //             setState(() {});
                            //           },
                            //           activeColor: Colors.green,
                            //         ),
                            //       ),
                            //     ),
                            //     Container(
                            //       height: 50,
                            //       width: 150,
                            //       child: ListTile(
                            //         title: Text("Female"),
                            //         leading: Radio(
                            //           value: 2,
                            //           groupValue: val,
                            //           onChanged: (value) {
                            //             setState(() {});
                            //           },
                            //           activeColor: Colors.green,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
                            // TextFieldContainer(
                            //   child: DropdownButtonFormField<Negeri>(
                            //     isExpanded: true,
                            //     decoration: InputDecoration(
                            //         icon: Icon(
                            //           Icons.flag,
                            //           color: kPrimaryColor,
                            //         ),
                            //         enabledBorder: InputBorder.none,
                            //         contentPadding: EdgeInsets.symmetric(
                            //             vertical: 4, horizontal: 8)),
                            //     hint: Text(
                            //       "Please select your state",
                            //     ),
                            //     value: _selectedStates,
                            //     items: _statesList.map((Negeri negeri) {
                            //       return DropdownMenuItem(
                            //           value: negeri,
                            //           child: Text(negeri.statesName!));
                            //     }).toList(),
                            //     onChanged: (value) async {
                            //       setState(() {
                            //         getState = value?.id;
                            //         _onChangesCityList?.clear();

                            //         if (_cityList != null) {
                            //           for (var data in _cityList!) {
                            //             if (data.statesId == value?.id) {
                            //               _onChangesCityList?.add(City(
                            //                   id: data.id,
                            //                   citiesName: data.citiesName,
                            //                   statesId: data.statesId));
                            //             }
                            //           }
                            //           _selectedCities = _onChangesCityList![0];
                            //           getCity =
                            //               _onChangesCityList![0].citiesName;
                            //         }
                            //       });
                            //     },
                            //     validator: (value) {
                            //       if (value == null) {
                            //         return "Please select your state";
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),
                            // TextFieldContainer(
                            //   child: DropdownButtonFormField<City>(
                            //     isExpanded: true,
                            //     decoration: const InputDecoration(
                            //         icon: Icon(
                            //           Icons.home_work_rounded,
                            //           color: kPrimaryColor,
                            //         ),
                            //         enabledBorder: InputBorder.none,
                            //         contentPadding: EdgeInsets.symmetric(
                            //             vertical: 4, horizontal: 8)),
                            //     hint: Text(
                            //       "Please select your city",
                            //     ),
                            //     value: _selectedCities,
                            //     items: _onChangesCityList?.map((City city) {
                            //       return DropdownMenuItem(
                            //           value: city,
                            //           child: Text(city.citiesName!));
                            //     }).toList(),
                            //     onChanged: (value) {
                            //       setState(() {
                            //         getCity = value!.citiesName;
                            //       });
                            //     },
                            //     validator: (value) {
                            //       if (value == null) {
                            //         return "Please select your city";
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),
                            // TextFieldContainer(
                            //   child: TextFormField(
                            //       controller: passwordTextController,
                            //       enableSuggestions: false,
                            //       autocorrect: false,
                            //       obscureText: _passwordVisible,
                            //       onChanged: (value) {},
                            //       cursorColor: kPrimaryColor,
                            //       decoration: InputDecoration(
                            //         icon: const Icon(
                            //           Icons.lock,
                            //           color: kPrimaryColor,
                            //         ),
                            //         suffixIcon: IconButton(
                            //           icon: const Icon(
                            //             Icons.visibility,
                            //             color: kPrimaryColor,
                            //           ),
                            //           onPressed: () {
                            //             setState(() {
                            //               _passwordVisible = !_passwordVisible;
                            //             });
                            //           },
                            //         ),
                            //         hintText: "Password",
                            //         border: InputBorder.none,
                            //       ),
                            //       validator: (value) {
                            //         if (value == null || value.isEmpty) {
                            //           return "Please enter your password";
                            //         }
                            //         return null;
                            //       }),
                            // ),
                            // TextFieldContainer(
                            //   child: TextFormField(
                            //       controller: confirmPasswordTextController,
                            //       enableSuggestions: false,
                            //       autocorrect: false,
                            //       obscureText: _passwordVisible,
                            //       onChanged: (value) {},
                            //       cursorColor: kPrimaryColor,
                            //       decoration: InputDecoration(
                            //         icon: const Icon(
                            //           Icons.lock,
                            //           color: kPrimaryColor,
                            //         ),
                            //         suffixIcon: IconButton(
                            //           icon: const Icon(
                            //             Icons.visibility,
                            //             color: kPrimaryColor,
                            //           ),
                            //           onPressed: () {
                            //             setState(() {
                            //               _passwordVisible = !_passwordVisible;
                            //             });
                            //           },
                            //         ),
                            //         hintText: "Confirm Password",
                            //         border: InputBorder.none,
                            //       ),
                            //       validator: (value) {
                            //         if (value == null || value.isEmpty) {
                            //           return "Please enter to confirm your password";
                            //         } else if (confirmPasswordTextController
                            //                 .text !=
                            //             passwordTextController.text) {
                            //           return 'Not match';
                            //         }
                            //         return null;
                            //       }),
                            // ),
                            RoundedButton(
                              text: "Save",
                              press: () async {
                                print(getCity);
                                if (_formKey.currentState != null) {
                                  if (_formKey.currentState!.validate()) {
                                    var result = await updateUserData(
                                      widget.token,
                                      context,
                                      widget.userdata!.id,
                                      firstNameTextController.text,
                                      lastNameTextController.text,
                                      emailTextController.text,
                                      getGender,
                                      phoneNumberTextController.text,
                                      postCodeTextController.text,
                                      // getState,
                                      // getCity,
                                    );
                                 
                                    if (result == "success") {
                                      widget.userdata!.first_name =
                                          firstNameTextController.text;
                                      widget.userdata!.last_name =
                                          lastNameTextController.text;
                                      widget.userdata!.email =
                                          emailTextController.text;
                                      widget.userdata!.gender = getGender;
                                      widget.userdata!.phone_number =
                                          phoneNumberTextController.text;
                                      widget.userdata!.postcode = int.parse(
                                          postCodeTextController.text);
                                      setState(() {});
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "User profile saved successfully"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
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
                                    "Change Password",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                       Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                ChangePassword(
                                                    token: widget.token,
                                                    userdata: widget.userdata,
                                                   
                                                    key: widget.key,
                                                ),
                                            )
                                          );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 251, 142, 242),
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
                      return const CircularProgressIndicator();
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
