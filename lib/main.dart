import 'package:flutter/material.dart';
import 'package:resep_mobile/screens/detail_screen.dart';
import 'package:resep_mobile/screens/editProfil_screen.dart';
import 'package:resep_mobile/screens/home_page.dart';
import 'package:resep_mobile/screens/listResep_screen.dart';
import 'package:resep_mobile/screens/login_screen.dart';
import 'package:resep_mobile/screens/profil_screen.dart';
import 'package:resep_mobile/screens/registration_screen.dart';
import 'package:resep_mobile/screens/settingProfil_screen.dart';
import 'package:resep_mobile/screens/splash_screen.dart';
import 'package:resep_mobile/screens/supportProfil_screen.dart';
import 'package:resep_mobile/model/resep_model.dart';

void main() {
  runApp(const ResepinApp());
}

class ResepinApp extends StatelessWidget {
  const ResepinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (context) => SplashScreen());
          case '/home':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/listResep':
            return MaterialPageRoute(builder: (context) => ListResepPage());
          case '/detail':
            final args = settings.arguments as MenuMakanan;
            return MaterialPageRoute(
              builder: (context) => DetailResepPage(resep: args),
            );
          case '/profile':
            return MaterialPageRoute(builder: (context) => ProfilePage());
          case '/editProfile':
            return MaterialPageRoute(builder: (context) => EditProfilePage());
          case '/registration':
            return MaterialPageRoute(
                builder: (context) => RegistrationScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/settings':
            return MaterialPageRoute(builder: (context) => SettingPage());
          case '/support':
            return MaterialPageRoute(builder: (context) => SupportPage());
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Center(child: Text('Halaman tidak ditemukan')),
              ),
            );
        }
      },
    );
  }
}
