import 'package:delivery_app/auth/signIn.dart';
import 'package:delivery_app/model/brandController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: BrandController(),
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.grey[200]),
        debugShowCheckedModeBanner: false,
        home: SignIn(),
      ),
    );
  }

}

