
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modern_parker/app/modles/Tokens.dart';
import '../modles/util/authApi.dart';
import '../widgets/input_decoration.dart';





class BookinghistoryPage extends StatefulWidget {
  const BookinghistoryPage({Key? key}) : super(key: key);
  @override
  State<BookinghistoryPage> createState() => _BookinghistoryPageState();
}
class _BookinghistoryPageState extends State<BookinghistoryPage> {
  AuthAPI _authAPI = AuthAPI();
  String email="";
  String password="";
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                ),
                Positioned(
                  top: 15,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: height/3.6,
                    width: width/2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/login.png"),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)
                        )
                    ),
                  ),
                ),
                Positioned(
                    top: 250,

                    child: Container(
                      height: height / 1.5,
                      width: width,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              //user sign in to access reservations history
                              padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                              child: TextField(
                                decoration: buildInputDecoration( Icons.alternate_email ,"Email"),
                                onChanged:(val) =>setState(() => email = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                              child: TextField(
                                obscureText: true,
                                decoration: buildInputDecoration(Icons.lock_outline,"Password"),
                                onChanged:(val) =>setState(() => password = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Container(
                                height: height / 18,
                                width: width *0.85,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () {
                                    print(email) ;
                                    print(password);
                                    _authAPI.login(email, password).then((value){
                                      print(value);
                                      print(value.statusCode);
                                      if(value.statusCode==200){
                                        var data =jsonDecode(value.body) ;
                                        AuthTokens authtoken= AuthTokens(data['accessToken'], data['refreshToken'])  ;
                                        Navigator.pushNamed(context,'dashboard2',    arguments: {"accessToken":data['accessToken'],
                                          "refreshToken":data['refreshToken']
                                        },
                                        );

                                      }else{
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {



                                            return AlertDialog(
                                              title: const Text(
                                                  'There has been an error'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: const <Widget>[
                                                    Text(
                                                        'Please check your email or password'),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                    );


                                  },
                                  child: const Text('Sign In',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),

                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    )
                )
              ]
          ),
        ),
      ),
    );
  }


}
