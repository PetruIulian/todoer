import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:todoer/src/actions/index.dart';
import 'package:todoer/src/models/index.dart';
import 'package:todoer/src/presentation/containers/user_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
            )
          ]
        ),
        child: DiamondBottomNavigation(
          itemIcons: const <IconData>[
            Icons.account_circle,
            Icons.notifications,
          ],
          centerIcon: Icons.add,
          selectedIndex: 1,
          onItemPressed: (int item){

          },
        ),
      )
    );
  }
}
