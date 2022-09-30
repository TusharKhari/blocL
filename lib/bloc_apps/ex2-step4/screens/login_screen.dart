import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreenEx2 extends StatefulWidget {
  const LoginScreenEx2({super.key});

  @override
  State<LoginScreenEx2> createState() => _LoginScreenEx2State();
}

class _LoginScreenEx2State extends State<LoginScreenEx2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const TextField(
              decoration: InputDecoration(hintText: 'enter your email here...'),
            ),
            const TextField(
              obscureText: true,
             obscuringCharacter: '◉',
              decoration:
                  InputDecoration(hintText: 'enter your password here...'),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    //   title: const Text('Login Error'),
                    content: SizedBox(
                      height: 80,
                      width: 30,
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 25,
                          ),
                          Text('please wait...')
                        ],
                      ),
                    ),
                  ),
                );
                // Navigator.of(context).pop();
               

                Future.delayed(const Duration(seconds: 3), () {
                 Navigator.of(context).pop();
                 passwordController.text != emailController.text ?  showDialog(
                   // useRootNavigator: false,
                   // barrierDismissible: false,
                 //Navigator.pop(),
                    barrierColor: Colors.black.withAlpha(150),
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Error'),
                      content: const Text(
                        'Invalid email/password combination. Please try again with valid credentials!',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: const Text('OK'),
                          ),
                        ),
                      ],
                    ),
                  ) :
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreenEx2(),
                  ),
                );
                });
              
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
