import 'package:flutter/material.dart';
import 'package:github_profile_viewer_flutter_app/ui/screens/followers_screen.dart';
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
  bool _isSearching = false;

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
      _isSearching = false;
    });
    print(_userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // leading: Image.asset(
        //   "assets/img/github.png",
        //   width: 20,
        //   height: 20,
        // ),
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
                10.0,
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
                setState(() {
                  _isSearching = true;
                  _userData = null;
                });
                _fetchData();
              },
            ),
          ),
          onChanged: (String value) {
            setState(() {
              _userSearch = value;
              // _userData = null;
            });
          },
        ),
      ),
      body: _userData == null && _isSearching
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Image.asset(
                  //   "assets/img/github.png",
                  //   width: 100,
                  //   height: 100,
                  // ),
                  CircularProgressIndicator(),
                  Text("Searching user..."),
                ],
              ),
            )
          : _userData == null
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
                      Text("Search Users"),
                    ],
                  ),
                )
              : _userData["message"] == "Not Found"
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Image.asset(
                          //   "assets/img/github.png",
                          //   width: 100,
                          //   height: 100,
                          // ),
                          // CircularProgresIndicator(),
                          Text("No User found"),
                        ],
                      ),
                    )
                  : Flex(
                      direction: Axis.vertical,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            // color: Colors.red,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: Flex(
                              direction: Axis.vertical,
                              children: <Widget>[
                                //User data
                                Expanded(
                                  flex: 3,
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        20.0,
                                      ),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xfdb99b88),
                                            Color(0xA770EF88),
                                            Color(0xcf8bf388),
                                            Color(0xfdb99b88)
                                            // Colors.black,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                100.0,
                                              ),
                                              border: Border.all(
                                                width: 5.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                100.0,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    _userData["avatar_url"],
                                                width: 200,
                                                height: 200,
                                                placeholder: (context, url) {
                                                  Image.asset(
                                                    "assets/img/github.png",
                                                    width: 200,
                                                    height: 200,
                                                  );
                                                },
                                              ),
                                              // Image.network(
                                              //   _userData["avatar_url"],
                                              //   width: 200,
                                              //   height: 200,
                                              // ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            _userData["login"],
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // List data
                                Expanded(
                                  flex: 2,
                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            // SizedBox(
                                            //   height: 10,
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                print("tapped");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FollowersScreen(
                                                      data: _userFollowing,
                                                      title: "Following",
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                color: Colors.white,
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                    15.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "assets/img/following.png",
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                      Text(
                                                        "Following",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        _userData["following"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 20,
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                print("tapped");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FollowersScreen(
                                                      data: _userFollowers,
                                                      title: "Followers",
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                color: Colors.white,
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                    15.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "assets/img/followers.png",
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                      Text(
                                                        "Followers",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        _userData["followers"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 20.0,
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                print("tapped");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FollowersScreen(
                                                      data: _userRepo,
                                                      title: "Repositories",
                                                      isRepo: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                color: Colors.white,
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                    15.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "assets/img/repo.png",
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                      Text(
                                                        "Repositories",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        _userData[
                                                                "public_repos"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}
