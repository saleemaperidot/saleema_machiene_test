import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:providerskel/provider/news_provider.dart';
import 'package:providerskel/screens/construction.dart';
import 'package:providerskel/screens/list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        NewsProvider().getNews();
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text("News updates"),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProjectListScreen(),
                ));
              },
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
                      return Card(
                        child: ListTile(
                          title: Text(value.news[index].description!),
                          //subtitle: Text("location"),
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
