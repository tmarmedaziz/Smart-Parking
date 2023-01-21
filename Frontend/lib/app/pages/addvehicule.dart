import 'package:flutter/material.dart';
import 'package:modern_parker/app/modles/Tokens.dart';
import 'package:modern_parker/app/modles/util/parking_features.dart';
import '../widgets/input_decoration.dart';



class Addvehicule extends StatefulWidget {
  const Addvehicule({Key? key}) : super(key: key);
  @override
  _AddvehiculeState createState() => _AddvehiculeState();
}

class _AddvehiculeState extends State<Addvehicule> {
  String vehicleNumber ="" ;
  String vehicleCategory ="" ;
  String vehicleDescription="" ;



  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    AuthTokens authTokens=new AuthTokens(arg['accessToken'], arg['refreshToken'],arg['userId']);
    ResourceApi resourceApi=ResourceApi(authTokens.accessToken,authTokens.refreshToken,authTokens.userId);
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
                                decoration: buildInputDecoration(Icons.car_rental ,"Vehicle Number"),
                                onChanged:(val) =>setState(() => vehicleNumber = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                decoration: buildInputDecoration( Icons.car_crash ,"Vehicle Category"),
                                onChanged:(val) =>setState(() => vehicleCategory = val) ,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                decoration: buildInputDecoration( Icons.car_crash ,"Vehicle Description"),
                                onChanged:(val) =>setState(() => vehicleDescription = val) ,

                              ),
                            ),

                            Padding(padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Container(
                                height: height / 18,
                                width: width *0.85,
                                decoration: BoxDecoration(
                                    color:Colors.blue, borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () {
                                    if(vehicleNumber.isEmpty || vehicleCategory.isEmpty ||vehicleDescription.isEmpty ) {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'There has been an Error'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text(
                                                      'Please check your vehicule informations'),

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
                                      resourceApi.addvehicule(vehicleNumber, vehicleCategory, vehicleDescription).then((value) => print(value.body));
                                      //Navigator.pop(context);
                                     // Navigator.of(context).pushNamed('ReserveSlot');
                                      Navigator.pushNamed(
                                          context, 'ReserveSlot', arguments: {
                                        'accessToken': resourceApi.accessToken,
                                        'refreshToken': resourceApi.refreshToken,
                                        'userId': resourceApi.userId
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'Add Your Vehicule',
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