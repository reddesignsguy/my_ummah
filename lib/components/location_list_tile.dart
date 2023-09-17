import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.name,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String name;
  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          title: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
        ),
      ],
    );
  }
}
