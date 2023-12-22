// import 'package:flutter/material.dart';
// import 'package:pb_apps/widget/add_spaces.dart';
// import '../api_url/api_url.dart';
// import '../models/product.dart'; // Import your product model
//
// class ProductDetailDialog extends StatelessWidget {
//   final Product product;
//
//    ProductDetailDialog({required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: AlertDialog(
//         title: Text(product.name),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.network(
//               '${Constants.BASE_URL}/api/v1/media/stream/${product.media.id}',
//               fit: BoxFit.fill,
//             ),
//             Text("Product ID: ${product.id}"),
//             Text("Pts: ${product.points}"),
//             addVerticalSpace(10),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Column(
//                 children: const [
//                   Text("Description",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20))
//                 ],
//               ),
//             ),
//             addVerticalSpace(10),
//             Text(product.description)
//             // Other product details...
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: const Text('X'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:pb_apps/widget/add_spaces.dart';
import '../api_url/api_url.dart';
import '../models/product.dart';
class ProductDetailDialog extends StatelessWidget {
  final Product product;
   ProductDetailDialog({required this.product});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                icon: const Icon(Icons.close,color: Colors.teal,),
              ),
            ),
            Center(
              child: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 10,right: 10),
              child: Center(
                child: Image.network(
                  '${Constants.BASE_URL}/api/v1/media/stream/${product.media.id}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            addVerticalSpace(10),
            Align(
              alignment: Alignment.center,
                child: Text("Product ID: ${product.id}")),
            const SizedBox(height: 5,),
            Align(
                alignment: Alignment.center,
                child: Text("Pts: ${product.points}",
                  style: const TextStyle(fontWeight: FontWeight.bold),)),
            addVerticalSpace(10),
            const Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            addVerticalSpace(10),
            Text(
              product.description,
              style: const TextStyle(color: Colors.grey,fontSize:14),
            ),
            addVerticalSpace(10)
          ],
        ),
      ),
    );
  }
}
