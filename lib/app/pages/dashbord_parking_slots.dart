import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:modern_parker/app/modles/Tokens.dart';
import 'package:modern_parker/app/pages/parking_slots_component.dart';

import '../modles/util/parking_features.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({Key? key}) : super(key: key);


  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final arg = ModalRoute.of(context)!.settings.arguments as Map   ;
    //var sessionmanager = SessionManager();
   // await sessionmanager.set("userId", arg['userId']);


    print("--------------------refreshToken------------------------");
    print(arg['refreshToken']);
    AuthTokens authTokens=new AuthTokens(arg['accessToken'], arg['refreshToken'],arg['userId']);
    ResourceApi resourceApi=ResourceApi(authTokens.accessToken,authTokens.refreshToken,authTokens.userId);
    print("------------------accessToken----------------------");
    print(arg['accessToken']);
    print("------------------userId----------------------");
    print(arg['userId']);
    dynamic userId = SessionManager().get("userId").then((value) => print("--------$value--------"));

    print("-------------------___________________________---------------------------");
    print(userId);
    print("-------------------___________________________---------------------------");

    print(arg['accessToken']);
    return Scaffold(
        backgroundColor: Colors.white,

        body:
        FutureBuilder(
            future: resourceApi.emptyslots(),
            builder:  (context,snapshot  ) {
              print(snapshot);
              print('here');
              return snapshot.hasData ?
              Stack(
                  children:[ Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: const [

                              Padding(
                                padding: EdgeInsets.fromLTRB(100.0,50,0,0),
                                child: Text("Available Slots " ,style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0),),
                              )
                            ],
                          ) ,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Color(0xff9e9e9e),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              )
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 8,
                        child: GridView.builder(

                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1,
                                crossAxisSpacing: 60,
                                mainAxisSpacing: 20),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return dashbordComponent(context ,Color(0xff96da45),snapshot.data![index],resourceApi);
                            }),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              Center(
                                  child: Container(
                                    height: height / 18,
                                    width: width / 1,
                                    decoration: BoxDecoration(
                                        color:Colors.blue, borderRadius: BorderRadius.circular(10)),
                                    padding: EdgeInsets.fromLTRB(20.0, 0.05, 10, 0),
                                    child: TextButton(
                                        onPressed: () { Navigator.pushNamed(
                                            context, 'dashboard2', arguments: {
                                          'accessToken': resourceApi.accessToken,
                                          'refreshToken': resourceApi.refreshToken,
                                          'userId': resourceApi.userId
                                        });; },
                                        child: Text(
                                          "Reservations History",
                                          style: TextStyle(color: Colors.white, fontSize: 25),
                                        )
                                    ),
                                  )
                              )
                            ],
                          ),
                          width: double.infinity/2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                  ]

              ):const Center(
                child: CircularProgressIndicator(),
              );
            }
        )
    );

  }
}