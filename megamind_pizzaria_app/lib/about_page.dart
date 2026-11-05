
import 'package:flutter/material.dart';

void main() {
  runApp(const MegaMindApp());
}

class MegaMindApp extends StatelessWidget {
  const MegaMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutPage(),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
    this.onViewMenu,
    this.onContactUs,
  });

  final VoidCallback? onViewMenu;
  final VoidCallback? onContactUs;

  static const Color backgroundColor = Color(0xFF1C1C1C);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color cardColor = Color(0xFF2B2B2B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: accentColor,
        elevation: 0,
        title: const Text(
          'About MegaMind',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 21,
          vertical: 20,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Icon(
              Icons.local_pizza,
              color: accentColor,
              size: 75,
            ),

            const SizedBox(height: 22),

            const Text(
              'Crafting Perfection, One Slice at a Time',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Hot. Fresh. MEGA!',
              style: TextStyle(
                color: accentColor,
                fontSize: 19,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 40),

            _buildInfoCard(
              icon: Icons.history,
              title: 'Our Story',
              description:
                  'Founded right here in Sarawak, MegaMind Pizzaria '
                  'was born out of a passion for bold flavors, '
                  'handcrafted dough and premium ingredients. '
                  'We believe that great pizza brings people '
                  'together and we strive to make every bite '
                  'an unforgettable experience.',
            ),

            const SizedBox(height: 18),

            _buildInfoCard(
              icon: Icons.verified,
              title: 'The MegaMind Quality',
              description:
                  'We use 100% real mozzarella, locally-sourced '
                  'farm-fresh vegetables and signature house-made '
                  'tomato sauces. Every pizza is baked to order '
                  'in our high-heat ovens to ensure the perfect '
                  'crispy crust and gooey finish.',
            ),

            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.restaurant_menu,
                    label: 'View Menu',
                    onPressed: onViewMenu,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: _buildActionButton(
                    icon: Icons.phone,
                    label: 'Contact Us',
                    onPressed: onContactUs,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          Colors.black.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: accentColor,
                size: 25,
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,

      icon: Icon(
        icon,
        color: accentColor,
        size: 19,
      ),

      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),

      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: accentColor,
          width: 2,
        ),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 8,
        ),
      ),
    );
  }
}
