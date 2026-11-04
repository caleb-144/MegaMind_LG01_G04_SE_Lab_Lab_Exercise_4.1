import 'package:flutter/material.dart';
import 'home_page.dart';
import 'contact_page.dart';
import 'facebook_page.dart';
import 'about_page.dart';
import 'menu_page.dart';

void main() => runApp(const MegaMindPizzaApp());

class MegaMindPizzaApp extends StatelessWidget {
  const MegaMindPizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MegaMind Pizzaria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD32F2F)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/menu': (context) => const MenuPage(),
        '/about': (context) => const AboutPage(),
        '/contact': (context) => const ContactPage(),
        '/twitter': (context) => const _Placeholder('Twitter/X'),
        '/facebook': (context) => const FacebookPage(),
      },
    );
  }
}

// Temporary stand-in; replace with teammates' pages after merging.
class _Placeholder extends StatelessWidget {
  const _Placeholder(this.title);
  final String title;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(title)), body: Center(child: Text(title)));
}