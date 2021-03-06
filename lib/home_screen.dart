import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_share_app/image_preview.dart';
import 'package:social_media_share_app/utils/image_utils.dart';
import 'package:social_share/social_share.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedImage;

  void changeImage(newImage) {
    setState(() {
      selectedImage = newImage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("Social Share")),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: _titleController,
              cursorColor: Colors.purpleAccent,
              cursorRadius: Radius.circular(10),
              cursorWidth: 2,
              decoration: InputDecoration(
                  fillColor: Colors.black,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "What's the message?",
                  hintStyle: TextStyle(color: Colors.grey[600])),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10,),
            Expanded(child: buildSelectedImagePreview(selectedImage)),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: FutureBuilder(
                  future: loadImageList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapShot) {
                    if (snapShot.hasData && snapShot.data != null) {
                      return buildImagePreviewList(snapShot.data, (imageUri) {
                        changeImage(imageUri);
                      });
                    } else {
                      return Text("no images available");
                    }
                  },
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[900],
            ),
            getShareOptions(context)
          ],
        ));
  }

  Widget buildImagePreviewList(
      List<String> images, Function(String) onImageSelected) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            onTap: () async {
              final pickedFile =
                  await picker.getImage(source: ImageSource.camera);
              onImageSelected(pickedFile.path);
            },
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey[900],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                  height: 100,
                  width: 90,
                  child: Icon(
                    MaterialCommunityIcons.camera,
                    size: 36,
                    color: Colors.blue,
                  )),
            ),
          );
        } else if (index == (images.length + 1)) {
          return GestureDetector(
            onTap: () async {
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);
              onImageSelected(pickedFile.path);
            },
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey[900],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                  height: 100,
                  width: 90,
                  child: Icon(
                    MaterialCommunityIcons.image_outline,
                    size: 36,
                    color: Colors.blue,
                  )),
            ),
          );
        } else {
          var imageUri = images[index - 1];
          return GestureDetector(
              onTap: () {
                onImageSelected(imageUri);
              },
              child: getImagePreview(imageUri));
        }
      },
      itemCount: images.length + 2,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
    );
  }

  Widget buildSelectedImagePreview(String url) {
    if (url == null) {
      return Icon(
        EvilIcons.image,
        size: 70,
        color: Colors.blue,
      );
    } else {
      return Image.file(
        File(url),
        fit: BoxFit.fill,
      );
    }
  }

  Widget getShareOptions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _getShareIcon(MaterialCommunityIcons.facebook, () {
          var message = _titleController.value.text;
          if (selectedImage != null) {
            SocialShare.shareOptions(message,
                imagePath: selectedImage, package: "com.facebook.katana");
          } else {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("select an image to share")));
          }
          //       SocialShare.shareFacebookStory(
          //       selectedImage, "#ffffff", "#000000", "https://google.com",
          //       appId: "1962631037385169");
        }),
        _getShareIcon(MaterialCommunityIcons.instagram, () {
          var message = _titleController.value.text;
          if (selectedImage != null) {
            SocialShare.shareOptions(message,
                imagePath: selectedImage, package: "com.instagram.android");
          } else {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("select an image to share")));
          }
          // SocialShare.shareInstagramStory(
          //     selectedImage, "#ffffff", "#000000", "https://deep-link-url");
        }),
        _getShareIcon(MaterialCommunityIcons.twitter, () {
          var message = _titleController.value.text;
          if (selectedImage != null) {
            SocialShare.shareOptions(message,
                imagePath: selectedImage, package: "com.twitter.android");
          } else {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("select an image to share")));
          }
        }),
        _getShareIcon(MaterialCommunityIcons.whatsapp, () {
          var message = _titleController.value.text;
          if (selectedImage != null) {
            SocialShare.shareOptions(message,
                imagePath: selectedImage, package: "com.whatsapp");
          } else {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("select an image to share")));
          }
          // shareWhatsApp(message, selectedImage);
        }),
        _getShareIcon(MaterialCommunityIcons.telegram, () {
          var message = _titleController.value.text;
          if (selectedImage != null) {
            SocialShare.shareOptions(message,
                imagePath: selectedImage, package: "org.telegram.messenger");
          } else {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("select an image to share")));
          }
        }),
        _getShareIcon(MaterialCommunityIcons.share_outline, () {
          var message = _titleController.value.text;
          if (selectedImage != null) {
            SocialShare.shareOptions(message, imagePath: selectedImage);
          } else {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("select an image to share")));
          }
        }),
      ],
    );
  }

  Widget _getShareIcon(IconData icon, Function onClick) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
          onTap: onClick,
          child: Icon(
            icon,
            size: 24,
            color: Colors.blue,
          )),
    );
  }
}
