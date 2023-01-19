import 'dart:async';

import 'package:flutter/material.dart';
import 'package:async/async.dart';

class TrafficLight extends StatefulWidget {
  const TrafficLight({Key? key}) : super(key: key);

  @override
  State<TrafficLight> createState() => _TrafficLightState();
}

class _TrafficLightState extends State<TrafficLight> {
  int c=-1;
  int t=0;
  List<Color> light=[Colors.red,Colors.grey, Colors.amber];
  List<int> time=[20,15,5];
  Timer? timer;
  Timer? clock;

  changeColor(int a, int b)
  {

    if(b==1)
      {

        setState(() {
          (a==2)?(c=0):c++;
        });
        //startTimer();
        clock= Timer.periodic(Duration(seconds: 1), (_) {
          setState(() {
            t+=1;
          });
        });
        toNext();
      }
    else
      {
        timer!.cancel();
        clock!.cancel();
        setState(() {
          t=0;
          ((a+2)>2)?(c=(c+2)-3):(c=c+2);
        });
        //startTimer();
        

        clock= Timer.periodic(Duration(seconds: 1), (_) {
          setState(() {
            t+=1;
          });
        });
        toNext();


      //  _myFuture();
      }
  }
  toNext()
  {
    timer=Timer(Duration(seconds: time[c]), () {
      clock!.cancel();
      changeColor(c, 1);

      setState(() {
        t=0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("ASSIGNMENT"), backgroundColor: Colors.black54,),

      body: Container(
        child: Row(

          children: [
              Container(
                //padding: EdgeInsets.symmetric(vertical: height*0.3, horizontal: width*0.1),
                width: width*0.5,
                height: height,
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      height: height*0.25,
                      width: width,

                      decoration: BoxDecoration(
                          color: (c==0)?Colors.red:Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),

                    ),
                    SizedBox(height: height*0.055,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      height: height*0.25,
                      width: width,
                      decoration: BoxDecoration(
                          color: (c==2)?Colors.yellow:Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                    ),
                    SizedBox(height: height*0.055,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.03),
                      height: height*0.25,
                      width: width,
                      decoration: BoxDecoration(
                          color: (c==1)?Colors.green:Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),                    )
                  ],
                ),

              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Center(
                  child: Container(
                    height: height*0.2,
                    width: width*0.3,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    child: Center(
                      child: Text(
                        t.toString(), style: TextStyle(color: Color.fromRGBO(57, 255, 20, 1), fontWeight: FontWeight.w700, fontSize: height*0.1),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width*0.5,

                  child: Center(
                    child: ElevatedButton(
                      onPressed: (c==-1)?(){changeColor(c, 1);}:
                          (){
                        changeColor(c, 2);
                      },
                      child: (c==-1)?Text("Start"):Text("Skip"),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
