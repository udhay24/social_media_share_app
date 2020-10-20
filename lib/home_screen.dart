import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:social_media_share_app/image_preview.dart';
import 'package:social_media_share_app/utils/image_utils.dart';

class HomeScreen extends HookWidget {
  final String _platformVersion = 'Unknown';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = useTextEditingController();
    var selectedImage = useState<String>(null);
    return Scaffold(
        appBar: AppBar(title: Text("Social Share")),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  fillColor: Colors.black,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Enter the title",
                  hintStyle: TextStyle(color: Colors.grey[600])),
              style: TextStyle(color: Colors.white),
            ),
            Expanded(child: buildSelectedImagePreview(selectedImage.value)),
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
                        selectedImage.value = imageUri;
                      });
                    } else {
                      print("no images available");
                      return Text("no images available");
                    }
                  },
                ),
              ),
            )
          ],
        ));
  }

  Widget buildImagePreviewList(
      List<String> images, Function(String) onImageSelected) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var imageUri = images[index];
        return GestureDetector(
            onTap: () {
              onImageSelected(imageUri);
            },
            child: getImagePreview(imageUri));
      },
      itemCount: images.length,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget buildSelectedImagePreview(String url) {
    if (url == null) {
      return Icon(AntDesign.camera);
    } else {
      return Image.file(File(url));
    }
  }
}
