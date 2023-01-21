import 'package:flutter/material.dart';
import '../modles/util/authApi.dart';
import '../widgets/input_decoration.dart';




class Singin extends StatefulWidget {
  const Singin({Key? key}) : super(key: key);
  @override
  _SinginState createState() => _SinginState();
}

class _SinginState extends State<Singin> {
  AuthAPI _authAPI = AuthAPI();
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
                        image: DecorationImage(
                          image: AssetImage("images/logo.png"),
                          fit: BoxFit.fill,
                        ),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)
                        )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                              child: TextField(
                                  decoration: buildInputDecoration(Icons.perm_identity ,"Full  Name"),
                                  onChanged:(val) =>setState(() => username = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                  decoration: buildInputDecoration( Icons.alternate_email ,"Email"),
                                  onChanged:(val) =>setState(() => email = val) ,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                  decoration:  buildInputDecoration(Icons.lock_outline,"Password"),
                                  onChanged:(val) =>setState(() => password = val) ,

                              ),
                            ),
                            Padding(
                              padding:  const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                  obscureText: true,
                                  decoration: buildInputDecoration(Icons.visibility_off," Re-enter password"),
                                onChanged:(val) =>setState((){
                                confirmPassword = val;
                                }

                                ) ,
                              ),
                            ),
                            Padding(padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Container(
                                height: height / 18,
                                width: width / 1.2,
                                decoration: BoxDecoration(
                                    color:Colors.blue, borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () {
                                    if(password.isEmpty || confirmPassword.isEmpty ||password!=confirmPassword ) {
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
                                                //pushing the next page
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
                                      //Navigator.of(context).pushNamed('/Login');
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