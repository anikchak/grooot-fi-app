import 'dart:convert';
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
}
