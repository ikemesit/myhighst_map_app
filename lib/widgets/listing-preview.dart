import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myhighst_map_app/screens/place_detail/place_detail.dart';

class ListingPreview extends StatelessWidget {
  const ListingPreview({Key? key, required this.tempTag}) : super(key: key);

  final String tempTag;

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
                builder: (context) => PlaceDetail(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: tempTag,
                child: Image.network(
                  'https://aceglassva.com/wp-content/uploads/2014/11/Charming-storefront.jpg',
                  fit: BoxFit.fitWidth,
                ),
              ),
              const Gap(2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'XYZ Barber shop',
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
