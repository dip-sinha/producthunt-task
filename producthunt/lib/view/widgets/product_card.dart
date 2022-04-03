import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:producthunt/model/product_response_model.dart';
import 'package:producthunt/view/resources/asset_constants.dart';
import 'package:producthunt/view/resources/palette.dart';

class ProductCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onClick;
  const ProductCard({required this.post, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 50,
                child: CachedNetworkImage(
                  imageUrl: post.thumbnail?.imageUrl ?? '',
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    AssetConstants.brokenLink,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.name ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      post.tagline ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        featured,
                        SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset(
                          AssetConstants.comment,
                          width: 12,
                          height: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          (post.commentsCount ?? 0).toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetConstants.triangle,
                    color: Colors.black,
                    width: 5,
                    height: 10,
                  ),
                  SizedBox(height: 6),
                  Text(
                    post.votesCount.toString(),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get featured => Visibility(
        visible: post.featured ?? false,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
          //margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              color: Palette.colorApproved.withOpacity(.20)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "Featured",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Palette.colorApproved),
              )
            ],
          ),
        ),
      );
}
