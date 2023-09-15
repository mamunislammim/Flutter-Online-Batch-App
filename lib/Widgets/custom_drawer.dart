import 'package:flutter/material.dart';
import 'package:our_flutter_team/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(
      {Key? key,
        required this.name,
        required this.phn,
        required this.img,
        required this.email})
      : super(key: key);
 final String? name;
 final String? email;
final  String? phn;
 final String? img;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.cyan.withOpacity(.7),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(img.toString()),
            ),
            accountEmail: Text(email.toString()),
            accountName: Text(
              name.toString(),
              style: const TextStyle(fontSize: 24.0),
            ),
            decoration:   BoxDecoration(
              color: Colors.cyanAccent.shade700.withOpacity(.88)
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout,size: 30,),
            title:  const Text(
              "Log Out",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 19),
            ),
            onTap: () async{
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("uid", '');
              prefs.setString("name", '');
              prefs.setString("email", '');
              prefs.setString("institute", '');
              prefs.setString("phone", '');
              prefs.setString("img",'');
              prefs.setString('batchNumber', '');
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context)=> const LoginScreen()),
                      (route) => false);
            },
          ),
          Spacer(),
          Card(
          color :  Colors.cyan.withOpacity(.7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Md. Mamun Islam Mim",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 19),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Software Developer",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const Text(
                    "eAppair Software Limited",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}