import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/asset_constants.dart';

class Commentsinfo extends StatelessWidget{
  final String? imageUrl;
  final String? name;
  final String? info;
  final String? comment;

  Commentsinfo({required this.imageUrl,
    required this.name,
    required this.info,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl?? '',
                imageBuilder: (context, imageProvider) => Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              placeholder: (context, url) => placeHolder(),
                errorWidget: (context, url, error) => SvgPicture.asset(
                  AssetConstants.brokenLink,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            //const SizedBox(width: 3,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name ?? '', style: const TextStyle( fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                  Text(info ?? '', style: const TextStyle( fontWeight: FontWeight.w300, fontSize: 12),),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all( 8.0),
          child: Text(comment ?? '', style: const TextStyle( fontWeight: FontWeight.w400, fontSize: 12, color: Colors.black),),
        ),
      ],
    );
  }
  
  Widget placeHolder(){
    return SvgPicture.asset(AssetConstants.user);
  }

}