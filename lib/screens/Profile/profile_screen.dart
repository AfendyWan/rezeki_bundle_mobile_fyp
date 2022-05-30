import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/components/coustom_bottom_nav_bar.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/enums.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Profile/components/body.dart';



class ProfileScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
     const ProfileScreen({Key? key, required this.userdata, required this.token}) : super(key: key, );
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
          const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),      
        ],
      ),
    ),
      body: Body(token: widget.token, userdata: widget.userdata),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile, token: widget.token, userdata: widget.userdata),
    );
  }
}
