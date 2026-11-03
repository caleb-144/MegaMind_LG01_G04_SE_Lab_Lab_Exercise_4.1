import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF1B1B1B), // fallback if the image is missing
          image: DecorationImage(
            image: AssetImage('assets/images/hero_pizza.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_pizza,
                    size: 80, color: Color(0xFFFFC107)),
                const SizedBox(height: 12),
                const Text(
                  'MegaMind Pizzaria',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hot. Fresh. MEGA!',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFFFC107),
                  ),
                ),
                const SizedBox(height: 48),
                _NavButton(label: 'Menu', icon: Icons.restaurant_menu, route: '/menu'),
                const SizedBox(height: 16),
                _NavButton(label: 'About Us', icon: Icons.info_outline, route: '/about'),
                const SizedBox(height: 16),
                _NavButton(label: 'Contact', icon: Icons.phone, route: '/contact'),
                const SizedBox(height: 48),
                const Text('Follow us',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Twitter / X',
                      iconSize: 32,
                      color: Colors.white,
                      icon: const FaIcon(FontAwesomeIcons.xTwitter),
                      onPressed: () => Navigator.pushNamed(context, '/twitter'),
                    ),
                    const SizedBox(width: 24),
                    IconButton(
                      tooltip: 'Facebook',
                      iconSize: 32,
                      color: const Color(0xFF4A90FF),
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () => Navigator.pushNamed(context, '/facebook'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 52,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFFFC107), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        onPressed: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}