import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "package:http/http.dart" as http;

import "./Models/PostModel.dart";

class ExampleTwo extends StatefulWidget {
  _ExampleTwoState createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos () async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos")
    );

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200) {
      for(Map i in data) {
        Photos photo = Photos(
          title: i['title'], url: i['url'], id: i['id']
        );
        photosList.add(photo); 
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Column(
        children: <Widget> [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data![index].url.toString()
                        )
                      ),
                      subtitle: Text(
                        snapshot.data![index].title.toString()
                      ),
                      title: Text(
                        'Nodes id:'+snapshot.data![index].id.toString()
                      ),
                    );
                  }
                );
              }
            ),
          ),
          
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;

  Photos(
    {
      required this.title,
      required this.url,
      required this.id,
    }
  );
}