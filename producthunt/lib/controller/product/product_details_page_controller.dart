import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:producthunt/data/network/home_page_api_service.dart';
import 'package:producthunt/model/product_response_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProductDetailController extends GetxController {
  final Post post;
  ProductDetailController({required this.post});
  final commentsList = <Comments>[].obs;
  Post postDetails = Post();
  final apiService = Get.find<HomePageApiService>();
  final pageViewController = PageController();
  final postsLoadingDone = false.obs;
  final fetchingComment = false.obs;
  int pageNo=1;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPostDetails();
    fetchComments();
  }

  void fetchPostDetails() async {
    final response = await apiService.fetchPostDetails(post_id: post.id);
    postDetails = response;
    print('fetchPostDetails');
    print(postDetails.media?.length??0);
    print(postDetails.name??'');
    postsLoadingDone.value = true;
  }

  void fetchComments() async {
    fetchingComment.value = true;
    final response =
        await apiService.fetchCommentsForAPost(post_id: post.id, pageNo: pageNo);
    commentsList.addAll(response.comments ?? []);
    print("commentsList.length");
    print(commentsList.length);
    fetchingComment.value = false;
  }
}
