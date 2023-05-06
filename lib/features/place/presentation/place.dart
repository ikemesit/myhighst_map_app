import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class Place extends StatelessWidget {
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

  Place({
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

  final Uri _url = Uri.parse('https://www.google.com/maps/dir/KLIA+(KUL),'
      '+Kuala+Lumpur+International+Airport,+Sepang,+Selangor,'
      '+Malaysia/MYHIGHST+BUSINESS+SERVICES,+137,+Lorong+Haruan+5%2F5,'
      '+Oakland+Commercial+Centre,+70300+Seremban,+Negeri+Sembilan,'
      '+Malaysia/@2.7778777,101.718259,12z/data=!3m1!4b1!4m13!4m12!1m5!'
      '1m1!1s0x31cdbf80d4a21211:0x982778bb67b5fa0b!2m2!1d101'
      '.7015569!2d2.7417476!1m5!1m1!1s0x31cde7dde99a4887'
      ':0x3ad430e72cd24174!2m2!1d101.9183465!2d2.7035828');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Hero(
              tag: title,
              child: Image.network(
                images[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    const Gap(5),
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          overflow: TextOverflow.fade,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 15,
                        ),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      onPressed: _launchUrl,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.near_me_sharp,
                            size: 10,
                          ),
                          Gap(3),
                          Text('Get directions')
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                const Divider(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                ),
                const Gap(20),
                Text(description),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
