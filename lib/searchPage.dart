import 'package:flutter/material.dart';

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
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Icon(Icons.arrow_back))),
          Autocomplete<String>(
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
          const Text("Placeholder"),
        ],
      ),
    );
  }
}
