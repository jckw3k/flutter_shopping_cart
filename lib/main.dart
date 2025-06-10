import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> items = [
  {'name': 'Apple', 'image': 'images/apple.jpg', 'price': 1.50, 'quantity': 0},
  {
    'name': 'Banana',
    'image': 'images/banana.jpg',
    'price': 0.80,
    'quantity': 0,
  },
  {
    'name': 'Bluberry',
    'image': 'images/blueberry.jpg',
    'price': 2.00,
    'quantity': 0,
  },
  {
    'name': 'Durian',
    'image': 'images/durian.jpg',
    'price': 5.00,
    'quantity': 0,
  },
  {
    'name': 'Grapes',
    'image': 'images/grapes.jpg',
    'price': 2.50,
    'quantity': 0,
  },
  {'name': 'Mango', 'image': 'images/mango.jpg', 'price': 1.80, 'quantity': 0},
  {
    'name': 'Orange',
    'image': 'images/orange.jpg',
    'price': 1.20,
    'quantity': 0,
  },
  {'name': 'Peach', 'image': 'images/peach.jpg', 'price': 2.00, 'quantity': 0},
  {
    'name': 'Watermelon',
    'image': 'images/watermelon.jpg',
    'price': 4.00,
    'quantity': 0,
  },
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/trolley.jpg', height: 300),
              Text(
                "Der Shoppe",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text("Affordable prices everyday"),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrowsePage(cart: cart),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.amber, width: 1),
                  ),
                  child: Text('Shop Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BrowsePage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  const BrowsePage({super.key, required this.cart});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  void addToCart(Map<String, dynamic> item) {
    setState(() {
      final index = widget.cart.indexWhere(
        (cartItem) => cartItem['name'] == item['name'],
      );
      if (index != -1) {
        widget.cart[index]['quantity'] += 1;
      } else {
        widget.cart.add({...item, 'quantity': 1});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Good Morning, shopper',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      item['image'],
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "\$${item['price']}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton(
                                        onPressed:
                                            item['quantity'] > 0
                                                ? () {
                                                  setState(() {
                                                    item['quantity'] -= 1;
                                                    final index = widget.cart
                                                        .indexWhere(
                                                          (cartItem) =>
                                                              cartItem['name'] ==
                                                              item['name'],
                                                        );
                                                    if (index != -1) {
                                                      if (item['quantity'] ==
                                                          0) {
                                                        widget.cart.removeAt(
                                                          index,
                                                        );
                                                      } else {
                                                        widget.cart[index]['quantity'] =
                                                            item['quantity'];
                                                      }
                                                    }
                                                  });
                                                }
                                                : null,
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          foregroundColor: Colors.white,
                                          side: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(Icons.remove, size: 20),
                                      ),
                                      const SizedBox(width: 8),
                                      OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            addToCart(item);
                                            item['quantity'] += 1;
                                          });
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.lightGreen,
                                          foregroundColor: Colors.white,
                                          side: const BorderSide(
                                            color: Colors.lightGreen,
                                            width: 1,
                                          ),
                                        ),
                                        child: const Icon(Icons.add, size: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (item['quantity'] > 0)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${item['quantity']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cart: widget.cart),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(24),
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                elevation: 6,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart, size: 28),
                  SizedBox(width: 4),
                  Text("${widget.cart.length}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    double totalPrice = cart.fold(
      0,
      (sum, item) => sum + item['price'] * item['quantity'],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return ListTile(
                    leading: Image.asset(item['image'], width: 50, height: 50),
                    title: Text(item['name']),
                    subtitle: Text(
                      "Price: \$${item['price']} x ${item['quantity']}",
                    ),
                    trailing: Text(
                      "Total: \$${(item['price'] * item['quantity']).toStringAsFixed(2)}",
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total: \$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
