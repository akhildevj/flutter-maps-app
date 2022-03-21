import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maps_app/providers/places.dart';
import 'package:maps_app/screens/add_place.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Places'), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add))
      ]),
      body: FutureBuilder(
        future:
            Provider.of<PlacesProvider>(context, listen: false).fetchPlaces(),
        builder: (_, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<PlacesProvider>(
                    builder: (context, value, child) => value.items.isEmpty
                        ? child as Widget
                        : ListView.builder(
                            itemCount: value.items.length,
                            itemBuilder: (_, index) => ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                      File(value.items[index].image.path))),
                              title: Text(value.items[index].title),
                              onTap: () {},
                            ),
                          ),
                    child: const Center(child: Text('No places yet!')),
                  ),
      ),
    );
  }
}
