import 'package:app_ecommerc/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_ecommerc/providers/cart_provider.dart';
import 'package:app_ecommerc/pages/checkout_page.dart';

// import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartItems.isEmpty) {
            return const Center(child: Text('Keranjang Anda kosong.'));
          }
          final List<Product> products = cartProvider.cartItems.keys.toList();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final quantity = cartProvider.cartItems[product]!;
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                        'Rp ${(product.price * quantity).toStringAsFixed(2)}',
                      ),
                      trailing: Row(
                        mainAxisSize:
                            MainAxisSize.min, // penting agar row tidak melebar
                        children: [
                          IconButton(
                            onPressed: () {
                              cartProvider.decrementQuantity(product);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text('$quantity', style: TextStyle(fontSize: 16)),
                          IconButton(
                            onPressed: () {
                              cartProvider.incrementQuantity(product);
                            },
                            icon: Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              cartProvider.removeProduct(product);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp ${cartProvider.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            //nonaktifkanloading
                            setState(() {
                              _isLoading = true; // aktifkan loading
                            });

                            // simulasi proses checkout
                            await Future.delayed(const Duration(seconds: 2));

                            setState(() {
                              _isLoading = false; // matikan loading
                            });

                            // navigasi ke halaman checkout
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  totalPrice: cartProvider.totalPrice,
                                ),
                              ),
                            );
                          },
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.deepPurple)
                        : Text("Checkout"),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
