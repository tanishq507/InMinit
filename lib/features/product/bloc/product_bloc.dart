import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/features/product/repositories/product_repository.dart';

// Events
abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);

  @override
  List<Object> get props => [query];
}

class FilterByCategory extends ProductEvent {
  final String category;

  FilterByCategory(this.category);

  @override
  List<Object> get props => [category];
}

// States
abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<String> categories;
  final String? selectedCategory;
  final String searchQuery;

  ProductLoaded({
    required this.products,
    required this.categories,
    this.selectedCategory,
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [products, categories, searchQuery];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<FilterByCategory>(_onFilterByCategory);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.getProducts();
      final categories = await productRepository.getCategories();
      emit(ProductLoaded(products: products, categories: categories));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final filteredProducts = currentState.products
          .where((product) =>
              product.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ProductLoaded(
        products: filteredProducts,
        categories: currentState.categories,
        selectedCategory: currentState.selectedCategory,
        searchQuery: event.query,
      ));
    }
  }

  void _onFilterByCategory(FilterByCategory event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      try {
        final products = await productRepository.getProductsByCategory(event.category);
        emit(ProductLoaded(
          products: products,
          categories: currentState.categories,
          selectedCategory: event.category,
          searchQuery: currentState.searchQuery,
        ));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }
  }
}