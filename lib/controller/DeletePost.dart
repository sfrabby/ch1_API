import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Model/PostModel.dart';

class PostController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<PostModel> posts = <PostModel>[].obs;

  // ডাটা লোড করার ফাংশন
  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        posts.assignAll(jsonData.map((e) => PostModel.fromJson(e)).toList());
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ডাটা ডিলিট করার ফাংশন
  Future<void> deletePost(int id) async {
    try {
      // URL এর শেষে আইডি যোগ করা হয়েছে: /posts/id
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");

      var response = await http.delete(url);

      if (response.statusCode == 200) {
        // সার্ভার থেকে ডিলিট সফল হলে আমাদের লোকাল লিস্ট থেকেও রিমুভ করে দেব
        posts.removeWhere((element) => element.id == id);

        Get.snackbar("Deleted", "Post #$id successfully deleted",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      } else {
        log("Delete failed: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e");
    }
  }
}