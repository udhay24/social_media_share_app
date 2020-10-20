import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intent/action.dart' as android_action;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/typedExtra.dart' as android_typedExtra;
import 'package:social_share/social_share.dart';

Widget getShareWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
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

shareWhatsApp(String title, String image) {
  android_intent.Intent()
    ..setAction(android_action.Action.ACTION_SEND_MULTIPLE)
    ..putExtra(android_extra.Extra.EXTRA_PACKAGE_NAME, "com.whatsapp",
        type: android_typedExtra.TypedExtra.stringExtra)
    ..setType("text/plain")
    ..putExtra(android_extra.Extra.EXTRA_TITLE, title)
    ..setData(Uri(scheme: 'content',
        path: image))
    // ..putExtra(android_extra.Extra.EXTRA_STREAM, Uri.parse("file://$image").toFilePath())
    ..setType("image/*")
    // ..addFlag(1)
    ..startActivity().catchError((e) => print(e));
}
