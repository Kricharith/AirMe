import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../_models/PMdata.dart';

class WeatherForcast extends StatefulWidget {
  const WeatherForcast({Key? key}) : super(key: key);

  @override
  State<WeatherForcast> createState() => _WeatherForcastState();
}

class _WeatherForcastState extends State<WeatherForcast> {
  PMdata? apiData;
  int aqi = 0;
  bool isLoading = true;
  Position? userLocation;
  var o3;
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
          'Dust Forecast',
          style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Container(
        child: isLoading
            ? CircularProgressIndicator() // แสดงอินดิเคเตอร์ระหว่างกำลังรอให้ดึงพิกัด
            : userLocation != null
                ? Container(
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
                                  return ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      //print(data[index]);
                                      return BoxAll(index);
                                    },
                                    itemCount: 7,
                                  );
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
    apiData = pMdataFromJson(response.body);
    aqi = apiData!.data!.aqi!;
    // setState(() {

    // });
    return apiData;
  }

  SafeArea BoxAll(int index) {
    var pm25 = apiData?.data?.forecast?.daily?.pm25?[index].min;
    return SafeArea(
        top: true,
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text('${userLocation?.latitude},${userLocation?.longitude}'),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
              child: Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  color: Color(0xFF94CCF9),
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 44, 149, 235),
                      Color(0xFF75C0FC)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.4, 1.0],
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      '${getImagePath(getCalAqiUS2(pm25!.toInt()).toInt())}',
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
                                      '${getCalAqiUS2(pm25!.toInt()).toInt()}',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'AQI',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF94CCF9),
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 21, 117, 190),
                                            width: 4,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Color.fromARGB(255, 106, 179, 240)
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.4, 1.0],
                                          ),
                                        ),
                                        height: 40,
                                        width: 120,
                                        child: Text(
                                          '${apiData?.data?.forecast?.daily?.pm25?[index].day?.day}/${apiData?.data?.forecast?.daily?.pm25?[index].day?.month}/${apiData?.data?.forecast?.daily?.pm25?[index].day?.year}',
                                          style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 6, 21, 158)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 220,
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          4,
                                                                          6,
                                                                          0),
                                                              child: Text(
                                                                'PM 2.5',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        2,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              '${apiData?.data?.forecast?.daily?.pm25?[index].avg}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                fontSize: 25,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '(µg./m3)',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Readex Pro',
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
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5, 0, 0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            4,
                                                                            12,
                                                                            0),
                                                                    child: Text(
                                                                      'PM 10',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          2,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '${apiData?.data?.forecast?.daily?.pm10?[index].avg}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      fontSize:
                                                                          25,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            8,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '(µg./m3)',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        fontSize:
                                                                            10,
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
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          4,
                                                                          10,
                                                                          0),
                                                              child: Text(
                                                                'O3',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        2,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              '${apiData?.data?.forecast?.daily?.o3?[index].avg}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                fontSize: 25,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '(ppb)',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Readex Pro',
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
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
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

  double getCalAqiUS(int pm25) {
    if (pm25 > 0 && pm25 <= 12) {
      return (((50 - 0) / (12 - 0)) * (pm25 - 0) + 0);
    } else if (pm25 > 12 && pm25 <= 35) {
      return (((100 - 51) / (35 - 13)) * (pm25 - 13) + 51);
    } else if (pm25 > 35 && pm25 <= 55) {
      return (((150 - 101) / (55 - 36)) * (pm25 - 36) + 101);
    } else if (pm25 > 55 && pm25 <= 150) {
      return (((200 - 151) / (150 - 56)) * (pm25 - 56) + 151);
    } else if (pm25 > 150 && pm25 <= 250) {
      return (((300 - 201) / (250 - 151)) * (pm25 - 151) + 201);
    } else if (pm25 > 250 && pm25 <= 500) {
      return (((500 - 301) / (500 - 251)) * (pm25 - 251) + 301);
    } else {
      return (((500 - 301) / (500 - 251)) * (pm25 - 251) + 301);
    }
  }

  double getCalAqiUS2(int pm25) {
    if (pm25 > 0 && pm25 <= 54) {
      return (((50 - 0) / (54 - 0)) * (pm25 - 0) + 0);
    } else if (pm25 > 54 && pm25 <= 154) {
      return (((100 - 51) / (154 - 55)) * (pm25 - 55) + 51);
    } else if (pm25 > 154 && pm25 <= 254) {
      return (((150 - 101) / (254 - 155)) * (pm25 - 155) + 101);
    } else if (pm25 > 254 && pm25 <= 354) {
      return (((200 - 151) / (354 - 255)) * (pm25 - 255) + 151);
    } else if (pm25 > 354 && pm25 <= 424) {
      return (((300 - 201) / (424 - 355)) * (pm25 - 355) + 201);
    } else if (pm25 > 424 && pm25 <= 604) {
      return (((500 - 301) / (604 - 425)) * (pm25 - 425) + 301);
    } else {
      return (((500 - 301) / (604 - 425)) * (pm25 - 425) + 301);
    }
  }
}
