
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pb_apps/Detail/product_detail_dialog.dart';
import 'package:pb_apps/api_url/api_url.dart';
import 'package:pb_apps/carts_page/carts_screen.dart';
import 'package:pb_apps/widget/Big_text.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/cart_provider.dart';
class RedeemRewards extends StatefulWidget {
  const RedeemRewards({Key? key}) : super(key: key);
  @override
  State<RedeemRewards> createState() => _RedeemRewardsState();
}
class _RedeemRewardsState extends State<RedeemRewards> {
  late Future<List<Product>> productFuture;
  final storage = const FlutterSecureStorage();
  List<Product> productList = [];
  String? selectedCategory;
  @override
  void initState() {
    super.initState();
    productFuture = fetchProducts();
  }
  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }
  Future<List<Product>> fetchProducts() async {
    String? value = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}/api/v1/products?pageNo=0&pageSize=100'),
      headers: {
        'Authorization': value.toString(),
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      productList = jsonData.map((json) => Product.fromJson(json)).toList();
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  }
  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close,color: Colors.teal,),
                ),
              ),
              Center(child: BigText(text: 'Filter By Category Name', color: Colors.teal)),
              const Divider(thickness: 1,),
              ListTile(
                title: const Text('All'),
                onTap: () {
                  setState(() {
                    selectedCategory = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
              // ListView.builder(
              //     itemCount: productList.length,
              //     itemBuilder: ( context,  index) {
              //       final product=productList[index];
              //       return  ListTile(
              //         title:  Text(product.productCategoryName),
              //             onTap: () {
              //               setState(() {
              //                 selectedCategory = product.productCategoryName;
              //               });
              //               Navigator.of(context).pop();
              //             },
              //       );
              //     }
              // ),
              const Divider(thickness: 1,),
              ListTile(
                title: const Text('Vouchers'),
                onTap: () {
                  setState(() {
                    selectedCategory = 'Vouchers';
                  });
                  Navigator.of(context).pop();
                },
              ),
              const Divider(thickness: 1,),
              ListTile(
                title: const Text('Donations'),
                onTap: () {
                  setState(() {
                    selectedCategory = 'Donations';
                  });
                  Navigator.of(context).pop();
                },
              ),
              const Divider(thickness: 1,),
              ListTile(
                title: const Text('Physical Rewards'),
                onTap: () {
                  setState(() {
                    selectedCategory = 'Physical Rewards';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
     @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showFilterDialog(context);
                      },
                      icon:
                       Icon(
                        Icons.tune,
                        color: Colors.grey[500],
                      ),
                    ),
                   Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        AppLocalizations.of(context)!.filter,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const VerticalDivider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        showSortDialog(context);
                      },
                      icon: Icon(
                        Icons.swap_vert,
                        color: Colors.grey[500],
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        AppLocalizations.of(context)!.sort,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const VerticalDivider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute
                          (builder: (context)=>const CartScreen())
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.grey[500],
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        AppLocalizations.of(context)!.cart,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        int itemCount = cartProvider.itemCount;
                        return Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            itemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<List<Product>>(
              future: productFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final filteredProducts = selectedCategory == null
                      ? productList
                      : productList.where((product) =>
                  product.productCategoryName == selectedCategory).toList();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      mainAxisExtent: 220,
                    ),
                    // itemCount: productList.length,
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      // final product = productList[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 80,
                              width: 120,
                              color: Colors.white,
                              child: GestureDetector(
                                onTap: () {
                                  _showProductDetailsDialog(product);
                                },
                                child: Image.network(
                                  '${Constants
                                      .BASE_URL}/api/v1/media/stream/${product
                                      .media.id}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Product ID: ${product.id}",
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          Text(
                            "Pts: ${product.points}",
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                const storage = FlutterSecureStorage();
                                String? value =
                                await storage.read(key: 'token');
                                final response = await http.post(
                                  Uri.parse(
                                      '${Constants
                                          .BASE_URL}/api/v1/carts/items'),
                                  headers: {
                                    'Authorization': value.toString(),
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode({
                                    'points': product.points,
                                    'productId': product.id,
                                    'product name': product.name,
                                    'quantity': 1,
                                  }),
                                );
                                if (response.statusCode == 200) {
                                  showSnackbar('Item added to cart');
                                  CartItem cartItem = CartItem(
                                    productId: product.id,
                                    name: product.name,
                                    category: '',
                                    quantity: 1,
                                    points: product.points,
                                    imageId: product.media.id,
                                  );
                                  Provider.of<CartProvider>(context,
                                      listen: false)
                                      .addToCart(cartItem);
                                } else {
                                  showSnackbar('Failed to add item to cart');
                                }
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.addToCart)),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

  Future<void> _showProductDetailsDialog(Product product) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductDetailDialog(product: product);
      },
    );
  }
  void showSortDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.teal,
                    ),
                  ),
                ),
                Center(child: BigText(text: 'Sort by',color: Colors.teal,)),
                const Divider(thickness: 2,),
                ListTile(
                  title: const Text('Points - High to Low'),
                  onTap: () {
                    productList.sort((a, b) =>
                        (b.points).compareTo((a.points)));
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
                const Divider(thickness: 2,),
                ListTile(
                  title: const Text('Points - Low to High'),
                  onTap: () {
                    productList.sort((a, b) =>
                        (a.points).compareTo((b.points)));
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
