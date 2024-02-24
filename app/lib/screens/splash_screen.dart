import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userLoggedIn = false;

  @override
  void initState() {
    const storage = FlutterSecureStorage();
    storage.read(key: "accessToken").then((value) {
      userLoggedIn = value?.isNotEmpty ?? false;
    });
    super.initState();
  }

  void setUserLoggedIn() {
    setState(() {
      userLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return userLoggedIn
        ? const HomeScreen()
        : AuthScreen(setUserLoggedIn: setUserLoggedIn);
  }
}
