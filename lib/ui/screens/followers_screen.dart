import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FollowersScreen extends StatelessWidget {
  final dynamic data;
  final String title;
  final isRepo;
  FollowersScreen({
    this.data,
    this.title,
    this.isRepo = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: data.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/img/github.png",
                        width: 100,
                        height: 100,
                      ),
                      // CircularProgressIndicator(),
                      Text("No ${title.toLowerCase()} found"),
                    ],
                  ),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return isRepo
                        ? Card(
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/img/repo.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  Expanded(
                                    child: Text(
                                      data[index]["name"],
                                      style: TextStyle(
                                        fontSize: 30,
                                        letterSpacing: 1.5,
                                      ),
                                      overflow: TextOverflow.fade,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Card(
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                10.0,
                              )),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: data[index]["avatar_url"],
                                      placeholder: (context, url) {
                                        Image.asset(
                                          "assets/img/github.png",
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      data[index]["login"],
                                      style: TextStyle(
                                        fontSize: 30,
                                        letterSpacing: 1.5,
                                      ),
                                      overflow: TextOverflow.fade,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
        ),
      ),
    );
  }
}
