import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:producthunt/data/dio_client.dart';
import 'package:producthunt/model/product_response_model.dart';

import '../../data/local/api_cache.dart';
import '../../data/local/db_provider.dart';
import '../../data/network/api_respone.dart';
import '../../data/network/home_page_api_service.dart';

class HomePageController extends GetxController {
  final bool isNetworkError;
  HomePageController({required this.isNetworkError});
  static const String tag =
      "proxy_attendance_team_list_tag";
  final apiService = Get.put(HomePageApiService());
  final daoSession = Get.find<DaoSession>();
  final posts = <Post>[].obs;
  final filteredPostsList = <Post>[].obs;
  final dateTimeData = DateTime.now().obs;
  final scrollController = ScrollController();
  final isApiCalling = false.obs;
  late ProductList productList;
  int count = 0;
  Function()? scrollListener;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     checkPositionOfScroll();
    callApiOrGetCacheData();
    //fetchTodaysPostV2(dateTime:dateTime.value);
  }


  callApiOrGetCacheData() async {
    if(isNetworkError){
      final data = await getDataFromLocal();
      posts.assignAll(data);
      filteredPostsList.assignAll(posts);
    }else{
      await fetchTodaysPost(dateTime:dateTimeData.value);
    }
  }


  Future<void> pultoRefresh() async {
    print('api calling from pull to refresh');
    await fetchTodaysPost();
  }

  void checkPositionOfScroll() {
    //Remove previous listeners
    if (scrollListener != null){
      scrollController.removeListener(scrollListener!);}
    scrollListener = () {
      if (scrollController.position.atEdge && scrollController.position.extentAfter < 500) {
        //check if the 1st API call was successful or not
        fetchTodaysPost(dateTime: dateTimeData.value.subtract(Duration(days: count)), autoScroll: true);
      }
    };
    //Add new listener of current list
    scrollController.addListener(scrollListener!);
  }

   fetchTodaysPost({DateTime? dateTime, bool? autoScroll}) async {
      DateTime date = dateTime??DateTime.now();
      print(date);
      isApiCalling.value = true;
    final response = await apiService.getAllPost(date);
      isApiCalling.value = false;
      try{
    if((response.posts).isNotEmpty && response.posts != null){
      if((autoScroll??false)){
        posts.addAll(response.posts);
        final Map<int, Post> tempMap = Map(); //done for removing duplicate data
        posts.forEach((item) {
          tempMap[item.id??0] = item;
        });
        print(tempMap);
        filteredPostsList.assignAll(tempMap.values.toList());
      }else{
        posts.assignAll(response.posts);
        final Map<int, Post> temp = Map(); //done for removing duplicate data
        posts.forEach((item) {
          temp[item.id??0] = item;
        });
      filteredPostsList.assignAll(temp.values.toList());
      }
      //productList = response;
      if(dateTime!.day == DateTime.now().day)
      _saveDataToLocalDb(response);
    }}
    catch(e){
        GetSnackBar(title:'error');
    }
    count++;
    return;
  }

  // fetchTodaysPostV2({DateTime? dateTime, bool? autoScroll}) async {
  //   DateTime date = dateTime??DateTime.now();
  //   print(date);
  //   isApiCalling.value = true;
  //   final response = await apiService.getAllPostV2(date);
  //   if(response.success){
  //     if((autoScroll??false)){
  //       posts.addAll(response.data?.posts??[]);
  //       final Map<int, Post> tempMap = Map(); //done for removing duplicate data
  //       posts.forEach((item) {
  //         tempMap[item.id??0] = item;
  //       });
  //       print(tempMap);
  //       filteredPostsList.assignAll(tempMap.values.toList());
  //     }else{
  //       posts.assignAll(response.data?.posts??[]);
  //       final Map<int, Post> temp = Map(); //done for removing duplicate data
  //       posts.forEach((item) {
  //         temp[item.id??0] = item;
  //       });
  //       filteredPostsList.assignAll(temp.values.toList());
  //     }
  //   }else{
  //     GetSnackBar(title: "error",);
  //   }
  // }

  void onSearch(String searchText){
    if (searchText.isEmpty) {
      filteredPostsList.assignAll(posts);
    } else {
      List<Post> tempList =
      posts.where((e) => e.filter(searchText)).toList();
      filteredPostsList.assignAll(tempList);
    }
    update([tag]);
  }

  Future<void> _saveDataToLocalDb(
      ProductList response,
      ) async {
   final data = await daoSession.apiCacheDao.upsert(
      ApiCache(
        key: "HomeData",
        json: response.toJson(),
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
   if(data.isGreaterThan(0)){
     print('saved data ofline');
   }
  }


  Future<List<Post>> getDataFromLocal() async {
    final cachedResponse = await daoSession.apiCacheDao.read(
      apiCacheKey: "HomeData",
      mapper: (json) => ProductList.fromString(json),
    );
    if (cachedResponse != null) {
      debugPrint("getting data");
      //onTranslationsFetched(bundle, cachedResponse);
      debugPrint(cachedResponse.posts.first.createdAt);
      return cachedResponse.posts;
    }else{
      debugPrint("empty");
      return [];
    }
  }
}