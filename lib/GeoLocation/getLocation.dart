import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

import 'dart:async';
import 'maps.dart';

Future<Position> getLocation() async{
  var geolocator = Geolocator();
  Position currentLocation;
  
  try{
    currentLocation = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  } catch (e) {
    currentLocation = null;
  }

  mapcontroller.move(LatLng(currentLocation.latitude, currentLocation.longitude), 16.0);

  print('in _getLocation');
  print('lat: ${currentLocation.latitude} long: ${currentLocation.longitude} ');

  return currentLocation;
}