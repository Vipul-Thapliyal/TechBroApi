import 'dart:convert';

import 'package:another/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserDetail extends StatefulWidget {
  const UserDetail(
    {
      Key? key,
      required this.number,
    }
  ) : super(key: key);

  final String number;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  var receivedNumber = TextEditingController();

  int? convertNumber;
  String? name, lastName, eMail;

  @override
  void initState() {
    // TODO: implement initState
    receivedNumber.text = widget.number;
    super.initState();
  }



  void check() {
    name = nameController.text;
    lastName = lastNameController.text;
    eMail = emailController.text;
    // print(name);
    // print(name.runtimeType);
    // print(lastName);
    // print(eMail);
    convertNumber = int.parse(widget.number);
    // print(convertNumber);
    // print(convertNumber.runtimeType);
    checked();
  }

  checked() {
    if(name!.trim().isEmpty && lastName!.trim().isEmpty && eMail!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter the details')));
    }
    // else if(name!.trim().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter name')));
    // }
    else if(lastName!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter lastName')));
    } else if(eMail!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter eMail')));
    }
    if(nameController.text != '' && lastNameController.text != '' && emailController.text != '') {
      // print(nameController.text);
      // print(nameController.text.runtimeType);
      // print(nameController.text.toString());
      // print(nameController.text.toString().runtimeType);
      // print('Inside checked');
      checking();
    } else {
      print("Enter detailer");
    }
  }

  checking() async {
    final uri = Uri.parse('https://petofyoptimizedapi.azurewebsites.net/api/User/PetParentRegistration');
    final headers = {'Content-Type': 'application/json'};

    Map<String, dynamic> body = {
      "data" : {
        "FirstName": "$name",
        "LastName": "$lastName",
        "Email": "$eMail",
        "PhoneNumber": convertNumber
      }
    };

    // print('After body');


    String jsonBody = json.encode(body);

    // print('After Jsonbody');
    //
    // print('jsonBody: $jsonBody');


    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
    );

    // if(response == null) {
    //   print('null response');
    // }
    //
    // print('response: $response');
    //
    // print('After response');


    var data = jsonDecode(response.body);

    // print('data: $data');
    // print("Next is calling condition");
    // print(data['response']['responseCode']);

    if (data['response']['responseMessage'] == "Success") {
      print("inside data");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard()
        ),
      );
    } else {
      print("Error has occured");
    }

  }

  @override
  Widget build(BuildContext context) {
    var widthContainer = (MediaQuery.of(context).size.width / 2) - 70;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget> [
            Container(
              height: 100,
              margin: EdgeInsets.only(top: 20,),
              // padding: EdgeInsets.only(left: 50),
              child: Center(
                child: Image.asset(
                  'assets/logos/logo.png',
                  height: 200,
                  scale: 2,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              // padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter Your details',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Form(
              child: Column(
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Container(
                        width: widthContainer,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: nameController,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a name';
                            }
                            if(value!.trim().isEmpty) {
                              return 'Fill name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            // contentPadding: EdgeInsets.all(2),
                          ),
                        ),
                      ),
                      Container(
                        width: widthContainer,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: lastNameController,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            contentPadding: EdgeInsets.all(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    // padding: EdgeInsets.all(20),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        // contentPadding: EdgeInsets.all(14),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.centerLeft,
                    // padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Contact Number',
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: receivedNumber,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      // maxLength: 2,
                      // maxLines: 2,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // controller: nameController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an Email';
                        }
                        return null;
                      },
                      // decoration: InputDecoration(
                      //   label: Text(
                      //     '${receivedNumber.text.toString()}',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 30,
                      //     ),
                      //   ),
                      //   // labelStyle: TextStyle(height: 10),
                      //   // contentPadding: EdgeInsets.all(10),
                      // ),
                    ),
                  ),

                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () {
                  check();
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
