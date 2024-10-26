import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:carbonix/models/product.model.dart';
import 'package:carbonix/models/station.model.dart';
import 'package:carbonix/pages/scanner/trip.screen.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/utils/api_paths.dart';
import 'package:carbonix/utils/network_service.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:carbonix/widgets/product/product.widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:slide_action/slide_action.dart';

class ScanDetailsModalWidget extends StatefulWidget {
  final String stationId;
  final String stationType;
  final int journeyId;
  final String stationName;

  const ScanDetailsModalWidget({
    Key? key,
    required this.stationId,
    required this.stationType,
    required this.journeyId,
    required this.stationName,
  }) : super(key: key);

  @override
  State<ScanDetailsModalWidget> createState() => _ScanDetailsModalWidgetState();
}

class _ScanDetailsModalWidgetState extends State<ScanDetailsModalWidget> {
  Station? _selectedStation, _selectedStationTemp;

  double? _estimatedTokens;

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
  List<Product> _productsList = [
    Product(
      name: 'Avatar: The Last Airbender T-Shirt',
      image: 'images/t-shirt.png',
      completion: 0.56,
      price: 25.0,
      vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _getStations();
  }

  void _getStations() {
    NetworkService().get(
      APIPath.getStations,
      (data) {
        print(data);
        setState(() {
          print(data['body']['data'].map((json) => Station(id: json['id'], name: json['name'], type: json['type'])).toList());
          _stationsList = data['body']['data'].map((json) => Station(id: json['id'], name: json['name'], type: json['type'])).toList();
        });
      },
      print,
      () {},
    );
  }

  void _calculateTripTokens() {
    NetworkService().post(
      APIPath.estimateDistance,
      {'start_id': widget.stationId, 'end_id': _selectedStation!.id},
      (data) {
        setState(() {
          _estimatedTokens = data['body']['data'];
        });
      },
      (error) {
        print(error);
      },
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_stationsList);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: Container(
          height: screenHeight,
          padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.stationType} Ride',
                  style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Starting at ${widget.stationName} and',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'travelling to ',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(color: ThemeColors.text, width: 1.0),
                            )),
                            child: Pressable(
                              onPressed: () async {
                                await showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    print(_stationsList);
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text('Select an end location'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            _selectedStation != null
                                                ? CustomDropdown<Station>.search(
                                                    initialItem: _selectedStation,
                                                    hintText: 'Select station',
                                                    items: _stationsList,
                                                    excludeSelected: false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedStationTemp = value;
                                                      });
                                                    },
                                                  )
                                                : CustomDropdown<Station>.search(
                                                    hintText: 'Select station',
                                                    items: _stationsList,
                                                    excludeSelected: false,
                                                    onChanged: (value) {
                                                      setState(
                                                        () {
                                                          _selectedStationTemp = value;
                                                        },
                                                      );
                                                    },
                                                  ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Pressable(
                                          onPressed: () {
                                            setState(() {
                                              _selectedStation = _selectedStationTemp;
                                            });
                                            _calculateTripTokens();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Confirm',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700,
                                              color: ThemeColors.darkGreen,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                _selectedStation == null ? 'select a location' : _selectedStation!.name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                      decoration: const BoxDecoration(
                        color: ThemeColors.darkGreen,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '0.001',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth - 182,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.0),
                          Text(
                            'Tokens/km',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'You earn \$0.5 per km on this trip',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  // decoration: const BoxDecoration(
                  //   color: Colors.white,
                  //   boxShadow: const [
                  //     BoxShadow(
                  //       color: Color.fromRGBO(217, 217, 217, 0.5),
                  //       offset: Offset(5, 13),
                  //       blurRadius: 40.0,
                  //     ),
                  //   ],
                  // ),
                  // padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You will earn ~${_estimatedTokens != null ? _estimatedTokens!.toStringAsFixed(4) : '-'} CRBX by completing this trip',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Text(
                      //   'This equates to about \$25',
                      //   style: TextStyle(
                      //     fontSize: 18.0,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Transfer to wish?',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'You can add this later too.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10.0),
                ProductWidget(
                    onPress: () {
                      setState(() {
                        _productsList[0].active = !_productsList[0].active;
                      });
                    },
                    product: _productsList[0]),
                const SizedBox(height: 30.0),
                SlideAction(
                  trackBuilder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(217, 217, 217, 0.5),
                            offset: Offset(5, 13),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Swipe to start journey",
                        ),
                      ),
                    );
                  },
                  stretchThumb: true,
                  thumbBuilder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ThemeColors.darkGreen,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  action: () {
                    Navigator.of(context).push(
                      MaterialWithModalsPageRoute(
                        builder: (_) => TripScreen(
                          stationId: widget.stationId,
                          journeyId: widget.journeyId,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
