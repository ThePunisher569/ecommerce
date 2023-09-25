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

class IncreaseCountEvent extends CartEvent {
  Product product;

  IncreaseCountEvent(this.product);
}

class DecreaseCountEvent extends CartEvent {
  Product product;

  DecreaseCountEvent(this.product);
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
    on<AddToCartEvent>((event, emit) async {
      event.product.count = 1;
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

    on<IncreaseCountEvent>((event, emit) async {
      event.product.count += 1;
      await localApi.updateCount(event.product);
      await localApi.updateProductCount(event.product);
    });

    on<DecreaseCountEvent>((event, emit) async {
      if (event.product.count == 1) {
        event.product.count = 0;
        await localApi.removeFromCart(event.product);
      } else {
        event.product.count -= 1;
        await localApi.updateCount(event.product);
      }

      await localApi.updateProductCount(event.product);
    });
  }

  @override
  void onTransition(Transition<CartEvent, CartState> transition) {
    super.onTransition(transition);

    print('Cart state transition occurred');
    logger.d((transition.nextState as CartStateLoaded).products);
  }
}
