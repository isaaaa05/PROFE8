import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

// COMPONENT 1: Shopping cart using Provider
// COMPONENT 2: ChangeNotifier to update UI when data changes
class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  // COMPONENT 1: Add items to cart
  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.id == item.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }

    // COMPONENT 2: Notify listeners to update UI
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    // COMPONENT 2: Notify listeners to update UI
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (quantity > 0) {
        _items[index].quantity = quantity;
      } else {
        _items.removeAt(index);
      }
      // COMPONENT 2: Notify listeners to update UI
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    // COMPONENT 2: Notify listeners to update UI
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    // COMPONENT 2: Notify listeners to update UI
    notifyListeners();
  }
}
