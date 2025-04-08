import 'package:ecommerce/View/Screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/AuthProvider.dart';

class CustomLoginScreen extends StatefulWidget {
  const CustomLoginScreen({super.key});

  @override
  State<CustomLoginScreen> createState() => _CustomLoginScreenState();
}

class _CustomLoginScreenState extends State<CustomLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return FlutterLogin(
      title: 'Login',
      savedEmail: 'x@gmail.com',
      savedPassword: '123456789',
      logo: 'assets/imgs/halal icon2.png',
      theme: LoginTheme(
        primaryColor: Colors.orange.shade900,
        accentColor: Colors.orange.shade800,
        errorColor: Colors.red,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
      scrollable: true,
      onLogin: _authUser,
      onSignup: _authUser2,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
      onRecoverPassword: _recoverPassword,
    );
  }

  /// 🔹 Login with PocketBase via AuthProvider
  Future<String?> _authUser(LoginData data) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(data.name, data.password);
    return success ? null : 'Invalid email or password';
  }

  /// 🔹 Signup with PocketBase via AuthProvider
  Future<String?> _authUser2(SignupData data) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.signup(data.name!, data.password!, data.additionalSignupData);
    return success ? null : 'Signup failed. Email may already exist.';
  }

  /// 🔹 Password Recovery
  Future<String?> _recoverPassword(String name) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.recoverPassword(name);
    return success ? null : 'User not found or error occurred.';
  }
}
