import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'map.dart' as maps;
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

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
            title: const Text('Ummah2U'),
            backgroundColor: Colors.green[700],
            actions: [
              Text(city),
              const Icon(Icons.location_on),
            ],
          ),
          body: const HomePage(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
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
    return Column(
      children: const [
        ImageSection(),
        SearchBar(),
        CategoriesSection(),
      ],
    );
  }
}

// Stateless image section
class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    ));
  }
}

// TO-DO: Stateless search bar

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
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
      physics: const NeverScrollableScrollPhysics(),
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
      backgroundColor: Colors.green,
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => maps.MapPage(filter: text)),
      );
    },
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(icon),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(text),
            ),
          ],
        )),
  );
}

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> listItems = [
    "Alice",
    "Bob",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Icon(Icons.arrow_back))),
          Container(
            child: Autocomplete<String>(
              optionsBuilder: ((textEditingValue) {
                if (textEditingValue.text == "") {
                  return const Iterable<String>.empty();
                }

                return listItems.where((item) {
                  return item.contains(textEditingValue.text.toLowerCase());
                });
              }),
              onSelected: (item) {
                print('The $item was selected!');
              },
            ),
          ),
          Text("Placeholder"),
        ],
      ),
    );
  }
}
