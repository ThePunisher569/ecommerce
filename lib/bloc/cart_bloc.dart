import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product.dart';
import '../product_api/local_api.dart';
import '../utils/constants.dart';

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
    });

    ///Triggers state change when RemoveFromCart fired
    on<RemoveFromCartEvent>((event, emit) async {
      await localApi.removeFromCart(event.product);
    });

    ///Triggers state change when ClearCart fired
    on<ClearCartEvent>((event, emit) async {
      await localApi.emptyCart();
    });
  }
}
