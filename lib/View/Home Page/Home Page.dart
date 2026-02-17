import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/DataPostController.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});

  // কন্ট্রোলারকে মেমোরিতে ইনজেক্ট করা
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Feed", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => postController.fetchPosts(),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Obx(() {
        // ১. যখন ডাটা লোড হচ্ছে
        if (postController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        }

        // ২. যদি কোনো কারণে লিস্ট খালি থাকে
        if (postController.postList.isEmpty) {
          return const Center(
            child: Text("No posts found!"),
          );
        }

        // ৩. ডাটা চলে আসলে ListView দেখানো
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: postController.postList.length,
          itemBuilder: (context, index) {
            final post = postController.postList[index];

            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // পোস্ট আইডি এবং ইউজার আইডি ছোট করে দেখানো
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.deepPurple.shade100,
                          child: Text(post.id.toString(),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        Text("User ID: ${post.userId}",
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // পোস্টের টাইটেল
                    Text(
                      post.title ?? "No Title",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Divider(height: 20),

                    // পোস্টের বডি বা বর্ণনা
                    Text(
                      post.body ?? "No Content",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}