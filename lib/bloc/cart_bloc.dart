import 'package:ecommerce/product_api/local_api.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product.dart';

// Events
sealed class CartEvent {}

class LoadCartEvent extends CartEvent {}

class RemoveFromCart extends CartEvent {
  Product product;

  RemoveFromCart(this.product);
}

class AddToCart extends CartEvent {
  Product product;

  AddToCart(this.product);
}

// States
abstract class CartState {}

class CartStateLoaded extends CartState {
  final List<Product> products;

  CartStateLoaded(this.products);
}

// Cart Bloc

class CartBloc extends Bloc<CartEvent, CartState> {
  LocalApi localApi = LocalApi();

  CartBloc() : super(CartStateLoaded([])) {
    ///Triggers state change when LoadCartEvent fired
    on<LoadCartEvent>((event, emit) async {
      final cartProducts = await localApi.getAllProductsFromCart();

      // Loaded products from cart
      logger.i('loading products from cache');
      emit(CartStateLoaded(cartProducts));
    });

    ///Triggers state change when AddToCart fired
    on<AddToCart>((event, emit) async {
      await localApi.saveToCart(event.product);

      final cartProducts = await localApi.getAllProductsFromCart();
      emit(CartStateLoaded(cartProducts));
    });

    ///Triggers state change when RemoveFromCart fired
    on<RemoveFromCart>((event, emit) async {
      await localApi.removeFromCart(event.product);

      final cartProducts = await localApi.getAllProductsFromCart();
      emit(CartStateLoaded(cartProducts));
    });
  }
}
