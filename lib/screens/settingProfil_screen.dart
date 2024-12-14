import 'package:flutter/material.dart';
import 'package:resep_mobile/const.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text(
          "Pengaturan",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.white), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SettingTile(
              title: 'Akun',
              icon: Icons.account_circle,
              onTap: () {
              },
            ),
            const Divider(),
            SettingTile(
              title: 'Bahasa',
              icon: Icons.language,
              onTap: () {
              },
            ),
            const Divider(),
            SettingTile(
              title: 'Undang Teman',
              icon: Icons.person_add,
              onTap: () {
              },
            ),
            const Divider(),
            SettingTile(
              title: 'Keluar',
              icon: Icons.exit_to_app,
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color:
              kBackgroundColor, 
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onTap: onTap,
      ),
    );
  }
}
