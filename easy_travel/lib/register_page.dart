import 'package:easy_travel/main_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isHiden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "First name",
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Last name",
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Email",
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Password",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isHiden = !_isHiden;
                  });
                },
                icon: Icon(_isHiden ? Icons.visibility_off : Icons.visibility),
              ),
            ),
            obscureText: _isHiden,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Text('Register'),
            ),
          ),
        ),

        TextButton(onPressed: () {}, child: Text("Login")),
      ],
    );
  }
}
