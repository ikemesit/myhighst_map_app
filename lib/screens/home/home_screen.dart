import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/common_widgets/place-preview.dart';
import 'package:myhighst_map_app/features/place/presentation/place_list.dart';
import 'package:myhighst_map_app/screens/home/home_screen.provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../app_constants.dart';
import '../../features/authentication/data/auth.dart';
import '../../features/authentication/presentation/login/login_screen.dart';
import '../../features/profile/profile_page.dart';
import '../../global_states.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  late final GoogleMapController mapController;
  final LatLng _center = AppConstants.myLocation;
  final PanelController _pc = PanelController();
  final TextEditingController searchTextController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slideUpPanelStatus = ref.watch(slideUpStateProvider);
    final showDestinationSearchPanel =
        ref.watch(showDestinationSearchPanelProvider);
    final user = ref.watch(currentUserProvider);
    final auth = ref.read(authProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
          ),
          SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).viewPadding).top -
                  kToolbarHeight,
              minHeight: 200.0,
              snapPoint: 0.5,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 0.0,
              ),
              controller: _pc,
              panel: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: ElevatedButton(
                          onPressed: () => _pc
                              .animatePanelToPosition(
                            1.0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          )
                              .then((value) {
                            ref
                                .read(
                                    showDestinationSearchPanelProvider.notifier)
                                .update((state) => !state);
                          }),
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.location_on),
                              Gap(10),
                              Text('Where would you like to go to?')
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                      ),
                      const Gap(15),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Chip(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              label: Text(
                                'Places of interest',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const PlacePreview(tempTag: 'tag1'),
                            const PlacePreview(tempTag: 'tag2'),
                            const PlacePreview(tempTag: 'tag3'),
                            const PlacePreview(tempTag: 'tag4'),
                            Card(
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
                                        builder: (context) => const PlaceList(),
                                      ),
                                    );
                                  },
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'View listings',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(25),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Chip(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              label: Text(
                                'Account & Settings',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                onTap: () {
                                  if (auth.currentUser != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage()),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.black,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                ),
                                                width: 30,
                                                height: 30,
                                                child: Icon(
                                                  Icons.person_2_sharp,
                                                  color: Colors.grey[800],
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            const Gap(10),
                                            const Text(
                                              'Profile',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(1),
                            Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              elevation: 4.0,
                              shadowColor: const Color.fromRGBO(0, 0, 0, 0.5),
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.red,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60)),
                                                width: 30,
                                                height: 30,
                                                child: Icon(
                                                  Icons.settings,
                                                  color: Colors.grey[800],
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            const Gap(10),
                                            const Text(
                                              'Settings',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Consumer(builder: (context, ref, child) {
                    return showDestinationSearchPanel == true
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(
                                              showDestinationSearchPanelProvider
                                                  .notifier)
                                          .update((state) => !state);
                                    },
                                    onVerticalDragStart: (details) {
                                      ref
                                          .read(
                                              showDestinationSearchPanelProvider
                                                  .notifier)
                                          .update((state) => !state);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: Colors.white,
                                      child: const Column(
                                        children: [
                                          Gap(80),
                                          Image(
                                            image: AssetImage(
                                                'assets/images/no-results.jpg'),
                                          ),
                                          Text(
                                            'Nothing to show. Try searching',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.search),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blueGrey,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30.0),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blueGrey,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30.0),
                                              ),
                                            ),
                                          ),
                                          controller: searchTextController,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref
                                              .read(
                                                  showDestinationSearchPanelProvider
                                                      .notifier)
                                              .update((state) => !state);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink();
                  })
                ],
              )),
        ],
      ),
    );
  }

  Widget _getOpenedPanelWidget() {
    return _pc.panelPosition == 1.0
        ? const Text('Fully Opened!')
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 20),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => _pc.animatePanelToPosition(
                        1.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.location_on),
                          Gap(10),
                          Text('Where would you like to go to?')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Places of interest',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 5.0,
                      clipBehavior: Clip.hardEdge,
                      child: SizedBox(
                        width: 200,
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
                    ),
                    Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 5.0,
                      clipBehavior: Clip.hardEdge,
                      child: SizedBox(
                        width: 200,
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
                    ),
                    Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 5.0,
                      clipBehavior: Clip.hardEdge,
                      child: SizedBox(
                        width: 200,
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
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
