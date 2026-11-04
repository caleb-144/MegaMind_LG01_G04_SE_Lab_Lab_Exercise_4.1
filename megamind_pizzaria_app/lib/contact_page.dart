import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors pulled directly from your HomePage design
    const bgColor = Color(0xFF1B1B1B);
    const accentColor = Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.black26, 
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white12, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.email, color: accentColor),
                title: Text('Email', style: TextStyle(color: Colors.white)),
                subtitle: Text('contact@megamind.com', style: TextStyle(color: Colors.white70)),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.black26,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white12, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.phone, color: accentColor),
                title: Text('Phone', style: TextStyle(color: Colors.white)),
                subtitle: Text('+60 10-1234567', style: TextStyle(color: Colors.white70)),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.black26,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white12, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.location_on, color: accentColor),
                title: Text('Address', style: TextStyle(color: Colors.white)),
                subtitle: Text('Universiti Malaysia Sarawak (UNIMAS)\nKota Samarahan, Sarawak', style: TextStyle(color: Colors.white70)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}