// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:biometric_authentication/hello.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthentication extends StatefulWidget {
  BiometricAuthentication({super.key});

  @override
  State<BiometricAuthentication> createState() =>
      _BiometricAuthenticationState();
}

class _BiometricAuthenticationState extends State<BiometricAuthentication> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 230, 200),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/money.png'),
            _buildText('P A Y E E Z', 60),
            const SizedBox(
              height: 50,
            ),
            _buildText("T O U C H    TO    U N L O C K", 15),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () async {
                if (!isAuthenticated) {
                  final bool canAuthenticateWithBiometrics =
                      await _auth.canCheckBiometrics;
                  if (canAuthenticateWithBiometrics) {
                    try {
                      final bool didAuthenticate = await _auth.authenticate(
                          localizedReason:
                              'Please authenticate to access the app');
                      setState(() {
                        isAuthenticated = didAuthenticate;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Hello()));
                    } catch (e) {
                      Text('Error $e');
                    }
                  } else {
                    print('Can not authenticate with biometrics');
                  }
                } else {
                  const Text("Cannot Authenticate");
                }
              },
              child: const Image(
                image: AssetImage('assets/fingerprint.png'),
                height: 100,
                width: 100,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, double size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
      ),
    );
  }
}
