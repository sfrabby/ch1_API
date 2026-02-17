import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Model/PostModel.dart';

class PostController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<PostModel> posts = <PostModel>[].obs;

  // ডাটা আপডেট করার ফাংশন
  Future<void> updatePost(int id, String newTitle, String newBody) async {
    try {
      isLoading.value = true;
      // URL এর শেষে আইডি যোগ করা হয়েছে: /posts/id
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");

      var response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "title": newTitle,
          "body": newBody,
          "userId": 1,
        }),
      );

      if (response.statusCode == 200) {
        // লোকাল লিস্টে ডাটা আপডেট করা
        int index = posts.indexWhere((element) => element.id == id);
        if (index != -1) {
          posts[index] = PostModel(id: id, title: newTitle, body: newBody, userId: 1);
          posts.refresh(); // RxList রিফ্রেশ করা
        }

        Get.snackbar("Success", "Post updated successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}