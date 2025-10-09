import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/cart_provider.dart';
import '../models/reservation.dart';
import 'payment_screen.dart';

// COMPONENT 1: Shopping cart app that can add items using Provider
// COMPONENT 3: Demonstrates context.read() and context.watch()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // COMPONENT 3: Using context.watch() to rebuild when cart changes
    final cartProvider = context.watch<CartProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : null,
          ),
        ),
      ),
      body: cartProvider.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // COMPONENT 13: Material Icons with dynamic size
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: isDark ? Colors.white38 : Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: isDark ? const Color(0xFFE0E0E0) : Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                        child: ListTile(
                          leading: item.imageUrl != null
                              // COMPONENT 7: Display image from internet
                              ? Image.network(
                                  item.imageUrl!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.confirmation_number,
                                  color: isDark ? const Color(0xFF64B5F6) : Colors.black87,
                                ),
                          title: Text(
                            item.name,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            '₱${item.price.toStringAsFixed(2)} x ${item.quantity}',
                            style: GoogleFonts.poppins(
                              color: isDark ? const Color(0xFFE0E0E0) : Colors.black87,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // COMPONENT 13: Material Icons with dynamic color
                              IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () {
                                  // COMPONENT 3: Using context.read() for one-time action
                                  context.read<CartProvider>().updateQuantity(
                                        item.id,
                                        item.quantity - 1,
                                      );
                                },
                              ),
                              Text(
                                '${item.quantity}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              // COMPONENT 13: Material Icons with dynamic color
                              IconButton(
                                icon: const Icon(Icons.add_circle, color: Colors.green),
                                onPressed: () {
                                  // COMPONENT 3: Using context.read() for one-time action
                                  context.read<CartProvider>().updateQuantity(
                                        item.id,
                                        item.quantity + 1,
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            '₱${cartProvider.totalAmount.toStringAsFixed(2)}',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF64B5F6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Create a reservation from cart items
                            final reservation = Reservation(
                              username: 'Cart User',
                              eventName: 'Multiple Events',
                              eventType: 'Mixed',
                              ticketCount: cartProvider.items.fold(
                                0,
                                (sum, item) => sum + item.quantity,
                              ),
                              date: DateTime.now().add(const Duration(days: 7)),
                              time: const TimeOfDay(hour: 19, minute: 0),
                              receiveNotifications: true,
                            );
                            
                            // Navigate to payment screen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  reservation: reservation,
                                  onPaymentSuccess: () {
                                    context.read<CartProvider>().clearCart();
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Proceed to Checkout',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
