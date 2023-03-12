import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another/screens/otp_screen.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  late String number;
  int charLength = 0;

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
      number = nameController.text;
    });
  }

  check() async {
    final uri = Uri.parse('https://petofyoptimizedapi.azurewebsites.net/api/user/SendRegistrationOtp');
    final headers = {'Content-Type': 'application/json'};

    Map<String, dynamic> body = {
      "data": {
        "phoneNumber": nameController.text
      }
    };

    String jsonBody = json.encode(body);

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
    );

    var data = jsonDecode(response.body);
    print(data['data']['otp']);


    if (data['response']['responseMessage'] == "Success") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(
                  number: nameController.text.toString(),
                  passedOtp: data['data']['otp'],
            )
        ),
      );
    } else {
      print("Error has occured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('App'),
      // ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            // SizedBox(height: 50),
            Container(
              height: 100,
              margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/logos/logo.png',
                height: 200,
                scale: 2.5,
              ),
            ),
            Container(
              // padding: EdgeInsets.only(left: 25),
              child: Text(
                'Enter Phone number for Verification',
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              // padding: EdgeInsets.only(left: 25),
              child: Text(
                'You shall reveive an SMS with code for verification',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                ),
              ),
            ),

            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      onChanged: _onChanged,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Number';
                        }
                        if(value.length < 10) {

                        }
                        if (value.length == 10) {
                          // FocusScope.of(context).nextFocus();
                          // FocusScope.of(context).unfocus();
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              nameController.clear();
                            });
                          },
                          icon: Icon(Icons.clear),
                        ),
                        // Icon(Icons.cancel),
                        hintText: 'Enter phone number',
                        contentPadding: EdgeInsets.all(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(top: 2, right: 20),
                child: Text("$charLength/10"),
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 350,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          charLength == 10) {
                        // Navigator.push(
                        //   context, MaterialPageRoute(
                        //     builder: (context) => OtpScreen(number: number)
                        //   ),
                        // );
                        check();
                      }
                    },
                    label: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: Size.fromHeight(50),
            //     ),
            //     onPressed: () {
            //     },
            //     child: Text(
            //       'Continue',
            //       style: TextStyle(
            //         fontSize: 25,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
