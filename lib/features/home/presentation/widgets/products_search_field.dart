import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../products/presentation/bloc/products/products_bloc.dart';
import '../../../products/presentation/bloc/products/products_event.dart';

class ProductsSearchField extends StatelessWidget {
  const ProductsSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: 'Search for products...',
        inputType: TextInputType.text,
        onChanged: (value) {
          context
              .read<ProductsBloc>()
              .add(SearchProductsEvent(searchQuery: value));
        });
  }
}
