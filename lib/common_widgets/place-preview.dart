import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../features/place/presentation/place.dart';

class PlacePreview extends StatelessWidget {
  final String phoneNo;
  final String title;
  final String address;
  final String city;
  final String state;
  final String website;
  final String description;
  final List<String> images;
  final double latitude;
  final double longitude;

  const PlacePreview({
    Key? key,
    required this.phoneNo,
    required this.title,
    required this.address,
    required this.city,
    required this.state,
    required this.website,
    required this.description,
    required this.images,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 4.0,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.5),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 200,
        height: 200,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Place(
                  title: title,
                  address: address,
                  city: city,
                  state: state,
                  website: website,
                  description: description,
                  images: images,
                  latitude: latitude,
                  longitude: longitude,
                  phoneNo: phoneNo,
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Hero(
                  tag: title,
                  child: Image.network(
                    images[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
