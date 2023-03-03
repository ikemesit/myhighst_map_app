import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;

  final LatLng _center = AppConstants.myLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  TextEditingController origin = TextEditingController();
  TextEditingController destination = TextEditingController();

  @override
  void initState() {
    origin.text = "";
    destination.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    padding:
                        const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                    textStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            children: [
                              const Text(
                                'Enter your trip details',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: TextField(
                                  controller: origin,
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.drive_eta),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: InputBorder.none,
                                      border: OutlineInputBorder(),
                                      hintText: "Your start location",
                                      focusedBorder: OutlineInputBorder(),
                                      focusColor: Colors.transparent),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: TextField(
                                  controller: destination,
                                  decoration: const InputDecoration(
                                    hintText: "Your destination",
                                    icon: Icon(Icons.location_on),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(),
                                    focusColor: Colors.transparent,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: const Text('Start a trip')),
          )
        ],
      ),
    );
  }
}
