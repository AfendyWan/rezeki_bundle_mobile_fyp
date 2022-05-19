import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/WishList/components/body.dart';



class WishListScreen extends StatefulWidget {
  final User? userdata;
  final String? token;

  
     const WishListScreen({Key? key, required this.userdata,  required this.token}) : super(key: key, );
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(token: widget.token, userdata: widget.userdata, key: widget.key),
    );
  }
}
