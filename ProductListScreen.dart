import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Product names
  List<String> products = [
    "Apple iPhone 13",
    "Samsung Galaxy S21",
    "Google Pixel 6",
    "Sony Headphones",
    "Dell XPS Laptop",
    "HP Spectre x360",
    "Nike Running Shoes",
    "Adidas Sports Shoes",
    "Apple AirPods",
    "Amazon Echo",
  ];

  // Stock levels for each product
  List<int> stockLevels = [
    10,
    15,
    8,
    20,
    5,
    7,
    30,
    25,
    12,
    18,
  ];

  List<String> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }


  void _filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = products;
      });
    } else {
      setState(() {
        filteredProducts = products
            .where((product) =>
            product.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }


  void _reduceStock(int index) {
    setState(() {
      if (stockLevels[index] > 0) {
        stockLevels[index]--; // Reduce stock by 1 after a transaction
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product List",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0083B0),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF00B4DB),
              Color(0xFF0083B0),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "Search Products...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
                onChanged: (value) {
                  _filterProducts(value);
                },
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {

                  int productIndex = products.indexOf(filteredProducts[index]);
                  return GestureDetector(
                    onTap: () => _reduceStock(productIndex),
                    child: _buildProductCard(filteredProducts[index], productIndex),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProductCard(String productName, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              const Icon(Icons.shopping_bag, size: 40, color: Colors.blueAccent),
              const SizedBox(width: 20),
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "Stock: ${stockLevels[index]}",
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
