import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:maps_app/helpers/db_helper.dart';
import 'package:maps_app/models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(latitude: 100.10, longitude: 100.10),
      image: image,
    );

    _items.add(newPlace);
    notifyListeners();

    final data = {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    };
    DBHelper.insert('places', data);
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(latitude: 100.10, longitude: 100.10),
            image: File(item['image'])))
        .toList();

    notifyListeners();
  }
}
