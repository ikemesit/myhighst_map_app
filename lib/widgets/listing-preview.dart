import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListingPreview extends StatelessWidget {
  const ListingPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 5.0,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 200,
        height: 200,
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://aceglassva.com/wp-content/uploads/2014/11/Charming-storefront.jpg',
                fit: BoxFit.fitWidth,
              ),
              const Gap(10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('XYZ Barber shop'),
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
