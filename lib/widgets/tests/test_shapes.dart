import 'package:flutter/material.dart';


List<BoxShadow> shadows = ([
      BoxShadow(
        offset: Offset(0, 10),
        color: Colors.red,
        blurRadius: 30,
        //  spreadRadius: 10,
      ),
      BoxShadow(
        offset: Offset(0, -10),
        color: Colors.yellow,
        blurRadius: 30,
        //  spreadRadius: 10,
      ),
    ]);

Widget clipPath1(){
  return ClipPath(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      boxShadow: shadows,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );  
}
Widget clipPath2(){

  return    ClipPath(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                  ),
                ),
              );
}
Widget clipPath3(){
  return ClipPath(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(40)),
                    ),
                  ),
                ),
              );  
}
Widget clipPath4(){
  
}


           
              
              
             