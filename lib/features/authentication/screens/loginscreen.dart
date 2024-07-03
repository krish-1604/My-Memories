import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mymemories/features/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, auth, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/logo.png"),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                child: SizedBox(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                      shadowColor: WidgetStateProperty.all<Color>(Colors.grey.shade300),
                      elevation: WidgetStateProperty.all<double>(10),
                    ),
                    onPressed: () => auth.signIn(context),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                            FontAwesomeIcons.google,
                        ),
                        SizedBox(
                          width: 9.5,
                        ),
                        Text(
                            "Sign in with Google",
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
