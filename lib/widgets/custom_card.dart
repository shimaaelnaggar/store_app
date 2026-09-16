// import 'package:flutter/material.dart';
// import 'package:store/features/products/data/models/product_model.dart';

// import 'package:store/views/update_product_view.dart';

// class CustomCard extends StatelessWidget {
//    CustomCard({
//     required this.product,
//     Key? key,
//   }) : super(key: key);
//    ProductModel product;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, UpdateProductView.id,
//             arguments: product);
//       },
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 50,
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 20,
//                   offset: const Offset(10, 10),
//                 ),
//               ],
//             ),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               elevation: 10,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       product.title.substring(0, 6),
//                       style: const TextStyle(color: Colors.grey, fontSize: 16),
//                     ),
//                     const SizedBox(
//                       height: 3,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           r"$" '${product.price.toString()}',
//                         ),
//                         const Icon(
//                           Icons.favorite,
//                           color: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: 32,
//             bottom: 60, // top= -65 (the same),
//             child: Image.network(
//               product.image,
//               height: 100,
//               width: 100,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
