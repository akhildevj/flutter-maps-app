import 'package:flutter/material.dart';
import 'package:maps_app/helpers/location_helper.dart';
import 'package:maps_app/providers/places.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final place = Provider.of<PlacesProvider>(context).findById(id);
    final mapUrl = LocationHelper.getLocationPreview(
        latitude: place.location.latitude, longitude: place.location.longitude);

    return Scaffold(
        appBar: AppBar(title: Text(place.title)),
        body: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            MapScreen(mapUrl: mapUrl, address: place.location.address as String)
          ],
        ));
  }
}

class MapScreen extends StatefulWidget {
  final String mapUrl;
  final String address;

  const MapScreen({Key? key, required this.mapUrl, required this.address})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var isOpen = false;

  void triggerMapView() {
    setState(() => isOpen = !isOpen);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextButton(
          onPressed: triggerMapView,
          child: isOpen
              ? const Text('View Address')
              : const Text('View Location in Map')),
      isOpen
          ? SizedBox(
              child: Image.network(
                widget.mapUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            )
          : Text(widget.address)
    ]);
  }
}
