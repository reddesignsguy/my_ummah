import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String city = "San Jose";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('MyUmmah'),
            backgroundColor: Colors.green[700],
            actions: [
              Text(city),
              Icon(Icons.location_on),
            ],
          ),
          body: HomePage(),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              )
            ],
          )),
    );
  }
}

// Stateful home page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        const ImageSection(),
        const SearchBar(),
        const CategoriesSection(),
      ],
    ));
  }
}

// Stateless image section
class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 200.0,
            width: double.infinity,
            child: Carousel(
              dotSize: 6.0,
              dotSpacing: 15.0,
              dotPosition: DotPosition.bottomCenter,
              images: [
                Image.asset('assets/images/masjid.jpeg', fit: BoxFit.cover),
                Image.asset('assets/images/food.jpeg', fit: BoxFit.cover),
                Image.asset('assets/images/masjid.jpeg', fit: BoxFit.cover),
                Image.asset('assets/images/masjid.jpeg', fit: BoxFit.cover),
              ],
            ),
          )
        ],
      )),
    );
  }
}

// TO-DO: Stateless search bar

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const ListTile(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Try "halal food" or "most popular"',
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 149, 149, 149),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}

// Stateless categories section widget
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(15),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: [
        categoryWidget(Icons.mosque, "Masjids", context),
        categoryWidget(Icons.restaurant, "Restaurants", context),
        categoryWidget(Icons.medical_services, "Doctors", context),
        categoryWidget(Icons.store, "Stores", context),
        categoryWidget(Icons.people, "All", context),
      ],
    );
  }
}

// Stateless category widget

Widget categoryWidget(IconData icon, String text, BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.red,
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MapPage()),
      );
    },
    child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Icon(icon),
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(text),
            ),
          ],
        )),
  );
}

// Stateful map page
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MapPage> {
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
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ));
  }
}

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate back to first route when tapped.
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );