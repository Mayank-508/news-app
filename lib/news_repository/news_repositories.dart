import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/CategoryNews.dart';
import '../models/all_news_model.dart';
import '../models/news_model.dart';

class NewsRepositories {
  final apiKey = 'd03b1f1d7c834720805ceaf222f2609e';
  Future<NewsHeadlinesModel> fetchNews(String source) async {
    final cacheKey = 'news_$source';
    final cachedData = await getCachedNewsData(cacheKey);

    if (cachedData != null) {
      // Use cached data
      final body = jsonDecode(cachedData);
      return NewsHeadlinesModel.fromJson(body);
    } else {
      // Fetch from API if no cached data exists
      final url = Uri.parse(
          'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=$apiKey');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;
        await cacheNewsData(cacheKey, body); // Cache the response
        return NewsHeadlinesModel.fromJson(jsonDecode(body));
      } else {
        throw Exception("Error fetching news");
      }
    }
  }

  Future<AllNewsModels> fetchAllNews() async {
    final url =
        Uri.parse('https://newsapi.org/v2/everything?q=bitcoin&apiKey=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return AllNewsModels.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<CategoryNews> fetchCategoryNews(String category) async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=$category&apiKey=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoryNews.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<void> cacheNewsData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  Future<String?> getCachedNewsData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
