import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/components/coustom_bottom_nav_bar.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/enums.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';
import 'package:rezeki_bundle_mobile/screens/Dashboard/components/body.dart';

class DashboardScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  const DashboardScreen(
      {Key? key, @required this.userdata, @required this.token})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar:  HomeHeader(),
      body: Body(token: widget.token, userdata: widget.userdata,),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      // body: SingleChildScrollView(child: Column(children: [
      //   Container(
      //       height: 100,
      //               decoration: BoxDecoration(
      //                 color: Color(0xFFFFFFF9),
      //                 borderRadius: BorderRadius.only(
      //                     bottomLeft: Radius.circular(20),
      //                     bottomRight: Radius.circular(20)),
      //                 boxShadow: [
      //                   BoxShadow(color: Colors.grey[200]!, spreadRadius: 2),
      //                 ],
      //               )
      //   )
      // ]),)
    );
  }
}
