
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const Color backgroundColor = Color(0xFF1C1C1C);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color cardColor = Color(0xFF2B2B2B);

  final List<Map<String, String>> pizzas = const [
    {
      'name': 'Margherita Pizza',
      'description': 'Classic tomato sauce, mozzarella cheese and fresh basil.',
      'price': 'RM 18.90',
      'image': 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600',
    },
    {
      'name': 'Pepperoni Pizza',
      'description': 'Loaded with pepperoni slices and melted mozzarella.',
      'price': 'RM 22.90',
      'image': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=600',
    },
    {
      'name': 'Hawaiian Pizza',
      'description': 'A delicious combination of chicken, pineapple and cheese.',
      'price': 'RM 24.90',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600',
    },
    {
      'name': 'BBQ Chicken Pizza',
      'description': 'Tender chicken, BBQ sauce, onions and mozzarella.',
      'price': 'RM 26.90',
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600',
    },
    {
      'name': 'Cheese Lover Pizza',
      'description': 'A cheesy delight with a blend of premium cheeses.',
      'price': 'RM 23.90',
      'image': 'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?w=600',
    },
    {
      'name': 'Veggie Delight Pizza',
      'description': 'Fresh vegetables, mushrooms, capsicum and mozzarella.',
      'price': 'RM 21.90',
      'image': 'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: accentColor,
        elevation: 0,
        title: const Text(
          'Our Menu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.local_pizza,
                    color: accentColor,
                    size: 55,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Explore Our Pizzas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hot. Fresh. MEGA!',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Our Pizza Collection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...pizzas.map((pizza) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: accentColor.withOpacity(0.5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(17),
                      ),
                      child: Image.network(
                        pizza['image']!,
                        height: 190,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 190,
                            width: double.infinity,
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.local_pizza,
                              size: 65,
                              color: accentColor,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pizza['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pizza['description']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pizza['price']!,
                                style: const TextStyle(
                                  color: accentColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.local_pizza,
                                color: accentColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
