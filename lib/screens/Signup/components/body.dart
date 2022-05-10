import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/components/text_field_container.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/screens/Login/login_screen.dart';
import 'package:rezeki_bundle_mobile/screens/Signup/components/background.dart';
import 'package:rezeki_bundle_mobile/screens/Signup/components/or_divider.dart';
import 'package:rezeki_bundle_mobile/screens/Signup/components/social_icon.dart';
import 'package:rezeki_bundle_mobile/components/already_have_an_account_acheck.dart';
import 'package:rezeki_bundle_mobile/components/rounded_button.dart';
import 'package:rezeki_bundle_mobile/components/rounded_input_field.dart';
import 'package:rezeki_bundle_mobile/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
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

  final _formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();

  final phoneNumberTextController = TextEditingController();
  final postCodeTextController = TextEditingController();

  final shippingAddressTextController = TextEditingController();

  final passwordTextController = TextEditingController();
  String? selectedValue;
  var items =  ['Male','Female'];
  bool _value = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),

              Form(
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
                        hint: const Text(
                          "Please select your gender",
                        ),
                        value: selectedValue,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Text(items)
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {});
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
                      child: TextFormField(
                          controller: passwordTextController,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: _passwordVisible,
                          onChanged: (value) {},
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.visibility,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            hintText: "Password",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () {},
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              // OrDivider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     SocalIcon(
              //       iconSrc: "assets/icons/facebook.svg",
              //       press: () {},
              //     ),
              //     SocalIcon(
              //       iconSrc: "assets/icons/twitter.svg",
              //       press: () {},
              //     ),
              //     SocalIcon(
              //       iconSrc: "assets/icons/google-plus.svg",
              //       press: () {},
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
