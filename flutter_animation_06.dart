import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:developer' as devtools show log;

extension Log on Object{
  void log()=> devtools.log(toString());
}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const HomePage(),
      );
  }
}

class CircleClipper extends CustomClipper<Path>{
  const CircleClipper();
  
  @override
  Path getClip(Size size) {
    var path=Path();

    
    final rect=Rect.fromCircle(
      center:Offset(size.width/2,size.height/2),
      radius: size.width/2,
    );
    path.addOval(rect);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path>oldClipper)=>false;
}

Color getRandomColor() => Color(
  0xFF000000 + 
  math.Random().nextInt(
    0x00FFFFFF,
    ),
  );
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: ClipPath(
          clipper: const CircleClipper(),
          child: TweenAnimationBuilder(
            tween: ColorTween(
              begin: getRandomColor(),
              end: _color,
            ),
            onEnd: (){
              setState(() {
                _color= getRandomColor();
              });
            },
            duration: const Duration(seconds: 1),
            child: Container(
              width:MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              color: Colors.red,
            ),
            builder: (context, Color?color,child){
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color!,
                  BlendMode.srcATop,
                ),
                child: child,
              );
            },
          ),
         ),
      ),
    );
  }
}