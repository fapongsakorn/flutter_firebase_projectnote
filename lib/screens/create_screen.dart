import 'package:flutter/material.dart';
import 'package:flutter_firebase_projectnote/screens/login_screen.dart';
import 'package:flutter_firebase_projectnote/services/AuthService.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: form_create(context),
    );
  }

  form_create(BuildContext context) {
    final Email = TextEditingController();
    final Password = TextEditingController();

    final Service = AuthService();
    return Center(
        child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Image.network(
            'asset/logo/register.png',
            width: 150,
            height: 150,
          )),
          SizedBox(
            height: 30,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Email",
              icon: Icon(Icons.person),
            ),
            controller: Email,
          ),
          TextField(
            obscureText: true,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              hintText: "Enter password",
              icon: Icon(Icons.lock),
            ),
            controller: Password,
          ),
          Padding(padding: EdgeInsets.all(20)),
          ElevatedButton.icon(
            onPressed: () async {
              bool response = await Service.register(Email.text, Password.text);
              if (response) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("SiGN UP SUCCESS"),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
            },
            icon: Icon(Icons.app_registration_rounded),
            label: Text("Register"),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? "),
              GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()))
                },
                child: Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.pink),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
