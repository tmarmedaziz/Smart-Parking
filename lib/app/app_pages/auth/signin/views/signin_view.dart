import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:frontend/app/modles/utils/api_services.dart';
import 'package:frontend/app/app_widgets/input_decoration.dart';
import 'package:frontend/app/modles/utils/authTokens.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../app_theme/ColorTheme.dart';
import '../controllers/signin_controller.dart';
import 'package:frontend/app/app_pages/auth/signup/views/signup_view.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}
class LoginView extends GetView<SigninController> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
class _LoginState extends State<Login> {
  APIServices _authAPI = APIServices();
  String email="";
  String password="";
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffD9EEFF),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
              children: [
                Text(
                  "Welcome back!",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: ColorTheme.primaryColor, fontSize: 16),
                ),
                Container(
                  height: height,
                  width: width,
                  color: Color(0xffD9EEFF),
                ),
                Positioned(
                  top: 15,
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
                    top: 250,

                    child: Container(
                      height: height / 1.5,
                      width: width,
                      color: Color(0xffD9EEFF),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                              child: TextField(
                                decoration: buildInputDecoration( Icons.email_outlined ,"Email"),
                                onChanged:(val) =>setState(() => email = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                              child: TextField(
                                obscureText: true,
                                decoration: buildInputDecoration(Icons.remove_red_eye,"Password"),
                                onChanged:(val) =>setState(() => password = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text('New user?',
                                    style: TextStyle(fontSize: 15,color: Colors.black
                                    ),),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const Signup()),
                                      );
                                    },
                                    child:const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color:Colors.black, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Container(
                                height: height / 18,
                                width: width / 2,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () {
                                    print(email) ;
                                    print(password);
                                    _authAPI.login(email, password).then((value){
                                      if(value.statusCode==200){
                                        var data =jsonDecode(value.body) ;
                                        AuthTokens authtoken=new AuthTokens(data['accessToken'], data['refreshToken'])  ;
                                        Navigator.pushNamed(context,'/dashboard',    arguments: {"accessToken":data['accessToken'],
                                          "refreshToken":data['refreshToken']
                                        },
                                        );

                                      }else{
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
                                                        'Email or password is incorrect'),
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

                                    //your  migration to here
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
