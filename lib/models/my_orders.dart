class Order{
  final int id;
  final int totalPoints;
  final String status;
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String email;
  final String state;
  final String city;
  final String zip;
  final List<OrderItem> items;
  final String orderDate;
  final String deliveredDate;
  final String deliveryPhone;
  Order({
    required this.id,
    required this.deliveryPhone,
    required this.totalPoints,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.email,
    required this.state,
    required this.city,
    required this.zip,
    required this.items,
    required this.orderDate,
    required this.deliveredDate,
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemJsonList = json['items'];
    return Order(
      id: json['id'],
      deliveryPhone:json['deliveryPhone']??'',
      totalPoints: json['totalPoints'],
      status: json['status'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address1: json['address1'],
      address2: json['address2'],
      email: json['email'],
      state: json['state'],
      city: json['city'],
      zip: json['zip'],
      items: itemJsonList.map((itemJson) => OrderItem.fromJson(itemJson)).toList(),
      orderDate: json['orderDate'],
      deliveredDate: json['deliveredDate'],
    );
  }
}
class OrderItem {
  final int productId;
  final String name;
  final String category;
  final int quantity;
  final int points;
  final int imageId;
  final String status;
  OrderItem({
    required this.productId,
    required this.name,
    required this.category,
    required this.quantity,
    required this.points,
    required this.imageId,
    required this.status,
  });
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      name: json['name'],
      category: json['category'],
      quantity: json['quantity'],
      points: json['points'],
      imageId: json['imageId'],
      status: json['status'],
    );
  }
}