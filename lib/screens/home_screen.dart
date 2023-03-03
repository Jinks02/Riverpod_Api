import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api/state/post_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Consumer(builder: (context, ref, child) {
        PostState state = ref.watch(postProvider);

        if (state is InitialPostState) {
          return const Center(
            child: Text("Press button to fetch data"),
          );
        } else if (state is PostsLoadedState) {
          return _buildListView(state);
        } else if (state is ErrorPostState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postProvider.notifier).fetchPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(PostsLoadedState state) {
    return ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                state.posts[index].id.toString(),
              ),
            ),
            title: Text(state.posts[index].title),
          );
        });
  }
}
