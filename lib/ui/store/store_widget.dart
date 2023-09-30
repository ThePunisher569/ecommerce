import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/store.dart';
import '../../utils/constants.dart';
import 'store_options_screen.dart';

/// View for Store model instances
class StoreWidget extends StatelessWidget {
  final Store store;

  const StoreWidget({
    super.key,
    required this.store,
  });

  void checkIntoStore(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('store_id', store.storeId);

    print('prefs store_id set to ${store.storeId}');

    if (!context.mounted) return;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StoreOptionsScreen(store: store),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GridTile(
        footer: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: GridTileBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                store.storeName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: ElevatedButton(
                  onPressed: () => checkIntoStore(context),
                  child: const Text('Visit this Store'),
                ),
              ),
            ),
          ),
        ),
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: CachedNetworkImage(
            imageUrl: store.storeImage,
            alignment: Alignment.center,
            fit: BoxFit.contain,
            useOldImageOnUrlChange: true,
            filterQuality: FilterQuality.high,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, error, stackTrace) => const Center(
                child:
                    Icon(Icons.broken_image, size: 48, color: Colors.white70)),
          ),
        ),
      ),
    );
  }
}

/// It will be used in store_options_screen.dart
class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: store.storeImage,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image,
                      size: 48, color: Colors.white70)),
            ),
            Constants.gap16V,
            Column(
              children: [
                Text(
                  'Owner Name: ${store.ownerName}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Constants.gap8V,
                Text(
                  'Mobile Number: ${store.mobile}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Constants.gap8V,
                Text(
                  'Location: ${store.city}, ${store.state}, ${store.country}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
