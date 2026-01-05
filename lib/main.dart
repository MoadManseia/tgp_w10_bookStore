import 'package:books_store/providers/auth_provider.dart';
import 'package:books_store/screens/auth_screens/login_screen.dart';
import 'package:books_store/screens/auth_screens/splash_screen.dart';
import 'package:books_store/screens/handling_screen/loading_screen.dart';
import 'package:books_store/screens/main_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Books Store',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initAuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, _) {
        return authConsumer.status == AuthStatus.authenticated
            ? HomeScreen()
            : authConsumer.status == AuthStatus.unauthenticated
            ? LoginScreen()
            : authConsumer.status == AuthStatus.authenticating
            ? LoadingScreen()
            : LoadingScreen();
      },
    );
  }
}
