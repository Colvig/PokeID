import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FirstRoute()),
              );
            },
            child: Text('Screen 1'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            },
            child: Text('Screen 2'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThirdRoute()),
              );
            },
            child: Text('Screen 3'),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////
///
///              FIRST ROUTE       - fetches eevee's stats
///
///////////////////////////////////////////////////////////////////////////////////////////////
class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  var pokeApi = "https://pokeapi.co/api/v2/pokemon/eevee";
  void initState() {
    super.initState();
    //we can change the state of the app
    if (mounted) {
      fetchType();
    }
  }

  List pokedex = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            // button which fetches data from the POKEAPI
            onPressed: fetchType,
            child: const Text('fetchType!'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate back to first route when tapped.
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ],
      ),
    );
  }

  void fetchType() async {
    print('fetchType called');
    var url = Uri.https("pokeapi.co", "/api/v2/pokemon/eevee");
    // retreive the response code (value)
    http.get(url).then((value) {
      // if the response code is 200 the call was successful
      // now perform the task
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        //print(decodedJsonData);
        pokedex = decodedJsonData['types'];
        print(pokedex[0]['type']['name']);
      }
      print('fetchType completed');
    });
  }
}

////////////////////////////////////////////////////////////////////////////////////////////

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
