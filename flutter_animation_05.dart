import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const defaultWidth= 100.0;
class _HomePageState extends State<HomePage> {
  
  var _isZoomedIn=false;
  var _buttonTitle='Zoom In';
  var _width=defaultWidth;
  var _curve=Curves.bounceInOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ZOOM',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.3,
          ),
        ),
        toolbarHeight: 64,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 370,
                ),
                width: _width,
                curve:_curve,
                child: Image.asset(
                  'assets/images/radhekrishna.jpg',
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: (){
              setState(() {
                _isZoomedIn=!_isZoomedIn;
                _buttonTitle=_isZoomedIn? 'Zoom Out':'Zoom In';
                _width=_isZoomedIn?MediaQuery.of(context).size.width
                :defaultWidth;
                _curve=_isZoomedIn? Curves.bounceInOut:Curves.bounceOut;
              });
            },
            
            child: Text(
              _buttonTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
            ),
        ],
      ),
    );
  }
}