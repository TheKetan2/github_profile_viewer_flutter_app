import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "package:cached_network_image/cached_network_image.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic _userData, _userFollowers, _userFollowing, _userRepo;
  String _userSearch = "theketan2";
  String _baseUrl = "https://api.github.com/users/";

  _fetchData() async {
    http.Response userDataResponse = await http.get(_baseUrl + _userSearch);
    http.Response followersResponse =
        await http.get(_baseUrl + _userSearch + "/followers");
    http.Response followingResponse =
        await http.get(_baseUrl + _userSearch + "/following");
    http.Response userRepoResponse =
        await http.get(_baseUrl + _userSearch + "/repos");
    setState(() {
      _userData = jsonDecode(userDataResponse.body);
      _userFollowers = jsonDecode(followersResponse.body);
      _userFollowing = jsonDecode(followingResponse.body);
      _userRepo = jsonDecode(userRepoResponse.body);
    });
    print(_userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Image.asset(
            "assets/img/github.png",
            width: 20,
            height: 20,
          ),
          title: TextField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Search users",
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  print(_userSearch);
                  _fetchData();
                },
              ),
            ),
            onChanged: (String value) {
              setState(() {
                _userSearch = value;
              });
            },
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _userData == null
                ? [
                    Center(
                      child: Image.asset(
                        "assets/img/github.png",
                        width: 100,
                        height: 100,
                      ),
                    )
                  ]
                : [
                    Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black87,
                                  Colors.black,
                                ],
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  _userData == null
                                      ? "No User found"
                                      : _userData["login"],
                                ),
                                CachedNetworkImage(
                                  width: 100,
                                  height: 100,
                                  imageUrl: _userData["avatar_url"],
                                  placeholder: (context, url) {
                                    return Image.asset("assets/img/github.png");
                                  },
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blue,
                                Colors.lightBlueAccent,
                                Colors.blueAccent,
                              ]),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Image.asset("assets/img/following.png"),
                                  _userData == null || _userData["login"]
                                      ? Text("")
                                      : Text("")
                                ]),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ]));
  }
}
