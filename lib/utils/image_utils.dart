import 'package:image_gallery/image_gallery.dart';

Future<List<String>> loadImageList() async {
  var images =
      ((await FlutterGallaryPlugin.getAllImages as Map)["URIList"] as List);
  List<String> latestImages = images.sublist(images.length - 5).cast<String>();
  return latestImages;
}
