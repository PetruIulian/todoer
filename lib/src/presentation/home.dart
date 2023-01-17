import 'package:todoer/src/models/index.dart';
import 'package:todoer/src/presentation/containers/user_container.dart';
import 'package:todoer/src/presentation/home_page.dart';
import 'package:todoer/src/presentation/login_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // todo: decide if we show login page or home page
    return UserContainer(
      builder: (BuildContext context, AppUser? user) {
        if (user == null) {
          return const LoginPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}