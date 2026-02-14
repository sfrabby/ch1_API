import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/PostController.dart';

class PostDeleteView extends StatelessWidget {
  PostDeleteView({super.key});

  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Posts Practice"),
        backgroundColor: Colors.redAccent,
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
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: CircleAvatar(child: Text(post.id.toString())),
                title: Text(post.title ?? "", maxLines: 1),
                // ডিলিট বাটন
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // ডিলিট কনফার্মেশন ডায়ালগ
                    Get.defaultDialog(
                      title: "Delete!",
                      middleText: "Are you sure you want to delete this post?",
                      textConfirm: "Yes",
                      textCancel: "No",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        controller.deletePost(post.id!);
                        Get.back(); // ডায়ালগ বন্ধ করা
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}