# E-Commerce Application

A simple app to demonstrate the idea behind the working of an ecommerce app.

## Description

Ecommerce app used for purchasing products from a particular store.
The application is built in Flutter.

## Features:
- Login with mobile number and OTP
- List of Stores and check in option
- Give remark to store
- Add products to cart with quantity control
- Dynamic redirection to the store based on check in status
- State preservation of cart for products and their quantity
- Purchase products

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Flutter](https://flutter.dev/), [Dart](https://dart.dev/),
  [Git](https://github.com/) installed on your machine.

## Getting Started

To get a local copy up and running, follow these simple steps:

1. Clone the repository:

   ```sh
   git clone https://github.com/thepunisher569/ecommerce.git
   ```

2. Change to the project directory:

   ```sh
   cd ecommerce
   ```

3. Run the app:

   ```sh
   flutter run
   ```

## Project Structure Brief
```
lib/
|- bloc/
    |- product_bloc.dart    // logic to deal with product
    |- cart_bloc.dart       // logic to deal with cart
|- model/
    |- product.dart     // product model
    |- store.dart       // store model
|- product_api/
    |- product_repo.dart
    |- local_api.dart       // local api methods
    |- remote_api.dart      // remote api methods
|- utils/
    |- constants.dart       // compile time constants
    |- db_constants.dart    // DB related constants

|- ui/
    |- cart.dart                // Cart screen 
    |- remark_widget.dart       // Remark bottom sheet widget
    |- login/
        |- login_screen.dart    // login with mobile and otp
        |- widgets.dart         // helper login widgets
    |- product/
        |- product_list.dart    // product list screen with add to cart and qty
        |- product_item.dart    // single product ui
    |- store/
        |- home.dart            // home screen for list of stores and redirection
        |- store_options_screen.dart    // store home screen
        |- store_widget.dart    // helper widgets for store
|- main.dart
```

## Contributing

Contributions are what make the open-source community such an amazing place to be. Any contributions you make are greatly appreciated.

1. Fork the project
2. Create a new feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Email: aatifmo635@outlook.com

Project Link: [https://github.com/thepunisher569/ecommerce](https://github.com/thepunisher569/ecommerce)