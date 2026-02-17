import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/DataPostController.dart';
import '../Controller/PostController.dart';

class PostView extends StatelessWidget {
  PostView({super.key});

  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Posts"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(post.id.toString(), style: const TextStyle(color: Colors.white)),
                ),
                title: Text(
                  post.title ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  post.body ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  // ক্লিক করলে ডিটেইলস দেখানোর জন্য Snackbar
                  Get.snackbar("Post Details", post.body ?? "");
                },
              ),
            );
          },
        );
      }),
    );
  }
}