import 'package:flutter/material.dart';


class Test2 extends StatefulWidget {
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  double _end = -100;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(seconds: 2),
      tween: Tween(
        begin: 0,
        end: _end
      ),
      child: FlatButton(
          color: Colors.red,
          onPressed: (){
            setState(() {
            
            });
          },
          child: Text("data"),),
      curve: Curves.easeInSine,
      builder: (_,n,child){
        return SizedBox(
          width: 200+n,
        child: child
      ); 
      },
    );
  }
}

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  double _move = 300 ;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          TweenAnimationBuilder<double>(
            duration: Duration(seconds: 3) ,
            tween: Tween(begin: 0,end: _move ),
            builder: (_,n,__){
              return Positioned(
              left: n,
              child: rectToCircle(color: Colors.black)) ;
            },
                      
          ),
          Row(
                  children: <Widget>[
                    rectToCircle(),
                    rectToCircle(),
                    rectToCircle(),
                    rectToCircle(),
                    rectToCircle(),
                    rectToCircle(),
                    rectToCircle(),
                  ],
                ),
        ],
    );
  }
}


Widget rectToCircle({Color color}){

  return   TweenAnimationBuilder<double>(
                duration: Duration(seconds: 10),
                tween: Tween(begin: 0 , end: 25 ),
                builder: (_,tweenValue,__) {
                  return Container(
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(tweenValue),
                  ),
                  height: 50,
                  width: 50,
                );
                }
              );
}



class MySlider extends StatefulWidget {
  const MySlider({
    Key key,
  }) : super(key: key);

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
double _angle = 0;
double _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
                   value: _currentValue,
                   label: "Slider",
                   onChanged: (value) {
                     setState(() {
                       _currentValue = value;
                       _angle = value;
                     });
                   }),
      rotateContainerWithSlider(),
      ],
    );
  }
  Widget rotateContainerWithSlider(){
  return Center(
    child: TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300),
      tween: Tween(begin: 0, end: _angle),
      child: Container(
        height: 100,
        width: 50,
        color: Colors.black,
      ),
      builder: (__, angle, child) => Transform.rotate(
        angle: angle,
        child: child,
      ),
    ),
  );
}

}