import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/screens/profile-page.dart';
import 'package:myhighst_map_app/widgets/listing-preview.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../app_constants.dart';
import '../services/auth.dart';
import 'login_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  late GoogleMapController mapController;

  final LatLng _center = AppConstants.myLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final PanelController _pc = PanelController();
  bool panelFullyOpened = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.0,
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
              vertical: 20.0,
              horizontal: 10.0,
            ),
            controller: _pc,
            onPanelOpened: () {},
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
                      const ListingPreview(),
                      const ListingPreview(),
                      const ListingPreview(),
                      const ListingPreview(),
                      Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        elevation: 5.0,
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: InkWell(
                            onTap: () {},
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                const Text(
                  'Account & Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 5.0,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          final user = ref.read(authStateProvider).value;

                          if (user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                BorderRadius.circular(60)),
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
                    const Gap(5),
                    Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 5.0,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                BorderRadius.circular(60)),
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
              ],
            ),
          ),
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
