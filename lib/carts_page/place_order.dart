
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pb_apps/carts_page/order_placed_successfully.dart';
import 'package:pb_apps/widget/drawer.dart';
import '../api_url/api_url.dart';
import '../models/cart.dart';
import '../models/user_detail.dart';
import '../widget/Big_text.dart';
import '../widget/My_app_bar.dart';
class Checkout extends StatefulWidget {
  final int totalPoints;
  final int userId;
  final List<CartItem> items;
  const Checkout({Key? key,  required this.totalPoints, required this.items,required this.userId, }) : super(key: key);
  @override
  State<Checkout> createState() => CheckoutState();
}
class CheckoutState extends State<Checkout> {
  Details? userDetail;
  bool sameAddress = false;
  TextEditingController shippingFirstNameController = TextEditingController();
  TextEditingController shippingLastNameController = TextEditingController();
  TextEditingController shippingAddress1Controller = TextEditingController();
  TextEditingController shippingAddress2Controller = TextEditingController();
  TextEditingController shippingCityController = TextEditingController();
  TextEditingController shippingStateController = TextEditingController();
  TextEditingController shippingPinController = TextEditingController();
  TextEditingController shippingUsernameController = TextEditingController();
  TextEditingController shippingEmailController = TextEditingController();
  // billing address controller
  TextEditingController billingFirstNameController = TextEditingController();
  TextEditingController billingLastNameController = TextEditingController();
  TextEditingController billingAddress1Controller = TextEditingController();
  TextEditingController billingAddress2Controller = TextEditingController();
  TextEditingController billingCityController = TextEditingController();
  TextEditingController billingStateController = TextEditingController();
  TextEditingController billingPinController = TextEditingController();
  TextEditingController billingPhoneController = TextEditingController();
  TextEditingController billingEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchDetail();
  }
  Future<void> fetchDetail() async {
    String? value = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}/api/v1/users/me'),
      headers: {
        'Authorization': value.toString(),
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<dynamic> details = jsonData['details'];
       userDetail = Details.fromJson(details[0]);
      setShippingAddressValues(userDetail);
      setState(() {
      });
    } else {
      throw Exception('Failed to fetch user details');
    }
  }
  void setShippingAddressValues(Details? userDetail) {
    if (userDetail != null) {
      shippingFirstNameController.text = userDetail.firstName;
      shippingLastNameController.text = userDetail.lastName;
      shippingEmailController.text = userDetail.email;
      shippingUsernameController.text=userDetail.username;
    }
    else{
      shippingFirstNameController.text = '';
      shippingLastNameController.text = '';
      shippingEmailController.text = '';
      shippingUsernameController.text='';
    }
  }
  // void setShippingAddressValues(Detail? userDetail) {
  //   if (userDetail != null) {
  //     if (!sameAddress) {
  //       shippingFirstNameController.text = userDetail.firstName;
  //       shippingLastNameController.text = userDetail.lastName;
  //       shippingEmailController.text = userDetail.email;
  //       shippingUsernameController.text = userDetail.username;
  //     }
  //     // Billing address fields will be updated based on sameAddress flag
  //   } else {
  //     shippingFirstNameController.text = '';
  //     shippingLastNameController.text = '';
  //     shippingEmailController.text = '';
  //     shippingUsernameController.text = '';
  //   }
  // }

  void toggleSameAddress(bool value) {
    setState(() {
      sameAddress = value;
      if (sameAddress) {
        // Copy shipping address to billing address fields
        billingFirstNameController.text = shippingFirstNameController.text;
        billingLastNameController.text = shippingLastNameController.text;
        billingAddress1Controller.text = shippingAddress1Controller.text;
        billingAddress2Controller.text = shippingAddress2Controller.text;
        billingCityController.text = shippingCityController.text;
        billingStateController.text = shippingStateController.text;
        billingPinController.text = shippingPinController.text;
        billingPhoneController.text = shippingUsernameController.text;
        billingEmailController.text = shippingEmailController.text;
      } else {
        // Clear billing address fields
        billingFirstNameController.text = '';
        billingLastNameController.text = '';
        billingAddress1Controller.text = '';
        billingAddress2Controller.text = '';
        billingCityController.text = '';
        billingStateController.text = '';
        billingPinController.text = '';
        billingPhoneController.text = '';
        billingEmailController.text = '';
      }
    });
  }
  void saveForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> payload = {
        'firstName': shippingFirstNameController.text,
        'lastName': shippingLastNameController.text,
        'email': shippingEmailController.text,
        'city': shippingCityController.text,
        'state': shippingStateController.text,
        'zip': shippingPinController.text,
        'phone': shippingUsernameController.text,
        'address1': shippingAddress1Controller.text,
        'address2': shippingAddress2Controller.text,
        'totalPoints': widget.totalPoints,
        'userId': widget.userId,
        'billingAddress': {
          'firstName': billingFirstNameController.text,
          'lastName': billingLastNameController.text,
          'city': billingCityController.text,
          'state': billingStateController.text,
          'zip': billingPinController.text,
          'phone': shippingUsernameController.text,
          'address1': billingAddress1Controller.text,
          'address2': billingAddress2Controller.text,
        },
        'items': widget.items.map((item) => item.toJson()).toList(),
      };
      // Map<String, dynamic> payload = {
      //   'firstName': sameAddress ? shippingFirstNameController.text : userDetail?.firstName??'',
      //   'lastName': sameAddress ? shippingLastNameController.text : userDetail?.lastName??'',
      //   'email': sameAddress ? shippingEmailController.text : userDetail?.email,
      //   'city': shippingCityController.text,
      //   'state': shippingStateController.text,
      //   'zip': shippingPinController.text,
      //   'phone': sameAddress ? shippingUsernameController.text : userDetail?.username??'',
      //   'address1': shippingAddress1Controller.text,
      //   'address2': shippingAddress2Controller.text,
      //   'totalPoints': widget.totalPoints,
      //   'userId': widget.userId,
      //   'billingAddress': {
      //     'firstName': sameAddress ? shippingFirstNameController.text : billingFirstNameController.text,
      //     'lastName': sameAddress ? shippingLastNameController.text : billingLastNameController.text,
      //     'city': sameAddress ? shippingCityController.text : billingCityController.text,
      //     'state': sameAddress ? shippingStateController.text : billingStateController.text,
      //     'zip': sameAddress ? shippingPinController.text : billingPinController.text,
      //     'phone': sameAddress ? shippingUsernameController.text : billingPhoneController.text,
      //     'address1': sameAddress ? shippingAddress1Controller.text : billingAddress1Controller.text,
      //     'address2': sameAddress ? shippingAddress2Controller.text : billingAddress2Controller.text,
      //   },
      //   'items': widget.items.map((item) => item.toJson()).toList(),
      // };

      const storage =  FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      final response = await http.post(
        Uri.parse('${Constants.BASE_URL}/api/v1/orders'),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        // final cartProvider = Provider.of<CartProvider>(context, listen: false);
        final jsonData = jsonDecode(response.body);
        int orderId = jsonData['id'];
        Navigator.push(
            context, MaterialPageRoute(
            builder: (context)=>const OrderPlacedSuccessfully()));
        // cartProvider.clearCart();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to place the order. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(right: 70, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Payment: Shipping Address',style: TextStyle(color: Colors.teal),),
                    const Divider(
                      thickness: 1,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      controller: shippingFirstNameController,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      controller: shippingLastNameController,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Address 1',
                      ),
                      controller: shippingAddress1Controller,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter address 1';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Address 2',
                      ),
                      controller: shippingAddress2Controller,
                      enabled: true,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'City',
                      ),
                      controller: shippingCityController,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'State',
                      ),
                      controller: shippingStateController,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your state';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6)
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Pin',
                      ),
                      controller: shippingPinController,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your pin code';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                      controller: shippingUsernameController,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      controller: shippingEmailController,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BigText(text: 'Billing Address',color: Colors.teal,),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 40,
                          child: Switch(
                            value: sameAddress,
                            onChanged: toggleSameAddress,
                          ),
                        ),
                        BigText(
                          text: 'Same as shipping address',
                        ),
                      ],
                    ),
                    if (!sameAddress) ...[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                        controller: billingFirstNameController,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                        ),
                        controller: billingLastNameController,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Address 1',
                        ),
                        controller: billingAddress1Controller,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter address 1';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Address 2',
                        ),
                        controller: billingAddress2Controller,
                        enabled: true,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'City',
                        ),
                        controller: billingCityController,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'State',
                        ),
                        controller: billingStateController,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your state';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Pin',
                        ),
                        controller: billingPinController,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your pin code';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                        ),
                        controller: billingPhoneController,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        controller: billingEmailController,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed:()  {
                        saveForm();
                      },
                      child: const Text('Redeem Points'),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
