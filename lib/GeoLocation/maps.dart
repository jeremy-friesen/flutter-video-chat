import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:geolocator/geolocator.dart';

import 'getLocation.dart';

class MapsPage extends StatefulWidget {
  @override
  Maps createState() => Maps();
}

MapController mapcontroller = MapController();

List<Marker> _markers = [];

class Maps extends State<MapsPage> {
  Position user;
  LatLng loc;

  @override
  Widget build(BuildContext context) {
    double lat = 0.0;
    double long = 0.0;

    getLocation().then((position){
      user = position;
      setMarkers(user);
    });

    if (user == null){
      lat = 28.374139; 
      long = -81.549396;
    }
    else{  
      lat = user.latitude;
      long = user.longitude;
    }

    loc = LatLng(lat, long);

    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'app.maps')),
        backgroundColor: Colors.green,
      ),
      body: FlutterMap (
        mapController: mapcontroller, 

        options: MapOptions(
          minZoom: 16.0,
          center: loc,
        ),
        layers: [
          TileLayerOptions(
            // for OpenStreetMaps:
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: _markers,              
          ),
        ],
      ),
    );
  }

  void setMarkers(pos){
    LatLng point = LatLng(pos.latitude, pos.longitude);

    List<Marker> markers = [
      Marker(
        width: 45.0,
        height: 45.0,
        point: point,
        builder: (context) => Container(
          child: IconButton( 
            icon: Icon(Icons.location_on),
            color: Colors.blue,
            iconSize: 45.0,
            onPressed: () {},
          ),
        ),
      ),
    ];
    
    setState(() {
      _markers.clear();
      _markers = markers;
    });
  }
}

