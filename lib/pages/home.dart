import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopper_networking/models/post_model.dart';
import 'package:chopper_networking/pages/post_Details.dart';
import 'package:flutter/material.dart';
import 'package:chopper_networking/api_services/chopper_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ChopperHelper _helper = ChopperHelper.create();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 20.0,
          color: Colors.white,
        ),
        onPressed: (){
          Map<String,dynamic> data = {
            "title":"my name is ahmed talal",
            "body":"i am flutter developer",
          };
           Future<Response> response=_helper.sendPost(data);
           print(response);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.15,
            ),
            Text(
              "Chopper Networking",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: FutureBuilder<Response>(
                future: _helper.getAllPosts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    List posts = json.decode(snapshot.data.bodyString);
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: ObjectKey(posts[index]["id"]),
                          onDismissed: (direction) {
                            _helper.deletePost(posts[index]["id"]);
                          },
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (C) =>
                                        PostDetails(post: posts[index]),
                                  ),
                                );
                              },
                              title: Text(
                                posts[index]["id"].toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              subtitle: Text(
                                posts[index]["title"],
                              ),
                              trailing: Text(
                                posts[index]["userId"].toString(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
