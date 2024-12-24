import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/cart/screens/cart_screen.dart';
import 'package:ecommerce_app/features/checkout/screens/checkout_screen.dart';
import 'package:ecommerce_app/features/product/screens/home_screen.dart';
import 'package:ecommerce_app/features/product/screens/product_details_screen.dart';
import 'package:ecommerce_app/models/product.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/product':
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
            product: settings.arguments as Product,
          ),
        );
      case '/cart':
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );
      case '/checkout':
        return MaterialPageRoute(
          builder: (_) => const CheckoutScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}