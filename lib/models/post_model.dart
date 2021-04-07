import 'package:flutter/material.dart';

class PostModel {
  int id, userId;
  String title, body;
  PostModel({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.body,
  });
  PostModel.twoArg({
    @required this.title,
    @required this.body,
  });

  PostModel.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    userId = data["userId"];
    title = data["title"];
    body = data["body"];
  }

  static Map<String, dynamic> toMap(PostModel postModel) {
    return {

      "title": postModel.title,
      "body": postModel.body,
    };
  }
}
