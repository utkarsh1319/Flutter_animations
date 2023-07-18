import 'package:flutter/cupertino.dart';
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

@immutable
class Person{
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'John', age: 22, emoji: '🙋🏻‍♂️'),
  Person(name: 'Emma', age: 22, emoji: '👸🏽'),
  Person(name: 'Tyler', age: 21, emoji: '🧔🏿'),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'People',
          style: TextStyle(
            fontSize: 23,
          ),
          ),
        toolbarHeight: 65,
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person=people[index];
          return ListTile(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=> DetailsPage(
                    person: person,
                    ),
                )
              );
            },
            leading: Hero(
              tag: person.name,
              child: Text(person.emoji,
              style: const TextStyle(
                fontSize: 40,
              ),
              ),
            ),
            title: Text(person.name),
            subtitle:Text(
              '${person.age} years old',
              ),
              trailing: const Icon(Icons.arrow_forward_ios,)
          );
         },
        ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key,required this.person});

  final Person person;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder:(
            (flightContext, 
              animation, 
              flightDirection, 
              fromHeroContext, 
              toHeroContext,
              ) {
                switch(flightDirection){
                  case HeroFlightDirection.push:
                  return Material(
                    color:Colors.transparent,
                     child: ScaleTransition(
                      scale: animation.drive(
                        Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).chain(
                          CurveTween(
                            curve: Curves.fastOutSlowIn,
                            ),
                        ),
                      ),
                      child: toHeroContext.widget),
                     );
                  case HeroFlightDirection.pop:
                  return Material(
                    color:Colors.transparent,
                    child: fromHeroContext.widget,
                    );
                }
            }
          ),
          tag: person.name,
          child: Text(
            person.emoji,
            style: const TextStyle(
              fontSize: 50,
            ),
          ),
        ),
        toolbarHeight: 65,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                person.name,
                style: const TextStyle(
                fontSize: 20,
                ),
                ),
            ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                '${person.age} years old',
                style: const TextStyle(
                fontSize: 20,
                         ),
                       ),
              ),
          ],
        ),
      ),
        
    );
  }
}