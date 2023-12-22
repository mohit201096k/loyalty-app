
import 'dart:convert';
class Cart {
  final int id;
  final int userId;
  int totalPoints;
  int availablePoints;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.userId,
    required this.totalPoints,
    required this.availablePoints,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemData = json['items'];
    final List<CartItem> cartItems = itemData.map((itemJson) {
      return CartItem.fromJson(itemJson);
    }).toList();
    return Cart(
      id: json['id'],
      userId: json['userId'],
      totalPoints: json['totalPoints'],
      availablePoints: json['availablePoints'],
      items: cartItems,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'totalPoints': totalPoints,
      'availablePoints': availablePoints,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItem {
  final int productId;
  final String name;
  final String category;
  int quantity;
  int points;
  final int imageId;

  CartItem({
    required this.productId,
    required this.name,
    required this.category,
    required this.quantity,
    required this.points,
    required this.imageId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      name: json['name'],
      category: json['category'],
      quantity: json['quantity'],
      points: json['points'],
      imageId: json['imageId'],
    );
  }

  int get totalPoints => points * quantity;
  int get point => (points)*quantity;

  // Convert CartItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'category': category,
      'quantity': quantity,
      'points': (points)*quantity,
      'imageId': imageId,
    };
  }

  static String toJsonList(List<CartItem> items) {
    final List<Map<String, dynamic>> itemList = items.map((item) => item.toJson()).toList();
    return jsonEncode(itemList);
  }


  static List<CartItem> fromJsonList(String json) {
    final List<dynamic> itemList = jsonDecode(json);
    return itemList.map((itemJson) => CartItem.fromJson(itemJson)).toList();
  }
}
