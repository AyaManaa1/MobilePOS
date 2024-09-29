import 'package:flutter/material.dart';

class SalesHistoryScreen extends StatelessWidget {
  const SalesHistoryScreen({super.key});


  final List<Map<String, dynamic>> salesHistory = const [
    {
      "date": "2024-09-25",
      "total": 245.00,
      "items": [
        {"name": "Item 1", "quantity": 2, "price": 50.0},
        {"name": "Item 2", "quantity": 1, "price": 145.0},
      ],
    },
    {
      "date": "2024-09-22",
      "total": 180.00,
      "items": [
        {"name": "Item 3", "quantity": 1, "price": 60.0},
        {"name": "Item 4", "quantity": 3, "price": 40.0},
      ],
    },
    {
      "date": "2024-09-20",
      "total": 320.00,
      "items": [
        {"name": "Item 5", "quantity": 4, "price": 80.0},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sales History",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0083B0),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Past Sales Transactions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: salesHistory.length,
                itemBuilder: (context, index) {
                  final sale = salesHistory[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ExpansionTile(
                      title: Text(
                        "Date: ${sale['date']}  -  Total: \$${sale['total'].toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sale["items"].length,
                          itemBuilder: (context, itemIndex) {
                            final item = sale["items"][itemIndex];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(item["quantity"].toString()),
                              ),
                              title: Text(item["name"]),
                              subtitle: Text(
                                  "\$${(item["price"] * item["quantity"]).toStringAsFixed(2)}"),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
