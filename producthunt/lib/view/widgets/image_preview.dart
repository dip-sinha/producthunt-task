import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/asset_constants.dart';

class ImagePreViewWidget extends StatelessWidget{
  final String imageUrl;

  const ImagePreViewWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: imageProvider, fit: BoxFit.cover),
      ),
    ),
      placeholder: (context, url) => Container(
        color: Colors.white,
          child: Image.asset(AssetConstants.placeHolder, fit: BoxFit.fill,)),
    errorWidget: (context, url, error) => SvgPicture.asset(
    AssetConstants.brokenLink,
    fit: BoxFit.fill,
    ),
    );
  }

}