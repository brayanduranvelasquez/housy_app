import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:housy_app/widgets/category_widget.dart';
import 'package:housy_app/widgets/houses_widget.dart';
import 'package:housy_app/widgets/real_state_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Eliminar el botón de retroceso
        title: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 16.0), // Agregar más padding vertical
          child: Text("Housy",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Agregar SingleChildScrollView
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 0, bottom: 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 167, 167, 167)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.search, size: 30, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 1),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(17.0),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: CategoriesWidget(),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 346,
              child: HousesWidget(),
            ),
            RealEstateGrid(), // No es necesario usar Flexible aquí
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    Navigator.of(context).pushReplacementNamed('/');
  }
}
