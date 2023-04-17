import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  late Location _location;
  Location get location => _location;
  late LocationData _locationData;

  late LatLng _locationPosition =
      new LatLng(37.2887016141017, 127.061237557645);
  LatLng get locationPosition => _locationPosition;

  bool locationServiceActive = true;
  LocationProvider() {
    _location = new Location();
  }

  initalization() async {
    await getUserLocation();
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLoaction) {
      _locationPosition = LatLng(
        currentLoaction.latitude!,
        currentLoaction.longitude!,
      );

      print(_locationPosition);
      notifyListeners();
    });
  }
}
