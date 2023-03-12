import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercompleteguide/Models/user_model.dart';
import "package:http/http.dart" as http;

class ExampleThree extends StatefulWidget {
  _ExampleThreeState createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> { 
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users")
    );

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      for(Map i in data) {
        print(i["name"]);
        userList.add(UserModel.fromJson(i as Map<String, dynamic> ));
      }

      return userList;
    } else {
      return userList;
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
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if(!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget> [
                              ReUsableRow(
                                title: 'Name',
                                value: snapshot.data![index].name.toString()
                              ),
                              ReUsableRow(
                                title: 'UserName',
                                value: snapshot.data![index].username.toString()
                              ),
                              ReUsableRow(
                                title: 'Email',
                                value: snapshot.data![index].email.toString()
                              ),
                              ReUsableRow(
                                title: 'Address',
                                value: snapshot.data![index].address!.city.toString()
                              ),
                              ReUsableRow(
                                title: 'Lattitude',
                                value: snapshot.data![index].address!.geo!.lat.toString()
                              ),
                              ReUsableRow(
                                title: 'Longitude',
                                value: snapshot.data![index].address!.geo!.lng.toString()
                              ),  
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  String title, value;

  ReUsableRow(
    {
      required this.title,
      required this.value,
    }
  );

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}