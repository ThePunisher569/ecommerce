import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/store.dart';
import '../../utils/constants.dart';
import 'store_options_screen.dart';

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
        footer: GridTileBar(
          backgroundColor: Colors.indigo.shade600,
          title: Text(
            store.storeName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          trailing: ElevatedButton(
            onPressed: () => checkIntoStore(context),
            child: const Text('Visit this store'),
          ),
        ),
        child: Card(
          color: Colors.indigo.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
      color: Colors.indigo.shade100,
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
                  'Owner Name : ${store.ownerName}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('Mobile No. : ${store.mobile}'),
                Text('City : ${store.city}'),
                Text('State : ${store.state}'),
                Text('Country : ${store.country}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
