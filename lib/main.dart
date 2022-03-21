import 'package:flutter/material.dart';
import 'package:maps_app/providers/places.dart';
import 'package:maps_app/screens/add_place.dart';
import 'package:maps_app/screens/place_detail.dart';
import 'package:maps_app/screens/place_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: const PlaceListScreen(),
          routes: {
            AddPlaceScreen.routeName: (_) => const AddPlaceScreen(),
            PlaceDetailScreen.routeName: (_) => const PlaceDetailScreen()
          }),
    );
  }
}
