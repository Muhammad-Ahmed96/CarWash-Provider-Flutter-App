import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'assets/assets.dart';

const String apiKey = 'AIzaSyC4xQ0n-BwL_gODzdOTI6eqmzABT7XtF9Y';
List<BitmapDescriptor> markerss = [];
String? mapStyle;
List<String> stops = [
  'Old Sawmill',
  'Seveehill Dr',
  'Trep Road',
  'Old Sawmill',
  'Seveehill Dr',
];

final CameraPosition kGooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

class MapUtils {
  static getMarkerPic() async {
    // var desc = await BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration(devicePixelRatio: 5), Assets.icPin)
    //     .then((value) => icon = value);
    markerss.add(await createBitmapDescriptorFromImage(
        Assets.mark, ''));
    // markerss.add(await createBitmapDescriptorFromImage('assets/Pickup.png',''));
    // markerss.add(await createBitmapDescriptorFromImage('assets/drop.png',''));
  }

  static Future<BitmapDescriptor> createBitmapDescriptorFromImage(
      String imagee, String alphabet) async {
    ui.PictureRecorder recorder = new ui.PictureRecorder();
    Canvas c = new Canvas(recorder);

    double imageWidth = 70;
    double imageHeight = 70;

    // AssetBundle bundle = DefaultAssetBundle.of(context);
    ui.Image myImage = await load(imagee);
    /*await Util.getUiImage(bundle, "assets/images/image.png", imageWidth, imageHeight)*/

    paintImage(
        canvas: c, // c is the Canvas object in above code examples.
        image: myImage,
        rect: Rect.fromLTWH(0, 0, imageWidth, imageHeight * 1.1));

    TextPainter textPainter = new TextPainter(
        text: TextSpan(
            style: new TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.w600,
            ),
            text: alphabet),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    textPainter.layout();

    textPainter.paint(c, Offset(20, 6));

    final picture = recorder.endRecording();
    final image = await picture.toImage(110, 110);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  static Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
