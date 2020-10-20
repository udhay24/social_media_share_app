import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_share/social_share.dart';

Widget getShareWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      RaisedButton(
        onPressed: () async {
          PickedFile file =
              await ImagePicker().getImage(source: ImageSource.gallery);
          SocialShare.shareInstagramStory(
                  file.path, "#ffffff", "#000000", "https://deep-link-url")
              .then((data) {
            print(data);
          });
        },
        child: Text("Share On Instagram Story"),
      ),
      RaisedButton(
        onPressed: () async {
          ImagePicker()
              .getImage(source: ImageSource.gallery)
              .then((image) async {
            SocialShare.shareInstagramStorywithBackground(
                    image.path, "#ffffff", "#000000", "https://deep-link-url",
                    backgroundImagePath: image.path)
                .then((data) {
              print(data);
            });
          });
        },
        child: Text("Share On Instagram Story with background"),
      ),
      RaisedButton(
        onPressed: () async {
          ImagePicker()
              .getImage(source: ImageSource.gallery)
              .then((image) async {
            Platform.isAndroid
                ? SocialShare.shareFacebookStory(
                        image.path, "#ffffff", "#000000", "https://google.com",
                        appId: "1962631037385169")
                    .then((data) {
                    print(data);
                  })
                : SocialShare.shareFacebookStory(
                        image.path, "#ffffff", "#000000", "https://google.com")
                    .then((data) {
                    print(data);
                  });
          });
        },
        child: Text("Share On Facebook Story"),
      ),
      RaisedButton(
        onPressed: () async {
          SocialShare.copyToClipboard(
            "This is Social Share plugin",
          ).then((data) {
            print(data);
          });
        },
        child: Text("Copy to clipboard"),
      ),
      RaisedButton(
        onPressed: () async {
          SocialShare.shareTwitter("This is Social Share twitter example",
                  hashtags: ["hello", "world", "foo", "bar"],
                  url: "https://google.com/#/hello",
                  trailingText: "\nhello")
              .then((data) {
            print(data);
          });
        },
        child: Text("Share on twitter"),
      ),
      RaisedButton(
        onPressed: () async {
          SocialShare.shareSms("This is Social Share Sms example",
                  url: "\nhttps://google.com/", trailingText: "\nhello")
              .then((data) {
            print(data);
          });
        },
        child: Text("Share on Sms"),
      ),
      RaisedButton(
        onPressed: () async {
          ImagePicker()
              .getImage(source: ImageSource.gallery)
              .then((image) async {
            SocialShare.shareOptions("Hello world").then((data) {
              print(data);
            });
          });
        },
        child: Text("Share Options"),
      ),
      RaisedButton(
        onPressed: () async {
          SocialShare.shareWhatsapp("Hello World \n https://google.com")
              .then((data) {
            print(data);
          });
        },
        child: Text("Share on Whatsapp"),
      ),
      RaisedButton(
        onPressed: () async {
          SocialShare.shareTelegram("Hello World \n https://google.com")
              .then((data) {
            print(data);
          });
        },
        child: Text("Share on Telegram"),
      ),
      RaisedButton(
        onPressed: () async {
          SocialShare.checkInstalledAppsForShare().then((data) {
            print(data.toString());
          });
        },
        child: Text("Get all Apps"),
      ),
    ],
  );
}
