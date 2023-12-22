//
// import 'package:flutter/material.dart';
// import '../models/cart.dart';
// class CartProvider extends ChangeNotifier {
//   List<CartItem> _cartItems = [];
//   List<CartItem> get cartItems => _cartItems;
//   int get itemCount => _cartItems.length;
//   int _totalpoints = 0;
//   int get totalpoints => _totalpoints;
//   int _quantity = 1;
//   int get quantity => _quantity;
//   int _points = 0;
//   int get points => _points;
//   void addToCart(CartItem cartItem) {
//     _cartItems.add(cartItem);
//     _updateValues();
//     notifyListeners();
//   }
//   void removeFromCart(int productId) {
//     _cartItems.removeWhere((cartItem) => cartItem.productId == productId);
//     _updateValues();
//     notifyListeners();
//   }
//   void setCartItems(List<CartItem> items) {
//     _cartItems = items;
//     _updateValues();
//     notifyListeners();
//   }
//   void clearCart() {
//     _cartItems.clear();
//     _updateValues();
//     notifyListeners();
//   }
//   void incrementQuantity(int productId) {
//     for (var cartItem in _cartItems) {
//       if (cartItem.productId == productId) {
//         cartItem.quantity++;
//         _updateValues();
//         notifyListeners();
//         break; // Exit the loop after finding the item
//       }
//     }
//   }
//   void decrementQuantity(int productId) {
//     for (var cartItem in _cartItems) {
//       if (cartItem.productId == productId) {
//         if (cartItem.quantity > 1) {
//           cartItem.quantity--;
//           _updateValues();
//           notifyListeners();
//         }
//         break; // Exit the loop after finding the item
//       }
//     }
//   }
//   void _updateValues() {
//     _totalpoints = 0;
//     _quantity = 1;
//     _points = 0;
//     for (var cartItem in _cartItems) {
//       _totalpoints += cartItem.totalpoints as int;
//       _quantity += cartItem.quantity;
//       _points += cartItem.points;
//     }
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart.dart';
class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  int get itemCount => _cartItems.length;
  int _totalpoints = 0;
  int get totalpoints => _totalpoints;
  int _quantity = 1;
  int get quantity => _quantity;
  int _points = 0;
  int get points => _points;
  SharedPreferences? _prefs;
  CartProvider() {
    _initPrefs();
  }
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final cartItemsJson = _prefs!.getString('cartItems');
    if (cartItemsJson != null) {
      final cartItemsList = CartItem.fromJsonList(cartItemsJson);
      _cartItems.addAll(cartItemsList);
      _updateValues();
      notifyListeners();
    }
  }
  Future<void> _saveCartItems() async {
    final cartItemsJson = CartItem.toJsonList(_cartItems);
    await _prefs!.setString('cartItems', cartItemsJson);
  }
  void addToCart(CartItem cartItem) {
    _cartItems.add(cartItem);
    _updateValues();
    notifyListeners();
    _saveCartItems();
  }
  void removeFromCart(int productId) {
    _cartItems.removeWhere((cartItem) => cartItem.productId == productId);
    _updateValues();
    notifyListeners();
    _saveCartItems();
  }
  void setCartItems(List<CartItem> items) {
    _cartItems = items;
    _updateValues();
    notifyListeners();
    _saveCartItems();
  }
  void clearCart() {
    _cartItems.clear();
    _updateValues();
    notifyListeners();
    // _saveCartItems();
  }
  void incrementQuantity(int productId) {
    for (var cartItem in _cartItems) {
      if (cartItem.productId == productId) {
        cartItem.quantity++;
        _updateValues();
        notifyListeners();
        _saveCartItems();
        break;
      }
    }
  }
  void decrementQuantity(int productId) {
    for (var cartItem in _cartItems) {
      if (cartItem.productId == productId) {
        if (cartItem.quantity > 1) {
          cartItem.quantity--;
          _updateValues();
          notifyListeners();
          _saveCartItems();
        }
        break;
      }
    }
  }
  void _updateValues() {
    _totalpoints = 0;
    _quantity = 0;
    _points = 0;
    for (var cartItem in _cartItems) {
      _totalpoints += cartItem.totalPoints;
      _quantity += cartItem.quantity;
      _points += cartItem.points;
    }
  }
}
