import 'package:WardrobePlus/core/themes/app_pallet.dart';
import 'package:WardrobePlus/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:WardrobePlus/features/auth/presentation/pages/login_page.dart';
import 'package:WardrobePlus/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<StatefulWidget> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(
          top: 100,
          right: 32,
          left: 32,
          bottom: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Wardrobe In Hand",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Check your wardrobe through your phone",
                      style: TextStyle(
                        color: AppPallet.lightHintTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider.value(
                                value: context.read<AuthBloc>(),
                                child: RegisterPage(),
                              ),
                        ),
                      );
                    },
                    child: Text("Register"),
                  ),
                  SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider.value(
                                value:
                                    context
                                        .read<
                                          AuthBloc
                                        >(), // Pass the existing AuthBloc
                                child: LoginPage(),
                              ),
                        ),
                      );
                    },
                    child: Text("Sign In"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
