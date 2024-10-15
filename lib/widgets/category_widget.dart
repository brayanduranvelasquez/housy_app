import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await http.get(
          Uri.parse('https://4csm2968-3002.use.devtunnels.ms/api/categories/'));

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = json.decode(response.body);
        setState(() {
          _categories =
              categoriesJson.map((json) => Category.fromJson(json)).toList();
          _isLoading = false;
          _selectedCategoryId =
              _categories.isNotEmpty ? _categories[0].id : null;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? _buildSkeletonLoader()
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = category.id == _selectedCategoryId;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategoryId = category.id;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.black : Colors.white,
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(category.name,
                      style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade500)),
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
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
