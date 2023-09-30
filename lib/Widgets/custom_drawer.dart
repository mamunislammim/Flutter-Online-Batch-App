import 'package:flutter/material.dart';
import 'package:our_flutter_team/Common%20Files/app_colors.dart';
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
  final String? phn;
  final String? img;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.cyan.withOpacity(.8),
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
            decoration: BoxDecoration(
                color: Colors.cyanAccent.shade700.withOpacity(.88)),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 30,
            ),
            title: const Text(
              "Log Out",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 19),
            ),
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setString("uid", '');
              await prefs.setString("name", '');
              await prefs.setString("email", '');
              await prefs.setString("institute", '');
              await prefs.setString("phone", '');
              await prefs.setString("img", '');
              await prefs.setString('batchNumber', '');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
          ),
          const Spacer(),
          Card(
            color: Colors.cyan.withOpacity(.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.cyan.withOpacity(.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "About Us",
                          style: TextStyle(
                              color: Color(0xff80ffff),
                              fontWeight: FontWeight.w500,
                              fontSize: 19),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Developed by : ",
                  style: TextStyle(
                      color: Color(0xff33ffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
                Divider(),
                const Text(
                  "Md. Mamun Islam Mim: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Text(
                  "Software Developer",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                Text(
                  "eAppair Software Limited",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Designed by : ",
                  style: TextStyle(
                      color: Color(0xff33ffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
                const Divider(),
                const Text(
                  "Mursheda Urme ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Text(
                  "Student of Dinajpur Polytechnic Institute",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                Text(
                  "CSE, 4th Semester",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
