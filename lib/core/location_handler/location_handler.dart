import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
//Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

Future<bool> handleLocationPermission(context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}


var lat ;
var long;
var street;
var place;

Future<void> parseGoogleMapsLink(String mapLink) async {
  try {
    // Regular expression to extract latitude and longitude from the Google Maps link
    RegExp regex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    Match? match = regex.firstMatch(mapLink);

    if (match != null && match.groupCount >= 2) {
      // Extract latitude and longitude from the matched groups
      double latitude = double.parse(match.group(1)!);
      double longitude = double.parse(match.group(2)!);

      // Reverse geocode to get place name from latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      // Extract place name from placemarks
      String placeName = placemarks.last.name ?? "Unknown";

      print("Latitude: $latitude, Longitude: $longitude");

      lat = latitude.toString();
      long = longitude.toString();
      street = '${placemarks.first.thoroughfare ?? ""}, ${placemarks.first.locality ?? ""}, ${placemarks.first.administrativeArea ?? ""}';
      place = '${placemarks.first.country } , ${placemarks.first.name} }';
      print("Place Name: $placeName");
      print("Place Name: $place");
      print("Place Name: $street");
    } else {
      throw Exception("Latitude and longitude not found in the Google Maps link");
    }
  } on PlatformException catch (e) {
    print("Error parsing Google Maps link: ${e.message}");
  } on FormatException catch (e) {
    print("Error parsing Google Maps link: ${e.message}");
  } on Exception catch (e) {
    print("Error: $e");
  }
}

