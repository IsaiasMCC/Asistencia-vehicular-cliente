import 'package:asistencia_vehicular_cliente/infrestructure/utils/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};
  final Map<CircleId, Circle> _circles = {};
  late GoogleMapController _mapController;
  //late LatLng _currentPosition;
  late LatLng _locationSelected = const LatLng(0, 0);

  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers.values.toSet();
  Set<Circle> get circles => (_circles.values.toSet());
  //LatLng get currentPosition => _currentPosition;
  LatLng get locationSelected => _locationSelected;

 /*  MapController(LatLng position, {String key = "markers"}) {
    final markerId = MarkerId(key);
    final marker = Marker(markerId: markerId, position: position);
    _markers[markerId] = marker;
    permisoDeUbicacion();
  } */
   MapController() {
    permisoDeUbicacion();
  }

  void permisoDeUbicacion() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
  }

  void onMapCretted(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
    _mapController = controller;
  }

  getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Servicio de ubicación desactivado");
    }
    Position position = await Geolocator.getCurrentPosition();
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    onTap(currentLocation, key: "marker");
    notifyListeners();
  }

  void ubicacion(LatLng position, {String key = "markers"}) {
    final markerId = MarkerId(key);
    final marker = Marker(markerId: markerId, position: position);
    _markers[markerId] = marker;
  }

  void onTap(LatLng position, {String key = "marker"}) {
    final markerId = MarkerId(key);
    final circleId = CircleId(key);
    print(_circles.length);
    // final markerId = MarkerId(_markers.length.toString());
    // final circleId = CircleId(_markers.length.toString());
    final marker = Marker(markerId: markerId, position: position);
    final circle = Circle(
      circleId: circleId,
      center: position,
      radius: 1000,
      strokeWidth: 2,
      strokeColor: Colors.green,
      fillColor: Colors.green.withAlpha(70),
    );
    _circles[circleId] = circle;
    _markers[markerId] = marker;
    _locationSelected = position;
    notifyListeners();
  }
  void onDeleteMarker() {
    _circles.clear();
    _markers.clear();
    notifyListeners();
  }

  final initialCamarePosition = const CameraPosition(
    target: LatLng(-17.78629, -63.18117),
    zoom: 14.4746,
  );
}
