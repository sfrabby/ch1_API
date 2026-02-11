import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/PostModel.dart';
import 'PostModel.dart'; // আপনার মডেলের পাথটি দিন

class PostController extends GetxController {
  // লোডিং স্ট্যাটাস ট্র্যাক করার জন্য
  RxBool isLoading = false.obs;

  // ডাটা লিস্ট স্টোর করার জন্য
  RxList<PostModel> postList = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts(); // স্ক্রিন ওপেন হওয়ার সাথে সাথে ডাটা কল হবে
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;

      // আপনার API URL এখানে দিন (যেমন JSONPlaceholder)
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // ডাটা লিস্ট হিসেবে আসছে তাই সরাসরি jsonDecode
        List<dynamic> jsonData = jsonDecode(response.body);

        // ম্যাপ করে মডেলে কনভার্ট করা
        postList.value = jsonData.map((e) => PostModel.fromJson(e)).toList();

        log("Total Posts fetched: ${postList.length}");
      } else {
        log("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}