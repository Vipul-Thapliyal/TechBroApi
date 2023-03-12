import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:another/screens/user_detail_screen.dart';
import 'package:http/http.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
    {
      Key? key,
      required this.number,
      required this.passedOtp,
    }
  ): super(key: key);

  final String number;
  final String passedOtp;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  String? otp;
  String num = '';

  bool? autoFocus;

  screen() {
    num = widget.number;
    otp = '${_fieldOne.text.toString()}${_fieldTwo.text.toString()}${_fieldThree.text.toString()}${_fieldFour.text.toString()}';
    // Navigator.push(
    //   context, MaterialPageRoute(
    //     builder: (context) => UserDetail(number: num,)
    //   ),
    // );
    if(widget.passedOtp != otp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter valid OTP')));
    }

    if(widget.passedOtp == otp) {
      print('otp: $otp');
      check();
    } else {
      print('Error');
    }

  }

  check() async {
    print('INside check()');
    final uri = Uri.parse('https://petofyoptimizedapi.azurewebsites.net/api/user/ValidatepetParentOtp');
    final headers = {'Content-Type': 'application/json'};


    Map<String, dynamic> body = {
      "data": {
        "phoneNumber": widget.number
      },
    };

    print('otp: $otp : ${otp.runtimeType}');
    print('After body');


    String jsonBody = json.encode(body);

    print('After Jsonbody');

    print('jsonBody: $jsonBody');


    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
    );

    if(response == null) {
      print('null response');
    }

    print('response: $response');

    print('After response');


    var data = jsonDecode(response.body);
    print('data: $data');
    print("Next is calling condition");
    print(data['response']['responseCode']);

    if (data['response']['responseCode'] == 117) {
      print("inside data");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserDetail(
              number: widget.number,
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
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        // title: Container(
        //   height: 100,
        //   margin: EdgeInsets.only(top: 20),
        //   child: Image.asset(
        //     'assets/logos/logo.png',
        //     height: 200,
        //     scale: 2.5,
        //   ),
        // ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image.asset(
          'assets/logos/logo.png',
          fit: BoxFit.contain,
          height: 50,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            children: <Widget> [
              Container(
                child: Text(
                  'Please wait we will auto verify the OTP sent to +${widget.number}',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Container(
                child: Text(
                  'You shall reveive an SMS with code for verification',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  SizedBox(
                    height: 60,
                    width: 50,
                      child: TextField(
                        // autofocus: autoFocus,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: _fieldOne,
                        maxLength: 1,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      // autofocus: autoFocus,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _fieldTwo,
                      maxLength: 1,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      // autofocus: autoFocus,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _fieldThree,
                      maxLength: 1,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      // autofocus: autoFocus,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _fieldFour,
                      maxLength: 1,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 350,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        screen();
                        // check();
                      },
                      label: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Spacer(),
              // SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
