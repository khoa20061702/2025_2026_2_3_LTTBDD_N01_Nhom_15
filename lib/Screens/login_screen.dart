import 'package:flutter/material.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>_LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: const Text('Login'),
        centerTitle:true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            TextField(
              decoration:InputDecoration(
                labelText:'email',
                border:OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              )
            ),
            SizedBox(height:20),
            TextField(
              obscureText:true,
              decoration:InputDecoration(
                labelText:'password',
                border:OutlineInputBorder(),
                prefixIcon:Icon(Icons.lock),
              )
            ),
            SizedBox(height: 30),
            SizedBox(
              width:double.infinity,
              child:ElevatedButton(
                onPressed:(){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:(_) => const MainScreen(),
                    ),
                  );
                },
                child:Text('Login'),
              )
            )
          ]
        )
      )
    );
  }
  
}
