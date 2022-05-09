import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/login_api.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/screens/Login/components/background.dart';
import 'package:rezeki_bundle_mobile/screens/Signup/signup_screen.dart';
import 'package:rezeki_bundle_mobile/components/already_have_an_account_acheck.dart';
import 'package:rezeki_bundle_mobile/components/rounded_button.dart';
import 'package:rezeki_bundle_mobile/components/rounded_input_field.dart';
import 'package:rezeki_bundle_mobile/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/text_field_container.dart';

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

  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            // TextFormField(
            //   controller: emailTextController,
            //   decoration: const InputDecoration(
            //     hintText: "Please input your username",
            //     labelText: "USERNAME"),
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return "Please enter your username";
            //       }
            //       return null;
            //     },
            //   ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
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
                )),
            RoundedButton(
              text: "LOGIN",
              press: () {
                if (_formKey.currentState != null) {
                  if (_formKey.currentState!.validate()) {
                    loginAcc(
                        context, emailTextController.text, passwordTextController.text);
                  } else {
                    
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
