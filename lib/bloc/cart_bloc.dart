import 'package:ecommerce/product_api/local_api.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product.dart';

// Events
sealed class CartEvent {}

class LoadCartEvent extends CartEvent {}

class RemoveFromCartEvent extends CartEvent {
  Product product;

  RemoveFromCartEvent(this.product);
}

class AddToCartEvent extends CartEvent {
  Product product;

  AddToCartEvent(this.product);
}

class ClearCartEvent extends CartEvent {}


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
    on<AddToCartEvent>((event, emit) async {
      await localApi.saveToCart(event.product);

      final cartProducts = await localApi.getAllProductsFromCart();
      emit(CartStateLoaded(cartProducts));
    });

    ///Triggers state change when RemoveFromCart fired
    on<RemoveFromCartEvent>((event, emit) async {
      await localApi.removeFromCart(event.product);

      final cartProducts = await localApi.getAllProductsFromCart();
      emit(CartStateLoaded(cartProducts));
    });

    ///Triggers state change when ClearCart fired
    on<ClearCartEvent>((event, emit) async {
      await localApi.emptyCart();

      final cartProducts = await localApi.getAllProductsFromCart();
      emit(CartStateLoaded(cartProducts));
    });
  }
}
