import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rezeki_bundle_mobile/api/user_api.dart';
import 'package:rezeki_bundle_mobile/model/user.dart';

class ProfilePic extends StatefulWidget {
  final User? userdata;
  final String? token;
  const ProfilePic({Key? key, required this.userdata, required this.token})
      : super(
          key: key,
        );

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? profileUrl;
   getData() async {
    profileUrl = await getProfilePhoto(widget.token, context, widget.userdata!.id);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: getData(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none) {
              return const SizedBox();
            } else if (projectSnap.connectionState == ConnectionState.done) {
              return SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage: profileUrl == "failed"? 
                      const NetworkImage('https://picsum.photos/250?image=9'):
                      NetworkImage("http://192.168.0.157:8000"+profileUrl!)
                       
                    ),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomSheet()),
                            );
                          },
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg"),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          }
      );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    _imageFile = pickedFile;
    File file = File(_imageFile!.path);
    print("tesst");
    print(file);
    await changeProfilePhoto(
      context,
      widget.userdata!.id,
      file,
    );
    profileUrl = await getProfilePhoto(
      widget.token,
      context,
      widget.userdata!.id,
    );
    setState(() {});
  }
}
