import 'package:flutter/material.dart';
import 'package:flutter_firebase_projectnote/screens/login_screen.dart';
import 'package:flutter_firebase_projectnote/services/AuthService.dart';

class Burger extends StatelessWidget {
  const Burger({super.key, required String this.displayEmail});
  final String displayEmail;

  @override
  Widget build(BuildContext context) {
    final service = AuthService();
    String EmailUser = displayEmail;
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Wellcome"),
            accountEmail: Text("$EmailUser"),
            currentAccountPicture: CircleAvatar(
              child: FlutterLogo(
                size: 100.0,
              ),
              backgroundColor: Colors.pink,
            ),
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () => {
              service.logout(),
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false)
            },
          )
        ],
      ),
    );
  }
}
