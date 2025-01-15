import 'dart:convert';
import 'package:grooot_fi_app/datamodels/post_comment_data_model.dart';
import 'package:http/http.dart' as http;
import '../datamodels/feed_data_model.dart';
import 'package:grooot_fi_app/routes/routes.dart';

class FeedService {
  final String apiUrl = Routes.fetchFeed;

  Future<FeedDataModel> fetchFeeds({required int offset}) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return FeedDataModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load feeds: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching feeds: $error');
    }
  }

  Future<PostCommentDataModel> fetchComments(String postId) async {
    //final String url = Routes.fetchPostComments + postId; // Replace with actual endpoint
    final String url =
        Routes.fetchPostComments; //This is dummy url. should be removed
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return PostCommentDataModel.fromJson(
            jsonData); // Parse comments from response
      } else {
        throw Exception('Failed to fetch comments: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching comments: $error');
    }
  }
}
