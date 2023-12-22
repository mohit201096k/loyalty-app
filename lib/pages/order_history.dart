// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:pb_apps/api_url/api_url.dart';
// import 'package:pb_apps/widget/My_app_bar.dart';
// import 'package:pb_apps/widget/drawer.dart';
// import 'package:http/http.dart'as http;
// import '../models/my_orders.dart';
// import '../widget/Big_text.dart';
// import 'order_detail.dart';
// class OrderHistory extends StatefulWidget {
//   const OrderHistory({Key? key}) : super(key: key);
//   @override
//   State<OrderHistory> createState() => _OrderHistoryState();
// }
// class _OrderHistoryState extends State<OrderHistory> {
//   List<Order> orders = []; // Create a list to hold the fetched orders
//   final storage= const FlutterSecureStorage();
//   @override
//   void initState() {
//     super.initState();
//     fetchOrders().then((fetchedOrders) {
//       setState(() {
//         orders = fetchedOrders;
//       });
//     });
//   }
//   Future<List<Order>> fetchOrders() async {
//     String? value = await storage.read(key: 'token');
//     final response = await http.get(
//       Uri.parse('${Constants.BASE_URL}/api/v1/orders/me'),
//       headers: {
//         'Authorization': value.toString(),
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       return jsonList.map((json) => Order.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load orders');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MyAppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: orders.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                  itemCount: orders.length,
//                   itemBuilder: (context, index) {
//                   final order = orders[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               BigText(
//                                 text: 'OrderId:',
//                                 color: Colors.teal,
//                               ),
//                               Text('${order.id}'),
//                               const SizedBox(
//                                 width: 40,
//                               ),
//                               BigText(
//                                 text: 'OrderDate:',
//                                 color: Colors.teal,
//                               ),
//                               Text(order.orderDate)
//                             ],
//                           ),
//                           const SizedBox(height: 20,),
//                           Row(
//                             children: [
//
//                               BigText(
//                                 text: 'Status:',
//                                 color: Colors.teal,
//                               ),
//                               Text(order.status),
//                               const SizedBox(
//                                 width: 30,
//                               ),
//                               BigText(
//                                 text: 'DeliveryDate:',
//                                 color: Colors.teal,
//                               ),
//                               Text(order.deliveredDate)
//                             ],
//                           ),
//                           const SizedBox(height: 10,),
//                           Row(
//                             children: [
//                               BigText(
//                                 text: 'RedeemPoints:',
//                                 color: Colors.teal,
//                               ),
//                               Text('${order.totalPoints} pts'),
//                               const SizedBox(width: 90,),
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           OrderDetail(order: order),
//                                     ),
//                                   );
//                                 },
//                                 icon: Icon(
//                                   Icons.info,
//                                   color: Colors.blue.shade800,
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       drawer: const MyDrawer(),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pb_apps/api_url/api_url.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:pb_apps/widget/small_text.dart';
import '../models/my_orders.dart';
import '../widget/Big_text.dart';
import 'order_detail.dart';
class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}
class _OrderHistoryState extends State<OrderHistory> {
  List<Order> orders = [];
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchOrders().then((fetchedOrders) {
      setState(() {
        orders = fetchedOrders;
      });
    });
  }
  Future<List<Order>> fetchOrders() async {
    String? value = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}/api/v1/orders/me'),
      headers: {
        'Authorization': value.toString(),
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: orders.isEmpty
                ?  Center(
              child: Column(
                children: [
                  // const Image(image: AssetImage('images/empty_cart.png')),
                  const SizedBox(height: 20),
                  Text(
                    'You have no order placed yet 📦',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Placed order and show order detail Here \n now you have found empty data!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),)
                : ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: order.items.map((item) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            BigText(
                                              text: 'OrderId : ',
                                              color: Colors.teal,
                                            ),
                                            Text('${order.id}'),
                                            const SizedBox(
                                              width: 50,
                                            ),
                                            BigText(
                                              text: 'Date : ',
                                              color: Colors.teal,
                                            ),
                                            Text(order.orderDate)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.network(
                                              '${Constants.BASE_URL}/api/v1/media/stream/${item.imageId}',
                                              height: 70,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,top: 20),
                                                    child: SmallText(
                                                      text: item.name,
                                                      color: Colors.teal,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // maxLines: 1, // Limit to one line
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                   height: 5,
                                                  ),
                                                  Text(
                                                      'Status : ${item.status}'),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      'Points : ${item.points} pts'),
                                                  Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                OrderDetail(
                                                                    order: order,
                                                                ),
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.info,
                                                        color:
                                                            Colors.blue.shade800,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                  ).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
