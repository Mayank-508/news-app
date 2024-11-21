import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_news_aplication/views/categoryScreen.dart';

import '../../view_model/news_view_model.dart';

class HomeAppBar extends StatefulWidget {
  HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  NewsViewModel controller = Get.put(NewsViewModel());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AppBar(
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoryScreen()));
            },
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 25,
              width: 30,
            )),
        title: Center(
            child: Text(
          "NewsHunt",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
        )),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              size: 36,
            ),
            onSelected: (String value) async {
              // Handle the selected option here
              controller.selectNewsSource(value);
              await controller.updateNews();
              print('Selected: $value');
              // Perform actions based on the selected item
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                  value: 'bbc-news',
                  child: Text(
                    'BBC News',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
              PopupMenuItem(
                  value: 'cnn',
                  child: Text('CNN',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              PopupMenuItem(
                  value: 'the-verge',
                  child: Text('The Verge',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              PopupMenuItem(
                  value: 'techcrunch',
                  child: Text('TechCrunch',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              PopupMenuItem(
                  value: 'bloomberg',
                  child: Text('Bloomberg',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              PopupMenuItem(
                  value: 'espn',
                  child: Text('Espn',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              PopupMenuItem(
                  value: 'fox-news',
                  child: Text('Fox-News',
                      style: TextStyle(fontWeight: FontWeight.w600))),
            ],
          ),
        ],
      ),
    );
  }
}
