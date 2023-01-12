import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'package:flutter/material.dart';

// Stateful map page
class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.filter});
  final String filter;

  @override
  State<MapPage> createState() => _MyWidgetState(filter: filter);
}

class _MyWidgetState extends State<MapPage> {
  //OverlayEntry? entry;
  _MyWidgetState({required this.filter});
  final String filter;
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
          // onTap: () {
          //   showOverlay();
          // },
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(filter),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers.values.toSet(),
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          )),
    );
  }

  // showOverlay() {
  //   entry = OverlayEntry(
  //       builder: (context) => Positioned(
  //           left: 20,
  //           top: 40, //MediaQuery.of(context).size.height - 100,
  //           child: SizedBox(
  //             height: 70,
  //             width: 200,
  //             child: ElevatedButton.icon(
  //               style: const ButtonStyle(
  //                 backgroundColor: MaterialStatePropertyAll(Colors.green),
  //               ),
  //               icon: const Icon(Icons.abc),
  //               onPressed: () {},
  //               label: const Text('amogus'),
  //             ),
  //           )));
  //   final overlay = Overlay.of(context)!;
  //   overlay.insert(entry!);
  // }
}
