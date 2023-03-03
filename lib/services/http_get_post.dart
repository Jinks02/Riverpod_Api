import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_api/model/post_model.dart';

class HttpGetPost {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const String _endPoint = 'posts';

  Future<List<PostModel>> getPost() async {
    List<PostModel> posts = [];

    try {
      http.Response response = await http.get(
        Uri.parse("$_baseUrl$_endPoint"),
      );
      if (response.statusCode == 200) {
        List<dynamic> postList = jsonDecode(response.body);
        for (var postListItem in postList) {
          PostModel postModel = PostModel.fromMap(
              postListItem); // converting map of json coming from response to post model object
          posts.add(postModel);
        }
      }
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
    return posts;
  }
}
