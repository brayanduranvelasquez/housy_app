import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.70,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Discover Your\nDream House",
                    style: TextStyle(
                      fontSize: 34,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            print('Sign Up pressed!');
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.grey),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text('Sign Up',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Text('Or',
                            style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => print(
                          'Log In with Google pressed!'), // Lógica de inicio de sesión con Google
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey),
                        textStyle: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      child: const Text('Log In with Google',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
