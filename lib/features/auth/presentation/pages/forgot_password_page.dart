import 'package:WardrobePlus/core/themes/app_pallet.dart';
import 'package:WardrobePlus/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallet.lightBackgroundColor,
        leading: IconButton(onPressed: () {
          Navigator.push(
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
              TextField(decoration: InputDecoration(hintText: "Enter email")),
              SizedBox(height: 60),
              ElevatedButton(onPressed: () {}, child: Text("Send"))],
          ),
        ),
      ),
    );
  }
}
