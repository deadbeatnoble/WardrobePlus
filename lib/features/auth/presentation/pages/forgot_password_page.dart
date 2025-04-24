import 'package:firebase_auth/firebase_auth.dart';
import 'package:WardrobePlus/core/themes/app_pallet.dart';
import 'package:WardrobePlus/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _sendPasswordResetEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset email sent!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is invalid.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred.")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallet.lightBackgroundColor,
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 32, left: 32, bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Recover Password",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  "Forgot your password?\nPlease enter the email you used when creating you account.\nYou will recieve an OTP to create a new password.",
                  style: TextStyle(color: AppPallet.lightHintTextColor),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 60),
              TextField(controller: _emailController, decoration: InputDecoration(hintText: "Enter email")),
              SizedBox(height: 60),
              ElevatedButton(onPressed: _sendPasswordResetEmail, child: Text("Send"))],
          ),
        ),
      ),
    );
  }
}
