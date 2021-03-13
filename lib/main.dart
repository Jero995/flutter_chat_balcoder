import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_balcoder/ui/auth/auth_service.dart';
import 'package:flutter_chat_balcoder/ui/auth/root_page.dart';
import 'package:flutter_chat_balcoder/ui/home/home_page.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');

    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      home: RootPage(authService: new AuthService(),)
    );
  }
}

