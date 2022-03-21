import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:maps_app/helpers/db_helper.dart';
import 'package:maps_app/helpers/location_helper.dart';
import 'package:maps_app/models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getAddress(
        latitude: location.latitude, longitude: location.longitude);

    final updatedLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: updatedLocation,
      image: image,
    );

    _items.add(newPlace);
    notifyListeners();

    final data = {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location.latitude,
      'longitude': newPlace.location.longitude,
      'address': newPlace.location.address as String
    };
    DBHelper.insert('places', data);
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                latitude: item['latitude'],
                longitude: item['longitude'],
                address: item['address'],
              ),
            ))
        .toList();

    notifyListeners();
  }
}
