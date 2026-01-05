import 'package:books_store/main.dart';
import 'package:books_store/providers/auth_provider.dart';
import 'package:books_store/widgets/cickables/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MainButton(
          onTap: () {
            Provider.of<AuthProvider>(context, listen: false).logout().then((
              logoutRes,
            ) {
              if (logoutRes && context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => ScreenRouter()),
                  (route) => false,
                );
              }
            });
          },
          title: "Logout",
        ),
      ),
    );
  }
}
