import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_news_aplication/views/common_widgets/NewsCard.dart';

import '../view_model/news_view_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  NewsViewModel controller = Get.put(NewsViewModel());
  // Properly defined categories list with separate strings
  List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];
  @override
  void initState() {
    super.initState();
    // Fetch initial category news (e.g., 'general')
    controller.selectNewsCategory('business');
    controller.updateCategory();
  }

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Category Screen")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    // Debugging each category output
                    print('Category: ${categories[index]} ');

                    return InkWell(
                      onTap: () async {
                        controller.selectNewsCategory(categories[index]);
                        await controller.updateCategory();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Material(
                            elevation: 100,
                            child: Container(
                              width:
                                  120, // Adjust width to fit the text comfortably
                              height: 50,
                              color: Colors.blue,
                              child: Center(
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(() {
                if (controller.categories.value.articles == null) {
                  return Transform.scale(
                    scale: 0.8,
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.categories.value.articles!.isEmpty) {
                  return Center(child: Text("No news available"));
                } else {
                  return Expanded(
                    child: Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount:
                                controller.categories.value.articles!.length,
                            itemBuilder: (context, index) {
                              var article =
                                  controller.categories.value.articles![index];
                              DateFormat formattedDate =
                                  DateFormat('yyyy-MM-dd');
                              DateTime dt = DateTime.parse(
                                  article.publishedAt.toString());
                              String date = formattedDate.format(dt);

                              return NewsCard(article: article, date: date);
                            })),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
