import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tracklocation/user_location.dart';

class LocationService {
  // Keep track of current Location
  UserLocation? _currentLocation;
  Location location = Location();
  // Continuously emit location updates
  StreamController<UserLocation> locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.GRANTED) {
        location.onLocationChanged((location) {
          if (location != null) {
            locationController.add(UserLocation(
              latitude: location.latitude,
              longitude: location.longitude,
            ));
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } catch (e) {
      debugPrint('Could not get the location: $e');
    }

    return _currentLocation!;
  }
}
