import 'package:carbonix/models/station.model.dart';
import 'package:carbonix/models/trip.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final Trip trip;
  List<Station> _stationsList = [
    Station(id: '6f2dd67894364cfa89afa0e02c1931e1', name: 'Churchgate', type: 'Train'),
    Station(id: '4398ff9f2cc9442f9a1f505c1b058c0d', name: 'Marine Lines', type: 'Train'),
    Station(id: 'c95178c33b5a45beabd53fd140fac157', name: 'Charni Road', type: 'Train'),
    Station(id: '371c600096f743189dab2c5ca8869699', name: 'Grant Road', type: 'Train'),
    Station(id: '38f0f37ebf254681915334a87e072447', name: 'Mumbai Central', type: 'Train'),
    Station(id: '98a5275d664d4a66af3c0b9e7dcf6310', name: 'Mahalakshmi', type: 'Train'),
    Station(id: 'd49f585682da40c59b248b1c7b32fd6f', name: 'Lower Parel', type: 'Train'),
    Station(id: 'd9a3f90cdfa74feea57c174165f5e363', name: 'Prabhadevi', type: 'Train'),
    Station(id: '0ece1c0227c74f23943add38f9ef306f', name: 'Dadar', type: 'Train'),
    Station(id: '276915c725414454b51bc456bfb2ac3c', name: 'Matunga Road', type: 'Train'),
    Station(id: '6e2a6bf142b449d692c800a859f5e5f8', name: 'Mahim Junction', type: 'Train'),
    Station(id: 'c37670f589cb4964ba51a5534949c978', name: 'Bandra', type: 'Train'),
    Station(id: '8935b3487107492e8a4bfc1c45fe82c0', name: 'Khar Road', type: 'Train'),
    Station(id: '1449da89ba544f94885ffef52636fb20', name: 'Santa Cruz', type: 'Train'),
    Station(id: 'e072b56f2d034a2189e2274319f856bb', name: 'Vile Parle', type: 'Train'),
    Station(id: '618949e1d5d74ef08bfdc5061bd003c8', name: 'Andheri', type: 'Train'),
    Station(id: '610d42f15dd240f29e7c9a7825c2a764', name: 'Jogeshwari', type: 'Train'),
    Station(id: '11851fb8839e49a6b9d6ca31e4c87442', name: 'Ram Mandir', type: 'Train'),
    Station(id: 'b8b15bff31ca4e71a40353c031c5ff1a', name: 'Goregaon', type: 'Train'),
    Station(id: '332c7d2b078a49f6bb5655e802ffc1b7', name: 'Malad', type: 'Train'),
    Station(id: 'a374fde97d044fb2a7432f2b712e174f', name: 'Kandivali', type: 'Train'),
    Station(id: '74c377629ae74ed395dea514cf904afb', name: 'Borivali', type: 'Train')
  ];

  History({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    String startStation = _stationsList.firstWhere((station) => station.id == trip.startStation.replaceAll("-", "")).name;
    String endStation = _stationsList.firstWhere((station) => station.id == trip.endStation.replaceAll("-", "")).name;
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        width: 250.0,
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(30.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(217, 217, 217, 0.45),
                    offset: Offset(5, 13),
                    blurRadius: 40.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Metro Ride',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 18.0,
                        color: ThemeColors.text.withOpacity(0.7),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  RichText(
                    text: TextSpan(
                        text: 'You travelled ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: ThemeColors.text,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          const TextSpan(
                            text: 'from ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '$startStation ',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(
                            text: 'to ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: endStation,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: ThemeColors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
