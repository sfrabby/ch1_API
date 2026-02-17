import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Model/PostModel.dart'; // পাথ চেক করুন

class PostController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<PostModel> posts = <PostModel>[].obs;

  get postList => null;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      // URL এর শেষে /posts যোগ করা হয়েছে
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        posts.assignAll(jsonData.map((e) => PostModel.fromJson(e)).toList());
        log("Fetched ${posts.length} posts");
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void deletePost(int i) {}
}