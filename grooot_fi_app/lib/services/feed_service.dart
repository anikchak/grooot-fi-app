import 'dart:convert';
import 'package:http/http.dart' as http;
import '../datamodels/feed_data_model.dart';

class FeedService {
  final String apiUrl =
      'https://run.mocky.io/v3/8362f7c6-6671-47e3-b7b7-54edc50cd838';

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
}
