import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modern_parker/app/modles/Tokens.dart';
import 'package:modern_parker/app/modles/util/parking_features.dart';
import '../modles/util/authApi.dart';
import '../widgets/input_decoration.dart';

class ReserveSlot extends StatefulWidget {
  const ReserveSlot({Key? key}) : super(key: key);
  @override
  _ReserveSlotState createState() => _ReserveSlotState();
}

class _ReserveSlotState extends State<ReserveSlot> {
  String id ="" ;
  String reservation ="" ;
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
                          image: AssetImage("images/reserve.jpg"),
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
                                decoration: buildInputDecoration(Icons.local_parking ,"ID of the Slot"),
                                onChanged:(val) =>setState(() => id = val) ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: TextField(
                                decoration: buildInputDecoration( Icons.timelapse ,"Your reservation"),
                                onChanged:(val) =>setState(() => reservation = val) ,

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
                                    if(id.isEmpty || reservation.isEmpty) {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'There have been an error'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text(
                                                      'Please check your reservation informations'),

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
                                      resourceApi.reservationslot(id, reservation).then((value) => print(value.body));
                                      //Navigator.pop(context);
                                      Navigator.of(context).pushNamed('BookingPage');
                                    }
                                  },
                                  child: const Text(
                                    'Reserve your slot',
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