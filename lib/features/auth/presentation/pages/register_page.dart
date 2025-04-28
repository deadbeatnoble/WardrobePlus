import 'package:WardrobePlus/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:WardrobePlus/core/themes/app_pallet.dart';
import 'package:WardrobePlus/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(
            top: 100,
            right: 32,
            left: 32,
            bottom: 50,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Register Now",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Text(
                    "Create an account and save",
                    style: TextStyle(color: AppPallet.lightHintTextColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 60),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Enter name"),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: "Passowrd",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      RegisterEvent(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ),
                    );
                  },
                  child: Text("Create Account"),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return CircularProgressIndicator();
                    } else if (state is AuthSuccess) {
                      return Text(state.message);
                    } else if (state is AuthFailure) {
                      return Text(state.message);
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 15),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: AppPallet.lightTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Log in",
                          style: TextStyle(
                            color: AppPallet.lightTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
