import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetail extends StatelessWidget {
  PlaceDetail({Key? key}) : super(key: key);

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
        title: const Text('Some place'),
      ),
      body: ListView(
        children: [
          Hero(
            tag: 'test',
            child: Image.network(
              'https://aceglassva.com/wp-content/uploads/2014/11/Charming-storefront.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Restoran Amira',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                // const Gap(2),
                // const Row(
                //   children: [
                //     Chip(
                //       backgroundColor: Colors.white,
                //       side: BorderSide(color: Colors.red),
                //       shape: RoundedRectangleBorder(
                //         side: BorderSide(color: Colors.red),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(60),
                //         ),
                //       ),
                //       label: Text(
                //         'Entertainment',
                //         style: TextStyle(
                //           color: Colors.red,
                //           fontSize: 10,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
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
                            vertical: 15, horizontal: 20),
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
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
                    const Gap(5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        foregroundColor: Colors.black87,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.map,
                            size: 10,
                          ),
                          Gap(3),
                          Text('Download Map'),
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
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(
                        'No. 8, 9 & 10, Jalan PPI 2, Pusat Perniagaan Ixora',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                    );
                  },
                  itemCount: 4,
                )
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
