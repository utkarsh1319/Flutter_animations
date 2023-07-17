import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

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
const widthAndHeight=100.0;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController=AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 20,
      )
    );
     _yController=AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 30,
      )
    );
     _zController=AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 40,
      )
    );
    _animation= Tween<double>(
      begin: 0,
      end: pi*2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _xController
    ..reset()
    ..repeat();

    _yController
    ..reset()
    ..repeat();

    _zController
    ..reset()
    ..repeat();

    return Scaffold(
     body: SafeArea(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          const SizedBox(
            height: widthAndHeight,
            width: double.infinity,
          ),
           AnimatedBuilder(
            animation: Listenable.merge([
              _xController,
              _yController,
              _zController,
            ]),
            builder: (contex,child){
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_animation.evaluate(_xController))
                  ..rotateY(_animation.evaluate(_yController))
                  ..rotateZ(_animation.evaluate(_zController)),
                child: Stack(
                children:  [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                    ..translate(
                      Vector3(
                        0,0,-widthAndHeight
                      ),
                      ),
                    child: Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: Colors.purple,
                    ),
                  ),
                  //left
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                    ..rotateY(pi/2.0),
                    child: Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: Colors.red,
                    ),
                  ),
                  //right
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                    ..rotateY(-pi/2.0),
                    child: Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: Colors.blue,
                    ),
                  ),
                  //front
                  Container(
                    width: widthAndHeight,
                    height: widthAndHeight,
                    color: Colors.green,
                  ),
                  //top
                  Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                    ..rotateX(-pi/2.0),
                    child: Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: Colors.orange,
                    ),
                  ),
                  //bottom
                  Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                    ..rotateX(pi/2.0),
                    child: Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: Colors.brown,
                    ),
                  ),
                  ],
                ),
              );
            },
           ),
         ],
       ),
     ),
    );
  }
}