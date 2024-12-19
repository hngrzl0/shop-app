// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/repository/repository.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MyRepository repository = MyRepository();
  String _userName = "mor_2314";
  String _userPass = "83r5^_";

moveToHome(BuildContext context) async {
  try {
    var loginData = await repository.login(_userName, _userPass);
    String token = loginData["token"];
    var user = loginData["user"];

    if (token != null) {
      Provider.of<Global_provider>(context, listen: false).saveToken(token);
      Provider.of<Global_provider>(context, listen: false).login(user);

      //fetch logged in user cart items
      List<CartModel> cartItems =
          await repository.fetchUserCart(user.id);
      Provider.of<Global_provider>(context, listen: false).setCartItems(cartItems);

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => HomePage())
      );
    } else {
      print("Login failed");
    }
  } catch (e) {
    print(e.toString());
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),
              TextFormField(
                onChanged: (value) {
                  _userName = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  _userPass = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Material(
                borderRadius: BorderRadius.circular(32.0),
                color: Colors.red,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () => moveToHome(context),
                  child: AnimatedContainer(
                    color: Colors.transparent,
                    duration: const Duration(seconds: 1),
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                            "Нэвтрэх",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
