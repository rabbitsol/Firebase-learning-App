import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearningapp/ui/auth/verifycode.dart';
import 'package:firebaselearningapp/ui/utils/utils.dart';
import 'package:firebaselearningapp/widgets/round_button_widget.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LogIn'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 80),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(hintText: '+92 1234 1234567'),
            ),
            const SizedBox(height: 80),
            RoundButtonWidget(
                title: 'Login',
                loading: loading,
                onpres: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastmessage(e.toString());
                      },
                      codeSent: (String verificationID, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                    verificationID: verificationID)));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastmessage(e.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
