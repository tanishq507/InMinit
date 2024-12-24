import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce_app/models/product.dart';

// Events
abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  final int quantity;

  AddToCart({required this.product, this.quantity = 1});

  @override
  List<Object> get props => [product, quantity];
}

class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateQuantity extends CartEvent {
  final Product product;
  final int quantity;

  UpdateQuantity({required this.product, required this.quantity});

  @override
  List<Object> get props => [product, quantity];
}

// States
class CartState extends Equatable {
  final Map<Product, int> items;
  final double total;

  const CartState({
    this.items = const {},
    this.total = 0,
  });

  @override
  List<Object> get props => [items, total];
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedItems = Map<Product, int>.from(state.items);
    updatedItems[event.product] = (updatedItems[event.product] ?? 0) + event.quantity;
    _emitUpdatedState(emit, updatedItems);
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = Map<Product, int>.from(state.items)..remove(event.product);
    _emitUpdatedState(emit, updatedItems);
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    if (event.quantity <= 0) {
      add(RemoveFromCart(product: event.product));
      return;
    }
    
    final updatedItems = Map<Product, int>.from(state.items);
    updatedItems[event.product] = event.quantity;
    _emitUpdatedState(emit, updatedItems);
  }

  void _emitUpdatedState(Emitter<CartState> emit, Map<Product, int> items) {
    final total = items.entries.fold<double>(
      0,
      (sum, entry) => sum + (entry.key.price * entry.value),
    );
    emit(CartState(items: items, total: total));
  }
}