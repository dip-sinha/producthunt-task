import 'package:producthunt/model/product_response_model.dart';

class CommentsResponseModel {
  List<Comments>? comments;

  CommentsResponseModel({this.comments});

  CommentsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) { comments!.add(new Comments.fromJson(v)); });
    }
  }
}