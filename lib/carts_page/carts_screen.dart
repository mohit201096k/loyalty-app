
import 'package:pb_apps/carts_page/place_order.dart';
import 'package:pb_apps/widget/drawer.dart';
import 'package:pb_apps/widget/small_text.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api_url/api_url.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;
import '../provider/cart_provider.dart';
import '../widget/My_app_bar.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  CartScreenState createState() => CartScreenState();
}
class CartScreenState extends State<CartScreen> {
  var userId = 0;
  var totalpoints=0;
  var availablepoints=0;
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }
  Future<void> fetchCartItems() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    String? value = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}/api/v1/carts/me'),
      headers: {
        'Authorization': value.toString(),
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);
       totalpoints = responseData[0]['totalPoints']??0.toInt();
      availablepoints = responseData[0]["availablePoints"]??0.toInt();
      userId = responseData[0]["userId"] ?? 0;
      List<dynamic> cartData = responseData;
      if (cartData.isNotEmpty) {
        dynamic cart = cartData[0];
        List<dynamic> itemsData = cart['items'];
        List<CartItem> items =
            itemsData.map((item) => CartItem.fromJson(item)).toList();
        cartProvider.setCartItems(items);
      } else {
        cartProvider.setCartItems([]); // Empty cart
      }
    } else {
      ('Failed to fetch cart items');
    }
  }
  Future<void> removeFromCart(int itemId) async {
    String? value = await storage.read(key: 'token');
    final response = await http.delete(
      Uri.parse('${Constants.BASE_URL}/api/v1/carts/items/$itemId'),
      headers: {
        'Authorization': value.toString(),
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.removeFromCart(itemId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item removed from cart'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ('Failed to remove item from cart');
    }
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    bool isCartItemsEmpty = cartProvider.cartItems.isEmpty;
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: isCartItemsEmpty
            // cartProvider.cartItems.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        // const Image(image: AssetImage('images/empty_cart.png')),
                        const SizedBox(height: 20),
                        Text(
                          'Your cart is empty 😌',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Explore products and shop your\nfavorite items',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartProvider.cartItems[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 100,
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                    // get the image from api
                                    child: Image.network(
                                      "${Constants.BASE_URL}/api/v1/media/stream/${cartItem.imageId}",
                                      height: 70,
                                      width: 100,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.60,
                                    height: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                               SmallText(text:'Product Name',color: Colors.teal,),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Text(
                                                    cartItem.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(text: 'Product Id',color: Colors.teal,),
                                                Text(
                                                  "${cartItem.productId}",
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SmallText(text: 'Points',color: Colors.teal,),
                                                Text(
                                                  '${cartItem.point} Pts',
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children:  [SmallText(text: 'Quantity',color: Colors.teal,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 1),
                                                    child: SizedBox(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: [
                                                          IconButton(onPressed:(){
                                                            cartProvider.incrementQuantity(cartItem.productId);
                                                          },
                                                            icon: const Icon(Icons.add,size: 14,),
                                                          ),
                                                           Text( cartItem.quantity.toString(),),
                                                          IconButton(onPressed:(){
                                                            cartProvider.decrementQuantity(cartItem.productId);
                                                          },
                                                            icon: const Icon(Icons.remove,size: 14,),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,size: 20,
                                        color: Colors.teal,
                                      ),
                                      onPressed: () {
                                        removeFromCart(cartItem.productId);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60,bottom: 15),
            child: Row(
              children: [
                 Text('Detail  (${cartProvider.itemCount.toString()} items)',
                   style: const TextStyle(fontWeight: FontWeight.w700),),
              ],
            ),
          ),
          const Divider(thickness: 3.0),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              children: [
                SmallText(text: 'Available Points'),
                const SizedBox(width: 62,),
                SmallText(text:'$availablepoints pts')
              ],
            ),
          ),
          const Divider(thickness: 3.0),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              children: [
                SmallText(text: 'Total Cart Values'),
                const SizedBox(width: 55,),
                SmallText(text:'${cartProvider.totalpoints} pts')
              ],
            ),
          ),
          const Divider(thickness: 3.0), // Second divider
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              children: [
                SmallText(text: 'Remaining Points'),
                const SizedBox(width: 50,),
                SmallText(text: '${availablepoints-cartProvider.totalpoints} pts')
              ],
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            if(availablepoints>=cartProvider.totalpoints) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    Checkout(
                        totalPoints: cartProvider.totalpoints,
                        userId: userId,
                        items: cartProvider.cartItems
                    )),
              );
            }else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sorry you have not enough points to place order 😌'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.black,
                ),
              );
            }
          },
              child: SmallText(text: " Place Order",)
          ),
          const SizedBox(height: 40,),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
