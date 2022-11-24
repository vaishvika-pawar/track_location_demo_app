import 'package:flutter/material.dart';
import 'package:tracklocation/location_service.dart';
import 'package:tracklocation/home_view.dart';
import 'package:provider/provider.dart';
import 'package:tracklocation/user_location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
        create: (context) => LocationService().locationStream,
        child: const MaterialApp(title: 'Flutter Demo', home: HomeView()));
  }
}