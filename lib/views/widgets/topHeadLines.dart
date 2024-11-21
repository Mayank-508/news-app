import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_news_aplication/views/DetailScreen.dart';

import '../../models/news_model.dart';

class TopHeadlines extends StatefulWidget {
  Articles article;

  TopHeadlines({super.key, required this.article});

  @override
  State<TopHeadlines> createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  @override
  Widget build(BuildContext context) {
    DateFormat formattedDate = DateFormat('yyyy-MM-dd');
    DateTime dt = DateTime.parse(widget.article.publishedAt.toString());
    String date = formattedDate.format(dt);
    final h = Get.height;
    final w = Get.width;

    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => allNewsDetailScreen()));
      },
      child: Container(
        margin: EdgeInsets.only(right: w * .02),
        padding: EdgeInsets.symmetric(
            vertical: h * .4 * .04, horizontal: w * .58 * .04),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.grey[350]),
        width: w * .58,
        height: h * .4,
        child: Stack(
          children: [
            Container(
              child: ClipRRect(
                child: Image.network(
                  widget.article.urlToImage.toString(),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                        child: Transform.scale(
                      scale: 0.7,
                      child: CircularProgressIndicator(),
                    ));
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Center(child: Text('Image not available'));
                  },
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              height: h * .4 * .5,
            ),
            Positioned(
              bottom: h * .4 * .095,
              child: Container(
                height: h * .4 * .18,
                width: w * .53,
                child: Text(
                  widget.article.title.toString(),
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: h * .4 * .004,
              left: w * .58 * .005,
              child: Text(
                widget.article.source!.name.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Positioned(
              bottom: h * .4 * .004,
              right: w * .58 * .05,
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Positioned(
              top: h * .3 * .000001,
              right: w * .58 * .001,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  size: 28,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
