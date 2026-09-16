// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:store/models/produt_model.dart';

// import 'package:store/services/update_product.dart';
// import 'package:store/widgets/custom_button.dart';

// import 'package:store/widgets/custom_text_field.dart';

// class UpdateProductView extends StatefulWidget {
//   static String id = 'UpdateProductView';

//   const UpdateProductView({Key? key}) : super(key: key);

//   @override
//   State<UpdateProductView> createState() => _UpdateProductViewState();
// }

// class _UpdateProductViewState extends State<UpdateProductView> {
//   String? productName, desc, image,price;
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final product = ModalRoute.of(context)!.settings.arguments == null? "Null"
//         :ModalRoute.of(context)!.settings.arguments as ProductModel ;

//     if(product!="Null"){
//     return ModalProgressHUD(
//       inAsyncCall: isLoading,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Update Product',
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 100,
//                 ),
//                 CustomTextField(
//                   onChanged: (data) {
//                     productName = data;
//                   },
//                   hintText: 'Product Name',
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomTextField(
//                   onChanged: (data) {
//                     desc = data;
//                   },
//                   hintText: 'description',
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomTextField(
//                   onChanged: (data) {
//                     price = data;
//                   },
//                   hintText: 'price',
//                   inputType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomTextField(
//                   onChanged: (data) {
//                     image = data;
//                   },
//                   hintText: 'image',
//                 ),
//                 const SizedBox(
//                   height: 70,
//                 ),
//                 CustomButton(
//                   text: 'Update',
//                   onTap: () async {
//                     isLoading = true;
//                     setState(() {});
//                     try {
//                       await updateProduct(product as ProductModel);

//                       print('success');
//                     } catch (e) {
//                       print(e.toString());
//                     }
//                     isLoading = false;
//                     setState(() {});
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//     }
//     return throw Exception("Product is equal null");
//   }

//   Future<void> updateProduct(ProductModel product) async {
//     await UpdateProductService().updateProduct(
//         id: product.id,
//         title: productName == null ? product.title : productName!,
//         price: price == null ? product.price.toString() : price!,
//         description: desc == null ? product.description : desc!,
//         image: image == null ? product.image : image!,
//         category: product.category);
//   }
// }