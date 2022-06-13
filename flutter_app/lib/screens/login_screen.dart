import 'package:e_commerce_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isShow = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login',
            style:
                TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/food.jpg'),
                ),
              ),
            ),

            // Email Form Field
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextFormField(
                controller: _emailController,
                validator: (email) =>
                    email!.isEmpty ? "Email Cannot Be Empty" : null,
                decoration: InputDecoration(
                  labelText: 'Enter Your Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Password Form Field
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextFormField(
                controller: _passwordController,
                obscureText: _isShow,
                validator: (password) => password!.length < 6
                    ? "Password Cannot Be less than 6 characters "
                    : null,
                decoration: InputDecoration(
                  labelText: 'Enter Your Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: _isShow
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isShow = !_isShow;
                      });
                    },
                  ),
                ),
              ),
            ),

            // Login Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: TextButton(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    final email = _emailController.text;
                    final password = _passwordController.text;

                    AuthService().createUser(email, password);


                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Login Successful'),
                      backgroundColor: Colors.green,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Email or Password Cannot be empty'),
                      backgroundColor: Colors.red,
                    ));
                    print('Login Failed!!');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
