import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerskel/provider/news_provider.dart';

class Construction extends StatelessWidget {
  const Construction({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        //  NewsProvider().getNews();
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text("News updates"),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {},
            )
          ],
        ),
        body: SafeArea(child: Consumer<NewsProvider>(
          builder: (BuildContext context, NewsProvider value, Widget? child) {
            return value.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      print(value.news[1].description);
                      return const Card(
                        child: ListTile(
                          title: Text("name"),
                          subtitle: Text("location"),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 10);
          },
        )));
  }
}
