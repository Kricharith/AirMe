import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../_models/PMdata.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherAll extends StatefulWidget {
  const WeatherAll({Key? key}) : super(key: key);

  @override
  State<WeatherAll> createState() => _WeatherAllState();
}

class _WeatherAllState extends State<WeatherAll> {
  Position? userLocation;
  PMdata? apiData;
  bool isLoading = true;
  int aqi = 0;
  String location = "";
  void initState() {
    super.initState();
    print('initState');
    _getLocation().then((position) {
      setState(() {
        userLocation = position;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print('Error while getting user location: $error');
    });
  }

//   Future<Position> _getLocation() async {
//     try {
//       userLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//     } catch (e) {
//       userLocation = null;
//     }
//     return userLocation;
//   }
  Future<Position> _getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    getdata();
    return userLocation!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        //centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Overall Air Quality',
          style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // แสดงอินดิเคเตอร์ระหว่างกำลังรอให้ดึงพิกัด
            : userLocation != null
                ? Center(
                    child: FutureBuilder<PMdata?>(
                      future: getdata(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child:
                                CircularProgressIndicator(), // แสดงอินดิเคเตอร์ในระหว่างกำลังดึงข้อมูล
                          );
                        } else if (snapshot.hasData) {
                          return FutureBuilder(
                              future: _getLocation(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return BoxAll();
                                } else {
                                  return Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          CircularProgressIndicator(),
                                        ]),
                                  );
                                }
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                'Error: ${snapshot.error}'), // แสดงข้อความ Error ถ้าเกิดข้อผิดพลาด
                          );
                        } else {
                          return Center(
                            child: Text('No Data'), // แสดงข้อความหากไม่มีข้อมูล
                          );
                        }
                      },
                    ),
                  )
                : Text('User Location not available'),
      ),
    );
  }

  Future<PMdata?> getdata() async {
    String api = "https://api.waqi.info/feed/geo:"
        "${userLocation!.latitude}"
        ";"
        "${userLocation!.longitude}"
        "/?token=37f877675e52898d4a3dc3bce7c5bd6e3bd3eff4";
    var response = await http.get(Uri.parse(api));
    // var result = json.decode(response.body);
    print(response.body);
    print("=============");
    // print(apiData?.data?.iaqi?.pm25?.v);
    apiData = pMdataFromJson(response.body);
    aqi = apiData!.data!.aqi!;
    location = apiData!.data!.city!.name!;
    // setState(() {
    // });
    return apiData;
  }

  Widget BoxAll() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Text('${userLocation!.latitude},${userLocation!.longitude}'),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.black,
                    size: 30,
                  ),
                  SizedBox(width: 10), // กำหนดระยะห่างระหว่าง Icon และ Text
                  Expanded(
                    child: Text(
                      '${location}',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 15,
                      ),
                      softWrap: true, // แสดงบรรทัดใหม่
                      textAlign: TextAlign.start, // การจัดตำแหน่งข้อความ
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/cloud4.jpg',
                    ).image,
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -0.65),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      getImagePath(aqi),
                                    ).image,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${apiData?.data?.aqi}',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 60,
                                      ),
                                    ),
                                    Text(
                                      'AQI',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            getquality(aqi),
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Text(
                            '${formattedDate}',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15, 4, 20, 0),
                                            child: Text(
                                              'PM 1.0',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              '${apiData?.data?.iaqi?.pm10?.v?.toInt()}',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 0),
                                              child: Text(
                                                '(µg./m3)',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 15, 0),
                                            child: Text(
                                              'PM 2.5',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              '${apiData?.data?.iaqi?.pm25?.v?.toInt()}',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 0),
                                              child: Text(
                                                '(µg./m3)',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 4, 10, 0),
                                            child: Text(
                                              'PM 10',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 5, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 5, 0),
                                            child: Text(
                                              '${apiData?.data?.iaqi?.pm10?.v?.toInt()}',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 0),
                                              child: Text(
                                                '(µg./m3)',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 4, 20, 0),
                                            child: Text(
                                              'Temp',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 20, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              '${apiData?.data?.iaqi?.t?.v?.toInt()}',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 0),
                                              child: Text(
                                                '(°C)',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 40, 0),
                                                child: Text(
                                                  'O3',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 10, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 2, 0, 0),
                                              child: Text(
                                                '${apiData?.data?.iaqi?.o3?.v}',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 8, 0, 0),
                                                child: Text(
                                                  '(ppb)',
                                                  style: TextStyle(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 26, 0),
                                              child: Text(
                                                'NO2',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              '${apiData?.data?.iaqi?.no2?.v}',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 10, 0),
                                              child: Text(
                                                '(ppb)',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 30, 0),
                                            child: Text(
                                              'CO',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              '${apiData?.data?.iaqi?.co?.v}',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 8, 0),
                                              child: Text(
                                                '(ppm)',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 26, 0),
                                            child: Text(
                                              'hum',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              '${apiData?.data?.iaqi?.h?.v?.toInt()}',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 0),
                                              child: Text(
                                                '(g/m3)',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      'Health Advice:',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          getadvice(aqi),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      'Station data and source:',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/logoPm.png', // ตำแหน่งของไฟล์รูปภาพในโฟลเดอร์ assets
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'The World Air Quality Project',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getImagePath(int aqi) {
    if (aqi > 0 && aqi <= 50) {
      return 'assets/images/green2.png';
    } else if (aqi > 50 && aqi <= 101) {
      return 'assets/images/yellow2.png';
    } else if (aqi > 101 && aqi <= 150) {
      return 'assets/images/orange2.png';
    } else if (aqi > 150 && aqi <= 200) {
      return 'assets/images/red2.png';
    } else if (aqi > 200 && aqi <= 300) {
      return 'assets/images/purple2.png';
    } else {
      return 'assets/images/purple22.png';
    }
  }

  String getquality(int aqi) {
    if (aqi > 0 && aqi <= 50) {
      return 'Good air quality'; //air quality is very good. คุณภาพอากาศดี
    } else if (aqi > 50 && aqi <= 101) {
      return 'Moderate air quality'; // moderate air quality คุณภาพอากาศปลานกลาง
    } else if (aqi > 101 && aqi <= 150) {
      return 'Unhealthy'; // unhealthy ไม่ดีต่อสุขภาพ
    } else if (aqi > 150 && aqi <= 200) {
      return 'Moderately unhealthy'; //Moderately unhealthy ไม่ดีต่อสุขภาพมาก
    } else if (aqi > 200 && aqi <= 300) {
      return 'Very Unhealthy'; // Very Unhealthy ไม่ดีต่อสุขภาพอย่างมาก
    } else {
      return 'Hazardous'; //อันตรายอย่างมาก
    }
  }

  String getadvice(int aqi) {
    if (aqi > 0 && aqi <= 50) {
      return 'good air quality Able to do outdoor activities and travel as usual';
      //	คุณภาพอากาศดี สามารถทำกิจกรรมกลางแจ้งและท่องเที่ยวได้ตามปกติ  good air quality Able to do outdoor activities and travel as usual
    } else if (aqi > 50 && aqi <= 101) {
      return 'People can continue their activities as usual.';
      //ประชาชนสามารถดำเนินกิจกรรมต่างๆ ได้ตามปกติ  People can continue their activities as usual.
    } else if (aqi > 101 && aqi <= 150) {
      return 'Avoid ventilating the building with outside air. and close the window completely Do not let outside air interfere';
      // หลีกเลี่ยงการระบายอากาศในอาคารด้วยอากาศภายนอก และปิดหน้าต่างให้มิดชิด ไม่ให้อากาศภายนอกเข้ามารบกวน Avoid ventilating the building with outside air. and close the window completely Do not let outside air interfere
    } else if (aqi > 150 && aqi <= 200) {
      return 'should check health If there are initial symptoms such as coughing, difficulty breathing, and eye irritation, the duration of outdoor activities should be reduced. or use personal protective equipment if necessary.';
      //ควรเฝ้าระวังสุขภาพ ถ้ามีอาการเบื้องต้น เช่น ไอ หายใจลาบาก ระคาย เคืองตา ควรลดระยะเวลาการทำกิจกรรมกลางแจ้ง หรือใช้อุปกรณ์ป้องกันตนเองหากมีความจำเป็น
      //should check health If there are initial symptoms such as coughing, difficulty breathing, and eye irritation, the duration of outdoor activities should be reduced. or use personal protective equipment if necessary.
    } else if (aqi > 200 && aqi <= 300) {
      return 'All citizens should avoid outdoor activities. Avoid areas with high air pollution. or use personal protective equipment if necessary. If you have any health symptoms, you should see a doctor.';
      // ประชาชนทุกคนควรหลีกเลี่ยงกิจกรรมกลางแจ้ง หลีกเลี่ยงพื้นที่ที่มีมลพิษทางอากาศสูง หรือใช้อุปกรณ์ป้องกันตนเองหากมีความจำเป็น หากมีอาการทางสุขภาพควรพบแพทย์
      //All citizens should avoid outdoor activities. Avoid areas with high air pollution. or use personal protective equipment if necessary. If you have any health symptoms, you should see a doctor.
    } else {
      return 'All citizens should avoid outdoor activities. Avoid areas with high air pollution. or use personal protective equipment if necessary. If you have any health symptoms, you should see a doctor.'; //อันตรายอย่างมาก
    }
  }
}
