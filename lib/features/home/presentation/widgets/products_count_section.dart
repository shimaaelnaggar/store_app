import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/products/presentation/widgets/products_header.dart';

import '../../../products/presentation/bloc/products/products_bloc.dart';
import '../../../products/presentation/bloc/products/products_state.dart';

class ProductsCountSection extends StatelessWidget {
  const ProductsCountSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductsBloc, ProductsState, int>(
      selector: (state) {
        if (state is ProductsSuccessState) {
          return state.totalCount;
        }
        return 0;
      },
      builder: (context, totalCount) {
        return ProductsHeader(
          productsCount: totalCount,
        );
      },
    );
  }
}
