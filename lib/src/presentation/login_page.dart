import 'package:google_fonts/google_fonts.dart';
import 'package:todoer/src/actions/index.dart';
import 'package:todoer/src/models/index.dart';
import 'package:todoer/src/presentation/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _onResponse(dynamic action) {
    if (action is LoginError) {
      final Object error = action.error;
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? error.code)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Image.asset('assets/logo-no-background.png'),
                  ),
                  const SizedBox(height: 65,),
                  const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                  ),
                  const SizedBox(height: 50,),
                  // email text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Material(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: TextFormField(
                            validator: (String? value) {
                              if (value == null || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            controller: _email,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // password text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Material(
                            elevation: 5,
                            shadowColor: Colors.grey,
                          child: TextFormField(
                            validator: (String? value) {
                              if (value == null || value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                            controller: _password,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100,),
                  // login button
                  Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 15),
                        child: GestureDetector(
                          onTapDown: (_) {
                            if (!Form.of(context)!.validate()) {
                              return;
                            }
                            final Login action =
                            Login(email: _email.text, password: _password.text, response: _onResponse);
                            StoreProvider.of<AppState>(context).dispatch(action);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration:
                            BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(25)),
                            child: const Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Not a member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTapDown: (_){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          ' Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
