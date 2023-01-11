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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
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
              // ignore: avoid_print
              print('The $item was selected!');
            },
          ),
          const Text("Placeholder"),
        ],
      ),
    );
  }
}
