import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:producthunt/data/network/api_respone.dart';
import 'package:producthunt/data/network/base_api_service.dart';
import 'package:producthunt/model/comment_res_model.dart';
import 'package:producthunt/model/product_response_model.dart';
import 'package:producthunt/view/resources/url_constants.dart';

import '../dio_client.dart';

class HomePageApiService{
  Dio _dio = Dio();
  Options options = Options();

  addHeaders(){
    options.headers ={
      'Authorization':'Bearer 9bloC-ir9q6iVM4WxQ4g1msS42kJ_UR9FHeQ3_EB-Hk',
      "Accept": 'application/json',
      "Content-Type": "application/json",
      "Host": "api.producthunt.com",
    };
  }

  Future<ProductList> getAllPost(DateTime date) async{
    String dateString = '${date.year}-${date.month}-${date.day}';
    addHeaders();
    final payload = {
      'day': dateString
    };

    try{
    final res = await _dio.get(UrlConstants.topTechPostUrl,options: options, queryParameters: payload);
    if(res.statusCode == 200){
      print('success');
      print(res.data);
      final response = ProductList.fromJson(res.data);
      if((response.posts).isEmpty){
       return await getAllPost(date.subtract(Duration(days: 1)));
      }
      return response;
    }else{
      return ProductList.fromJson(res.data);
    }}catch(e){
      return Future.value(ProductList());
    }
  }

  Future<Post> fetchPostDetails({required int? post_id}) async{
    addHeaders();
    try{
    final res = await _dio.get(UrlConstants.topTechPostUrl+'/${post_id}',options: options);
    if(res.statusCode == 200){
      print(res.data.toString());
      return Post.fromJson(res.data['post']);
    }else{
      return Future.value(Post());
    }}catch(e){
      return Future.value(Post());
    }
  }

  Future<CommentsResponseModel> fetchCommentsForAPost({required int? post_id,required int? pageNo}) async{
    addHeaders();
    final payLoad ={
      'page': pageNo,
      'per_page': '5'
    };
    try{
    final res = await _dio.get(UrlConstants.topTechPostUrl+'/${post_id}/comments',options: options, queryParameters: payLoad);
    if(res.statusCode == 200){
      return CommentsResponseModel.fromJson(res.data);
    }else{
      return Future.value(CommentsResponseModel());
    }}catch(e){
      return Future.value(CommentsResponseModel());
    }
  }
}