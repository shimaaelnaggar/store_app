import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/categories/presentation/widgets/category_item.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../products/presentation/bloc/products/products_bloc.dart';
import '../../../products/presentation/bloc/products/products_event.dart';
import '../bloc/categories_bloc.dart';
import '../bloc/categories_event.dart';
import '../bloc/categories_state.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (BuildContext context, state) {
        if (state is CategoriesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (state is CategoriesSuccessState) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => CategoryItem(
              title: state.categories[index].name,
              isSelected:
                  state.selectedCategory?.id == state.categories[index].id,
              onTap: () {
                final category = state.categories[index];

                context.read<CategoriesBloc>().add(
                      SelectCategoryEvent(category: category),
                    );

                context.read<ProductsBloc>().add(
                      GetAllProductsEvent(
                        page: 1,
                        category: category.name,
                      ),
                    );
              },
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              width: 10,
            ),
            itemCount: state.categories.length,
          );
        }
        if (state is CategoriesErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return const SizedBox();
      },
    );
  }
}
