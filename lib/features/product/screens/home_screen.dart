import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/features/product/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/widgets/product_grid.dart';
import 'package:ecommerce_app/features/product/widgets/category_filter.dart';
import 'package:ecommerce_app/features/product/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          if (state is ProductLoaded) {
            return Column(
              children: [
                ProductSearchBar(
                  onSearch: (query) {
                    context.read<ProductBloc>().add(SearchProducts(query));
                  },
                ),
                CategoryFilter(
                  categories: state.categories,
                  selectedCategory: state.selectedCategory,
                  onCategorySelected: (category) {
                    context.read<ProductBloc>().add(FilterByCategory(category));
                  },
                ),
                Expanded(
                  child: ProductGrid(products: state.products),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}