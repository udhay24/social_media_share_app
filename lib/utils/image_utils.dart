import 'package:image_gallery/image_gallery.dart';

Future<List<String>> loadImageList() async {
  int previewSize = 10;

  var images =
      ((await FlutterGallaryPlugin.getAllImages as Map)["URIList"] as List);
  if (images.length >= previewSize) {
    List<String> latestImages =
        images.sublist(images.length - previewSize).cast<String>();
    return latestImages;
  } else {
    return images.cast<String>();
  }
}
