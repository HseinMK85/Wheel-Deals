import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(CarSearchApp());
}

class CarSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Search',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CarSearchScreen(),
    );
  }
}

class CarSearchScreen extends StatefulWidget {
  @override
  _CarSearchScreenState createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  List<dynamic> _cars = [];
  bool _isLoading = false;

  Future<void> searchCars() async {
    final minPrice = _minPriceController.text;
    final maxPrice = _maxPriceController.text;

    if (minPrice.isEmpty || maxPrice.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both minimum and maximum price')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://your-infinityfree-url.com/search_cars.php?min_price=$minPrice&max_price=$maxPrice',
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          _cars = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching cars: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _minPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Minimum Price'),
            ),
            TextField(
              controller: _maxPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Maximum Price'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: searchCars,
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _cars.length,
                      itemBuilder: (context, index) {
                        final car = _cars[index];
                        return ListTile(
                          title: Text(car['name']),
                          subtitle: Text('Price: \$${car['price']}'),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}