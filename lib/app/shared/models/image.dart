import 'package:flutter/foundation.dart';

class ImageModel {
  String url;
  String blurHash;

  ImageModel({@required this.url, @required this.blurHash});

  factory ImageModel.fromMap(Map map) =>
      ImageModel(url: map["urls"]["raw"], blurHash: map["blur_hash"]);

  Map<String, dynamic> toMap() => {"url": url, "blurHash": blurHash};

  String urlWithResizedImage(double w, double h, double dpr) =>
      url + "&w=$w&h=$h&dpr=$dpr";
}
