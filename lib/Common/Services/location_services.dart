import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationServices {
  
  static Future<void> requestLocationPermission() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();

    if (servicestatus) {
    } else {}
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        EasyLoading.showError(
            'Location permissions are denied enable it from settings');
      } else if (permission == LocationPermission.deniedForever) {
        EasyLoading.showError(
            'Location permissions are denied forever enable it from settings');
      } else {
        EasyLoading.showSuccess("GPS Location service is granted");
      }
    } else {}
  }

  static Future<List<double>> getCurrentLatLong() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //Output: 29.6593457

    double long = position.longitude;
    double lat = position.latitude;

    List<double> latlong = [lat, long];

    return latlong;
  }

  static Future<LatLng> setLatLongwithCity(String city) async {
    List<Location> locations = await locationFromAddress(city);

    double long = locations.first.longitude;
    double lat = locations.first.latitude;

    return LatLng(lat, long);
  }
}
