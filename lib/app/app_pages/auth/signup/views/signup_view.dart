import 'package:flutter/material.dart';
import 'package:frontend/app/modles/utils/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/app/app_widgets/input_decoration.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controllers/signup_controller.dart';
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}
class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Signup();
  }
}
class _SignupState extends State<Signup> {
  APIServices _authAPI = APIServices();
  String username ="" ;
  String email ="" ;
  String password="" ;
  String confirmPassword="" ;


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height ;
    final width=MediaQuery.of(context).size.width ;
    return Scaffold(
      body:SingleChildScrollView(
        child: Center(
          child: Stack(
              children:[
                SizedBox(
                  height: height,
                  width: width,

                ),
                Positioned(
                  top: 4,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: height/3,
                    width: width/2,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(120)
                        )
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  top: 210,
                  child: Container(
                    height: height/1.2,
                    width: width/2,
                    decoration: const BoxDecoration(
                        color: Color(0xffD9EEFF),
                        borderRadius: BorderRadius.all(Radius.circular(25)
                        )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                              child: TextField(
                                decoration: buildInputDecoration(Icons.account_circle ,"Full  Name"),
                                onChanged:(val) =>setState(() => username = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                decoration: buildInputDecoration( Icons.email_outlined ,"Email"),
                                onChanged:(val) =>setState(() => email = val) ,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                decoration:  buildInputDecoration(Icons.remove_red_eye,"Password"),
                                onChanged:(val) =>setState(() => password = val) ,

                              ),
                            ),
                            Padding(
                              padding:  const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                obscureText: true,
                                decoration: buildInputDecoration(Icons.remove_red_eye," Confirm Password"),
                                onChanged:(val) =>setState((){
                                  confirmPassword = val;
                                }

                                ) ,
                              ),
                            ),
                            Padding(padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Container(
                                height: height / 18,
                                width: width / 2,
                                decoration: BoxDecoration(
                                    color:Colors.blue, borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () {
                                    if(password.isEmpty || confirmPassword.isEmpty ||password.isEmpty ) {
                                      //
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'An Error Occurred'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text(
                                                      'Please check your password'),

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
                                    else {
                                      _authAPI.signUp(email, username, username, password).then((value) => print(value.body));
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}