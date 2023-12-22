
import 'package:flutter/material.dart';
import 'package:pb_apps/api_url/api_url.dart';
import 'package:pb_apps/widget/drawer.dart';
import '../models/my_orders.dart';
import '../widget/Big_text.dart';
import '../widget/My_app_bar.dart';
class OrderDetail extends StatefulWidget {
  final Order order;
  const OrderDetail({Key? key,  required this.order}) : super(key: key);
  @override
  State<OrderDetail> createState() => _OrderDetailState();
}
class _OrderDetailState extends State<OrderDetail> {
  bool _showSummary=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _showSummary=true;
                          });
                        },
                        child: SizedBox(width: 150,
                          child: BigText(text: 'SUMMARY',
                            color: _showSummary?Colors.teal:Colors.grey.shade500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _showSummary=false;
                          });
                        },
                        child: SizedBox(
                          width: 150,
                          child:BigText(text:'ADDRESS',
                            color: _showSummary?Colors.grey.shade500:Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 2,),
                  if(_showSummary)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BigText(text: 'OrderId',color: Colors.teal,),
                        Text('${widget.order.id}'),
                        BigText(text: 'Points Redeem',color: Colors.teal,),
                        Text('${widget.order.totalPoints} Pts'),
                        BigText(text: 'Status',color: Colors.teal,),
                         Text(widget.order.status),
                        BigText(text: 'Delivery Date',color: Colors.teal,),
                        Text(widget.order.deliveredDate),
                        const SizedBox(height: 20,),
                        Card(
                          child: Column(
                            children: [
                              BigText(text: 'Product',color: Colors.teal,),
                              const Divider(thickness: 2,),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.order.items.length,
                                  itemBuilder: (context, index){
                                    var orderItem = widget.order.items[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BigText(text:orderItem.name,color: Colors.teal,),
                                          const SizedBox(height: 10,),
                                          Image.network('${Constants.BASE_URL}/api/v1/media/stream/${orderItem.imageId}',height: 70,),
                                          const SizedBox(height: 10,),
                                          Text('ProductId: ${orderItem.productId}'),
                                          // Text('PartName: ${orderItem.name}'),
                                          Text('Points: ${orderItem.points} Pts'),
                                          Text('Quantity: ${orderItem.quantity}'),

                                        ],
                                      ),
                                    );
                                  }
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  if(!_showSummary)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'First Name',color: Colors.teal,),
                          Text(widget.order.firstName),
                          BigText(text: 'Last Name',color: Colors.teal,),
                          Text(widget.order.lastName),
                          BigText(text: 'Address 1',color: Colors.teal,),
                          Text(widget.order.address1),
                          BigText(text: 'Address 2',color: Colors.teal,),
                          Text(widget.order.address2),
                          BigText(text: 'City',color: Colors.teal,),
                          Text(widget.order.city),
                          BigText(text: 'State',color: Colors.teal,),
                          Text(widget.order.state),
                          BigText(text: 'Email',color: Colors.teal,),
                          Text(widget.order.email),
                          BigText(text: 'Pin Code',color: Colors.teal,),
                          Text(widget.order.zip),
                          BigText(text: 'Phone No',color: Colors.teal,),
                          Text(widget.order.deliveryPhone),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
