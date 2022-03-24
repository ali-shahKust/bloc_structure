import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CachedImage extends StatelessWidget {

  String url;
  double width, height;

  CachedImage({Key? key, required this.url,required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
        height: height,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const SpinKitDoubleBounce(color: Colors.white,),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
