import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/common_widgets/app_chip.dart';
import 'package:myhighst_map_app/features/place/domain/place_model.dart';

import '../data/place_repository.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class PlaceList extends ConsumerWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placeRepositoryProvider).getPlaces(null);

    return FutureBuilder(
      future: places,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Places'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    10,
                    20,
                    2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swap_horiz_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      const Gap(4),
                      Text(
                        'Filter places by category',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(10),
                      AppChip(
                        label: 'All',
                      ),
                      Gap(10),
                      AppChip(
                        label: 'Entertainment',
                        icon: Icon(
                          Icons.party_mode_sharp,
                          color: Colors.white,
                        ),
                      ),
                      Gap(10),
                      AppChip(
                        icon: Icon(
                          Icons.medical_services_sharp,
                          color: Colors.white,
                        ),
                        label: 'Medical',
                      ),
                      Gap(10),
                      AppChip(
                        icon: Icon(
                          Icons.shopping_basket_sharp,
                          color: Colors.white,
                        ),
                        label: 'Shopping',
                      ),
                      Gap(10),
                      AppChip(
                        icon: Icon(
                          Icons.attach_money_sharp,
                          color: Colors.white,
                        ),
                        label: 'Finance',
                      ),
                    ],
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: buildListView(snapshot, context),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Places'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  ListView buildListView(
      AsyncSnapshot<List<Place>> snapshot, BuildContext context) {
    return ListView(
      children: List.generate(
        snapshot.data!.length,
        (index) {
          return buildListItem(snapshot, index, context);
        },
      ),
    );
  }

  GestureDetector buildListItem(
      AsyncSnapshot<List<Place>> snapshot, int index, BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 150,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        padding: const EdgeInsets.all(0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
              child: Image.network(
                snapshot.data![index].images[0],
                fit: BoxFit.cover,
                width: 120,
                height: 150,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![index].title.toTitleCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          snapshot.data![index].address
                              .toString()
                              .toTitleCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 10,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Gap(2),
                        Text(
                          snapshot.data![index].city.capitalize(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView buildGridView(
      AsyncSnapshot<List<Place>> snapshot, BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 0,
      ),
      children: List.generate(
        snapshot.data!.length,
        (index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Hero(
                        tag: snapshot.data![index].title,
                        child: Image.network(
                          snapshot.data![index].images[0],
                          fit: BoxFit.fitWidth,
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
                            snapshot.data![index].title.toUpperCase(),
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
        },
      ),
    );
  }
}
