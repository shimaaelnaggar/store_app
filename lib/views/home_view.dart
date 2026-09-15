
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store/features/products/data/models/product_model.dart';

import 'package:store/widgets/custom_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
 static String id="HomeView";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("New Trend",style: TextStyle(color:Colors.black ),),
        actions: [
          IconButton(
              onPressed: (){},
              icon:const Icon(FontAwesomeIcons.cartShopping),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 65),
        child: FutureBuilder<List<ProductModel>>(
          future: AllProductsService().getAllProducts(),
        builder:(context,snapshot){
            if(snapshot.hasData) {
              List<ProductModel> products=snapshot.data!;
              return GridView.builder(
                clipBehavior: Clip.none,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 100,
                ),

                itemBuilder: (context, index) => CustomCard(product: products[index],),
              );
        }else{
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }
}


