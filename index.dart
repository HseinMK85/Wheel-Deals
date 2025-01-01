import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  
import 'dart:convert';  

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Finder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CarSearchPage(),
    );
  }
}

class CarSearchPage extends StatefulWidget {
  @override
  _CarSearchPageState createState() => _CarSearchPageState();
}

class _CarSearchPageState extends State<CarSearchPage> {
  List<dynamic> cars = [];

  Future<void> fetchCars() async {
    final url = Uri.parse('https://WheelDeals77.infinityfreeapp.com/search_cars.php');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          cars = json.decode(response.body);  
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCars();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Finder'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cars[index]['name']),
            subtitle: Text('\$${cars[index]['price']}'),
          );
        },
      ),
    );
  }
}
