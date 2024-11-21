import 'package:get/get.dart';
import 'package:my_news_aplication/models/news_model.dart';

import '../models/CategoryNews.dart';
import '../models/all_news_model.dart';
import '../news_repository/news_repositories.dart';

RxString news = 'bbc-news'.obs;
RxString category = 'business'.obs;

class NewsViewModel extends GetxController {
  NewsRepositories nr = NewsRepositories();
  Rx<NewsHeadlinesModel> topNews = NewsHeadlinesModel().obs;
  Rx<CategoryNews> categories = CategoryNews().obs;
  AllNewsModels allNews = AllNewsModels();
  void selectNewsSource(String s) async {
    news.value = s;
    update();
  }

  void selectNewsCategory(String s) async {
    category.value = s;
    update();
  }

  Future<NewsHeadlinesModel> FetchingTopNews() async {
    final response = await nr.fetchNews(news.value);
    return response;
  }

  Future<CategoryNews> FetchingCategoryNews() async {
    final response = await nr.fetchCategoryNews(category.value);
    return response;
  }

  Future<AllNewsModels> FetchingAllNews() async {
    final response = await nr.fetchAllNews();
    return response;
  }

  Future<void> updateNews() async {
    // Call your API fetch function here using the selectedSource value
    // Example:
    topNews.value = await FetchingTopNews();
  }

  Future<void> updateCategory() async {
    // Call your API fetch function here using the selectedSource value
    // Example:
    categories.value = await FetchingCategoryNews();
  }

  Future<void> getAllNews() async {
    // Call your API fetch function here using the selectedSource value
    // Example:
    allNews = await FetchingAllNews();
  }
}
