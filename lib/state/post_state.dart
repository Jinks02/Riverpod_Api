import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_api/model/post_model.dart';
import 'package:riverpod_api/services/http_get_post.dart';

final postProvider = StateNotifierProvider<PostsNotifier, PostState>(
  (ref) => PostsNotifier(),
);

@immutable
abstract class PostState {}

class InitialPostState extends PostState {}

class PostsLoadingState extends PostState {}

class PostsLoadedState extends PostState {
  final List<PostModel> posts;

  PostsLoadedState({required this.posts});
}

class ErrorPostState extends PostState {
  final String errorMessage ;

  ErrorPostState({
     this.errorMessage= "error in fetching data",
  });
}

class PostsNotifier extends StateNotifier<PostState> {
  PostsNotifier() : super(InitialPostState());

  final HttpGetPost _httpGetPost = HttpGetPost();

  void fetchPosts() async {
    try {
      state = PostsLoadingState();
      List<PostModel> posts = await _httpGetPost.getPost();
      state = PostsLoadedState(posts: posts);
    } catch (e) {
      state = ErrorPostState(errorMessage: e.toString());
    }
  }
}
