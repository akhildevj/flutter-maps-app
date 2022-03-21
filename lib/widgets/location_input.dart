import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:maps_app/helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput({Key? key, required this.onSelectPlace})
      : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await Location().getLocation();
      final staticMapImageUrl = LocationHelper.getLocationPreview(
        latitude: locationData.latitude as double,
        longitude: locationData.longitude as double,
      );
      setState(() => _previewImageUrl = staticMapImageUrl);

      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (err) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text('No Location Chosen', textAlign: TextAlign.center)
              : Image.network(
                  _previewImageUrl as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        TextButton.icon(
          onPressed: _getCurrentLocation,
          icon: const Icon(Icons.location_on),
          label: const Text('Current Location'),
        ),
      ],
    );
  }
}
