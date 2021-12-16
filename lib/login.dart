import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>(); //for storing form state.
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  void _login() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (userName.text == 'admin' && password.text == 'admin') {
        Navigator.pushNamed(context, "/home");
      } else {
        _showMyDialog();
      }
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Login failure'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    textFieldRequirement(
      String lableText,
      TextEditingController controller,
        bool isPass,
    ) {
      return SizedBox(
        height: 80,
        child: TextFormField(
          controller: controller,
          obscureText: isPass,
          textInputAction: TextInputAction.none,
          decoration: InputDecoration(
            hintText: lableText,
          ),
          textAlign: TextAlign.start,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Text is empty';
            }
            return null;
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('RetailZ'),
        backgroundColor: Colors.red,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    const Center(
                        child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    )),
                    textFieldRequirement('Username', userName, false),
                    textFieldRequirement('Password', password, true),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red
                        ),
                        child: const Text('Login'),
                        onPressed: () => _login(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
