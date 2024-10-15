import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HousesWidget extends StatefulWidget {
  const HousesWidget({super.key});

  @override
  _HousesWidgetState createState() => _HousesWidgetState();
}

class _HousesWidgetState extends State<HousesWidget> {
  List<House> _houses = [];
  bool _isLoading = true;
  final PageController _pageController = PageController(viewportFraction: 0.89);

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    try {
      final response = await http
          .get(Uri.parse('https://4csm2968-3002.use.devtunnels.ms/api/houses'));

      if (response.statusCode == 200) {
        final List<dynamic> housesJson = json.decode(response.body);
        setState(() {
          _houses = housesJson.map((json) => House.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load houses');
      }
    } catch (e) {
      print('Error fetching houses: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? _buildSkeletonLoader()
        : PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: _houses.length,
            itemBuilder: (context, index) {
              final house = _houses[index];
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mostrar la imagen desde la URL
                      Image.network(
                        house.image,
                        width: 320, // Ajusta el ancho según sea necesario
                        height: 240, // Ajusta la altura según sea necesario
                        fit: BoxFit.cover, // Ajusta cómo se muestra la imagen
                      ),
                      SizedBox(
                          height:
                              8.0), // Espacio entre la imagen y otros elementos
                      Text(
                        '\$${house.price}',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2.0), // Muestra el título de la casa
                      Text(
                        house.location,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildSkeletonLoader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
          );
        },
      ),
    );
  }
}

class House {
  final String id;
  final String title;
  final int price;
  final String location;
  final String description;
  final String image;
  final String categoryId;

  House({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.image,
    required this.categoryId,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      location: json['location'],
      description: json['description'],
      image: json['image'],
      categoryId: json['categoryId'],
    );
  }
}
