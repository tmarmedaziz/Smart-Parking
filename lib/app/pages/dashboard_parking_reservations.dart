import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modern_parker/app/modles/Tokens.dart';
import 'package:modern_parker/app/modles/util/parking_features.dart';
import 'package:modern_parker/app/pages/parking_reservations_component.dart';

class Dashbord2 extends StatefulWidget {
  const Dashbord2({Key? key}) : super(key: key);

  @override
  State<Dashbord2> createState() => _Dashbord2State();
}
class _Dashbord2State extends State<Dashbord2> {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final arg = ModalRoute.of(context)!.settings.arguments as Map   ;
    print("------------------refreshToken----------------------");
    print(arg['refreshToken']);
    AuthTokens authTokens=new AuthTokens(arg['accessToken'], arg['refreshToken']);
    ResourceApi resourceApi=ResourceApi(authTokens.accessToken,authTokens.refreshToken);
    print("------------------accessToken----------------------");

    print(arg['accessToken']);
    return Scaffold(
        backgroundColor: Colors.white,

        body:
        FutureBuilder(
            future: resourceApi.Getallreservations(),
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
                                padding: EdgeInsets.fromLTRB(35.0,50,0,0),
                                child: Text("Your reservations history " ,style: TextStyle(color: Colors.white,
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
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 1,
                                crossAxisSpacing: 60,
                                mainAxisSpacing: 20),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return dashbord2Component(context ,Color(0xff7a54ff),snapshot.data![index],resourceApi);
                            }),
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