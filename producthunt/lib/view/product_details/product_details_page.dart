import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:producthunt/controller/product/product_details_page_controller.dart';
import 'package:producthunt/model/product_response_model.dart';
import 'package:producthunt/view/widgets/image_preview.dart';
import 'package:producthunt/view/widgets/youtube_player.dart';
import '../resources/palette.dart';
import 'comment_info.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product_details_page';
  late final ProductDetailController _controller;
  ProductDetailsPage() {
    _controller = Get.put(ProductDetailController(post: Get.arguments));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            _controller.post.name??'',
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.deepOrange),
          ),
        ),
        body: SafeArea(
          bottom: true,
          top: false,
          child: Obx(
            () => _controller.commentsList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _controller.postsLoadingDone.value
                          ? mediaWidget()
                          : const Center(child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )),
                      _controller.postsLoadingDone.value
                          ? _productDescription
                          : const SizedBox.shrink(),
                      _controller.postsLoadingDone.value?productTags: const SizedBox.shrink(),
                      _controller.postsLoadingDone.value?const SizedBox(height: 10): const SizedBox.shrink(),
                      _controller.postsLoadingDone.value?_divider: const SizedBox.shrink(),
                      commentList(),
                      _controller.fetchingComment.value?const Center(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )):showMoreCommentsButton
                    ],
                  )),
          ),
        ));
  }

  Widget get _productDescription => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         ('Featured '+ timeago.format(DateTime.parse(_controller.postDetails.createdAt??''))).toUpperCase(),
          style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          _controller.postDetails.description ?? '',
        ),
      ],
    ),
  );

  Widget get showMoreCommentsButton => Visibility(
        visible: (_controller.post.commentsCount ?? 0) > 5,
        child: MaterialButton(
          onPressed: () {
            _controller.pageNo++;
            if ((_controller.post.commentsCount ?? 0) > 5) {
              print((_controller.post.commentsCount ?? 0).toString());
              _controller.fetchComments();
            }
          },
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "Show more",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
      );

  Widget mediaWidget() {
    return Stack(
      children: [
        SizedBox(
          width: Get.width,
          height: Get.height * .3,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            //itemCount: (_controller.postDetails.media??[]).length,
            onPageChanged: (int page) {
              // getChangedPageAndMoveBar(page);
            },
            controller: _controller.pageViewController,
            itemBuilder: (context, index) {
              return widgetsList()[
                  index % (_controller.postDetails.media ?? []).length];
            },
          ),
        ),
        mediaInfo,
      ],
    );
  }

  Widget get mediaInfo => Positioned(
        bottom: 4,
        right: 8,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              border: Border.all(
                color: Colors.grey.withOpacity(1),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: Row(
              children: [
                const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  (_controller.postDetails.media ?? []).length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  List<Widget> widgetsList() {
    List<Widget> listOfWidgets = [];
    for (var element in (_controller.postDetails.media ?? [])) {
      if (element.mediaType == "video" && element.platform == 'youtube') {
        listOfWidgets.add(YoutubePlayerWidget(
            video_id: element.videoId ?? '',
            thumbnailUrl: element.imageUrl ?? ''));
      } else {
        listOfWidgets.add(ImagePreViewWidget(imageUrl: element.imageUrl ?? ''));
      }
    }
    return listOfWidgets;
  }

  Widget commentList() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: commentCard,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _controller.commentsList.length,
    );
  }

  Widget commentCard(BuildContext context, int index) {
    Comments comment = _controller.commentsList[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Commentsinfo(
            imageUrl: comment.user?.imageUrl?.values.toList().last ?? '',
            name: comment.user?.name ?? '',
            info: comment.user?.headline ?? '',
            comment: comment.body ?? '',
          ),
        ),
        ..._children(comment.childComments)
      ],
    );
  }

  Widget get productTags => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Wrap(
      direction: Axis.horizontal,
      children: (_controller.postDetails.topics??[]).map((i) => _buildChip(i.name??'')).toList(),
    ),
  );

  Widget _buildChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Container(
        decoration:
        BoxDecoration(

            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w700),),
        ),
      )
    );
    }

  Widget get _divider {
    return Container(
      height: 1.0,
      //margin: const EdgeInsets.symmetric(horizontal: 13.0),
      color: Colors.grey.withOpacity(0.2),
    );
  }

  List<Widget> _children(List<ChildComments> newList,
      {bool isSubList = false}) {
    final childrenWidgets = <Widget>[];
    for (var element in newList) {
      if (isSubList) {
        childrenWidgets.add(Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: _divider,
        ));
      }
      childrenWidgets.add(Container(
        margin: const EdgeInsets.only(left: 30.0, right: 15, bottom: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            isSubList
                ? _secondLevelSubComment(element)
                : _firstLevelSubComment(element),
            Visibility(
              visible: (element.childComments?.length ?? -1) > 0,
              child: Column(
                children:
                    _children(element.childComments ?? [], isSubList: true),
              ),
            ),
          ],
        ),
      ));
    }
    return childrenWidgets;
  }

  Widget _firstLevelSubComment(ChildComments comment) {
    return Container(
      width: double.maxFinite,
      //height: 44,
      decoration: BoxDecoration(
          color: Palette.colorApproved.withOpacity(.1),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              width: 1.0, color: Palette.colorCardBg.withOpacity(0.1))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Commentsinfo(
                imageUrl: comment.user?.imageUrl?.values.toList().last ?? '',
                name: comment.user?.name ?? '',
                info: comment.user?.headline ?? '',
                comment: comment.body ?? '',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _secondLevelSubComment(ChildComments comment) {
    return Container(
      width: double.maxFinite,
      //height: 44,
      decoration: BoxDecoration(
          color: Palette.colorApproved.withOpacity(.1),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              width: 1.0, color: Palette.colorApproved.withOpacity(0.1))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Commentsinfo(
              imageUrl: comment.user?.imageUrl?.values.toList().last ?? '',
              name: comment.user?.name ?? '',
              info: comment.user?.headline ?? '',
              comment: comment.body ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
