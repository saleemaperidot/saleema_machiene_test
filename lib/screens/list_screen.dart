import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:providerskel/data/models/construction_model.dart';
import 'package:providerskel/provider/construction_provider.dart';
import 'package:providerskel/provider/news_provider.dart';
import 'package:providerskel/screens/add_screen.dart';

class ProjectListScreen extends StatelessWidget {
  @override
  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat("dd-MM-yyyy").format(parsedDate); // Format date
    } catch (e) {
      return date; // Return original if parsing fails
    }
  }

  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        NewsProvider().getNews();
      },
    );
    return Scaffold(
      appBar: AppBar(title: Text('Construction Projects')),
      body: Column(
        children: [
          Container(
            height: 80,
            child: Consumer<NewsProvider>(
              builder: (context, value, child) {
                return CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 100, // Adjust height as needed
                      autoPlay: true, // Enables automatic sliding
                      enlargeCenterPage: true, // Highlights center item
                      viewportFraction: 0.85, // Controls item width
                      autoPlayInterval:
                          Duration(seconds: 3), // Slide every 3 seconds
                    ),
                    // scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 300,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black
                                .withOpacity(0.5), // Transparent background
                            border: Border.all(
                                color: Colors.white, width: 2), // White border
                            borderRadius:
                                BorderRadius.circular(5), // Circular shape
                          ),
                          child: Center(
                            child: Text(
                              value.news[index].description ??
                                  "updates on live",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      );
                    },
                    // separatorBuilder: (context, index) {
                    //   return SizedBox(
                    //     width: 3,
                    //   );
                    // },
                    itemCount: value.news.length);
              },
            ),
          ),
          Consumer<ProjectProvider>(
            builder: (context, projectProvider, child) {
              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: projectProvider.projects.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    ConstructionModel project = projectProvider.projects[index];
                    Color tileColor;
                    if (project.status == "Completed") {
                      tileColor = Colors.green.withOpacity(0.2);
                    } else if (project.status == "Ongoing") {
                      tileColor = Colors.pink.withOpacity(0.2);
                    } else {
                      tileColor = Colors.red.withOpacity(0.2);
                    }
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tileColor),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                project.name.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Due by:${project.endDate}",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 10),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                              ),
                              Text(
                                  "${project.location} | ${project.startDate}"),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddProjectScreen(project: project),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  Provider.of<ProjectProvider>(context,
                                          listen: false)
                                      .deleteProject(project.id!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProjectScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
