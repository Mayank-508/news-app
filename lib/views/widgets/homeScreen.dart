import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_news_aplication/view_model/news_view_model.dart';
import 'package:my_news_aplication/views/widgets/topHeadLines.dart';

import '../../models/all_news_model.dart';
import '../common_widgets/NewsCard.dart';
import 'HomeAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel controller = Get.put(NewsViewModel());

  @override
  void initState() {
    super.initState();
    // Initial fetch of news when the screen is loaded
    controller.updateNews();
  }

  @override
  Widget build(BuildContext context) {
    double h = Get.height;
    double w = Get.width;

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(0, 59), child: HomeAppBar()),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight:
                  h * 0.38, // Matches the horizontal news section height
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Obx(() {
                  if (controller.topNews.value.articles == null) {
                    return Center(
                      child: Transform.scale(
                        scale: 0.7,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  } else if (controller.topNews.value.articles!.isEmpty) {
                    return const Center(child: Text("No news available"));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.topNews.value.articles!.length,
                      itemBuilder: (context, index) {
                        return TopHeadlines(
                          article: controller.topNews.value.articles![index],
                        );
                      },
                    );
                  }
                }),
              ),
            ),
          ];
        },
        body: FutureBuilder<AllNewsModels>(
          future: controller.FetchingAllNews(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Transform.scale(
                  scale: 0.7,
                  child: const CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.articles!.length,
                itemBuilder: (context, index) {
                  var article = snapshot.data!.articles![index];
                  String date = DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(article.publishedAt.toString()));

                  return NewsCard(article: article, date: date);
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error: Unable to fetch news"));
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
