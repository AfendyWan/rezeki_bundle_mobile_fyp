import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rezeki_bundle_mobile/api/feedback_api.dart';
import 'package:rezeki_bundle_mobile/components/appbar.dart';
import 'package:rezeki_bundle_mobile/components/coustom_bottom_nav_bar.dart';
import 'package:rezeki_bundle_mobile/components/home_header.dart';
import 'package:rezeki_bundle_mobile/components/product_card.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/enums.dart';
import 'package:rezeki_bundle_mobile/model/feedback.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';

class ViewFeedbackScreen extends StatefulWidget {
  final User? userdata;
  final String? token;
  const ViewFeedbackScreen(
      {Key? key, required this.userdata, required this.token})
      : super(
          key: key,
        );

  @override
  State<ViewFeedbackScreen> createState() => _ViewFeedbackScreenState();
}

class _ViewFeedbackScreenState extends State<ViewFeedbackScreen> {
  var feedbackItem;
  List<Feedbacks> _feedbackList = [];
  getData() async {
    _feedbackList.clear();

    feedbackItem = await getAllUserFeedback(widget.token);

    for (var data in feedbackItem) {
      //transfer states list from GET method call to a new one
      _feedbackList.add(Feedbacks(
        feedbackTitle: data.feedbackTitle,
        feedbackDescription: data.feedbackDescription,
        feedbackImages: data.feedbackImages,
        id: data.id,
        order_id: data.order_id,
        payment_id: data.payment_id,
        sale_item_id: data.sale_item_id,
        userID: data.userID,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "Feedback", context: context),
      body: FutureBuilder(
        future: getData(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none) {
            return const CircularProgressIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: _feedbackList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                          Card(
                            color: Color.fromARGB(221, 255, 212, 253),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                        
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(  _feedbackList[index].feedbackTitle!,
                                   style: Theme.of(context).textTheme.bodyText1
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(  _feedbackList[index].feedbackDescription!,
                                   style: TextStyle(
                                  fontWeight: FontWeight.w400, color: kPrimaryColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...List.generate(
                                          _feedbackList[index].feedbackImages!.length,
                                            (index1) {
                                            return Padding(
                                              padding: EdgeInsets.only(left: getProportionateScreenWidth(0), right:getProportionateScreenWidth(20), ),
                                              child: SizedBox(
                                                width: getProportionateScreenWidth(140),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AspectRatio(
                                                        aspectRatio: 1.02,
                                                        child: Container(
                                                          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                                                          decoration: BoxDecoration(
                                                            color: Color(0xff9c89ff),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          child: Hero(
                                                            tag: _feedbackList[index].feedbackImages![index].id!,
                                                            child: Image.network("http://192.168.0.157:8000"+ _feedbackList[index].feedbackImages![index1].url!)
                                                          ),
                                                        ),
                                                      ),
                                                    
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                            },
                                          ),
                                       
                                          ],
                                        ),
                                      ),
                                    ]
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.message, token: widget.token, userdata: widget.userdata),
    );
  }
}
