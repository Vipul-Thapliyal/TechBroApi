import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "package:http/http.dart" as http;

import "./Models/PostModel.dart";

class homescreen extends StatefulWidget {
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  List<PostsModel> postList = []; // iksey items me <PostModel>Map hongey

  Future<List<PostsModel>> getPostApi () async {
    final response = await http.get(Uri.parse(
      "https://jsonplaceholder.typicode.com/posts"
      
    )); //URL ka data response me gaya
    var data = jsonDecode(response.body.toString()); // response ki body ko decode kia jsonDecode returns Map<String, dynamic>

    if(response.statusCode == 200) {
      postList.clear(); //Clear data of list each time page reloads puraaney data ki wajeh se list ka size nahi badhey
      for(Map i in data) {
        postList.add(PostsModel.fromJson(i as Map<String, dynamic>)); // Map ke andar ke har index ke data ko postList me daalo
      }
      return postList;
    } else {
      return postList;

    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Course'),
      ),
      body: Column(
        children: <Widget> [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text('Title\n'+postList[index].title.toString()),
                              Text("Description\n"+postList[index].body.toString()),
                              
                            ],
                          ),
                        ),
                      );
                    }
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}