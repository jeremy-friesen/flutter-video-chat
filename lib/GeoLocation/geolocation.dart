import 'package:geolocator/geolocator.dart';

String sayLocation(){
  var location = Geolocator();
  var message = '';
  
  location.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
  ).then((Position userLocation){

    location.placemarkFromCoordinates(
      userLocation.latitude, 
      userLocation.longitude,
    ).then((List<Placemark> places) {
      print('Reverse geocoding results: ');
      for (Placemark place in places){
        message = ('\t${place.name},${place.subThoroughfare},${place.thoroughfare},${place.locality}, ${place.subAdministrativeArea}');
      }
    });
  });

  return message;
}
