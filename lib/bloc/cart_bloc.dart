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

/// Increases count of that product in cart table as well as product table
class IncreaseCountEvent extends CartEvent {
  Product product;

  IncreaseCountEvent(this.product);
}

/// Decreases count of that product in cart table as well as product table.
/// If count of the product is 1, it will remove it from cart
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

/// This bloc of [CartState] type responsible for managing the
/// list of products state in [cart.dart].
/// If local product table is empty, it will populate the table
/// using Products fetched from API by triggering [LoadCartEvent].
class CartBloc extends Bloc<CartEvent, CartState> {
  LocalApi localApi = LocalApi();

  CartBloc() : super(CartStateLoaded([])) {
    on<LoadCartEvent>((event, emit) async {
      final cartProducts = await localApi.getAllProductsFromCart();

      // Loaded products from cart
      logger.i('loading products from cache');
      emit(CartStateLoaded(cartProducts));
    });

    on<AddToCartEvent>((event, emit) async {
      event.product.count = 1;
      await localApi.saveToCart(event.product);
    });

    on<RemoveFromCartEvent>((event, emit) async {
      await localApi.removeFromCart(event.product);
    });

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
