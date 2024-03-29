import 'package:ecommerce/product_api/local_api.dart';
import 'package:ecommerce/product_api/remote_api.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product.dart';

// Events
sealed class ProductsEvent {}

class LoadProductsEvent extends ProductsEvent {}

class UpdateProductCountEvent extends ProductsEvent {
  Product product;

  UpdateProductCountEvent(this.product);
}

// States

/// State for managing list of product instances
abstract class ProductsState {}

class ProductsStateLoaded extends ProductsState {
  final List<Product> products;

  ProductsStateLoaded(this.products);
}

// Product Bloc

/// This bloc of [ProductState] type responsible for managing the
/// list of products state in [product_list.dart].
/// If local product table is empty, it will populate the table
/// using Products fetched from API by triggering [LoadProductsEvent].
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  RemoteApi remoteApi = RemoteApi();
  LocalApi localApi = LocalApi();

  ProductsBloc() : super(ProductsStateLoaded([])) {
    ///Triggers state change when LoadProductsEvent fired
    on<LoadProductsEvent>((event, emit) async {
      List<Product> localProducts = await localApi.getAllProducts();

      if (localProducts.isEmpty) {
        debugPrint('loading products from API');
        final products = await remoteApi.getAllProducts();

        logger.i('adding products in local db');
        await localApi.saveAllProducts(products);
        debugPrint('Saved!');

        // once products loaded emit new state
        emit(ProductsStateLoaded(products));
      } else {
        // Load products from cache
        logger.i('loading products from cache');
        emit(ProductsStateLoaded(localProducts));
      }
    });

    on<UpdateProductCountEvent>((event, emit) async {
      await localApi.updateProductCount(event.product);
    });
  }
}
