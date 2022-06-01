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
import 'package:rezeki_bundle_mobile/screens/Signup/components/background.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:async/async.dart';

class ChangePassword extends StatefulWidget {
  final User? userdata;
  final String? token;
  const ChangePassword({Key? key, required this.userdata, required this.token})
      : super(
          key: key,
        );
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _oldPasswordVisible = true;
  bool _newPasswordVisible = true;
  @override
  void initState() {
    super.initState();
    _oldPasswordVisible = true;
    _newPasswordVisible = true;
  }

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  getData() async {}

  int val = -1;
  final _formKey = GlobalKey<FormState>();
  final oldPasswordTextController = TextEditingController();
  final passwordTextController = TextEditingController();
   final confirmPasswordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldContainer(
                          child: TextFormField(
                              controller: oldPasswordTextController,
                              enableSuggestions: false,
                              autocorrect: false,
                              obscureText: _oldPasswordVisible,
                              onChanged: (value) {},
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.lock,
                                  color: kPrimaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.visibility,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _oldPasswordVisible =
                                          !_oldPasswordVisible;
                                    });
                                  },
                                ),
                                hintText: "Old Password",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your old password";
                                }
                                return null;
                              }),
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                              controller: passwordTextController,
                              enableSuggestions: false,
                              autocorrect: false,
                              obscureText: _newPasswordVisible,
                              onChanged: (value) {},
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.lock,
                                  color: kPrimaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.visibility,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _newPasswordVisible =
                                          !_newPasswordVisible;
                                    });
                                  },
                                ),
                                hintText: "New Password",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your new password";
                                }else if (value.length <= 8){
                                   return "Minimum password characters is 9";
                                }
                                return null;
                              }),
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                              controller: confirmPasswordTextController,
                              enableSuggestions: false,
                              autocorrect: false,
                              obscureText: _newPasswordVisible,
                              onChanged: (value) {},
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.lock,
                                  color: kPrimaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.visibility,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _newPasswordVisible =
                                          !_newPasswordVisible;
                                    });
                                  },
                                ),
                                hintText: "Confirm New Password",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter to confirm your new password";
                                } else if (confirmPasswordTextController.text !=
                                    passwordTextController.text) {
                                  return 'Not match';
                                }
                                return null;
                              }),
                        ),
                        RoundedButton(
                          text: "Save",
                          press: () async {
                            if (_formKey.currentState != null) {
                              if (_formKey.currentState!.validate()) {
                                var result = 
                                            await changeUserPassword(
                                  context,
                                  widget.userdata!.id,
                                  passwordTextController.text,
                      oldPasswordTextController.text,          
                                );

                                if (result == "success") {
                                  setState(() {});
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "User password saved successfully"),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("OK"))
                                          ],
                                        );
                                      });
                                }else if(result == "passwordNotMatch" ){
                                  
                              
                                  setState(() {});
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Your old password is incorrect"),
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
                                "Back",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 251, 142, 242),
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
                  ),
                )
              ],
            ),
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
