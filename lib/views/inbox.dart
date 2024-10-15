import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inbox"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ), // Sin AppBar
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco
        ),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centrar verticalmente
            children: [
              Icon(
                Icons.message, // Ícono de mensaje
                size: 100, // Tamaño del ícono
                color: Colors.grey, // Color del ícono
              ),
              SizedBox(height: 20), // Espacio entre el ícono y el texto
              Text(
                'No Messages',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto negro
                ),
              ),
              SizedBox(height: 10), // Espacio entre el texto y el siguiente
              Text(
                'When you contact someone, your conversations will be found here.',
                textAlign: TextAlign.center, // Centrar el texto
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, // Texto negro
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
