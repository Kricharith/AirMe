import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeUI extends StatefulWidget {
  final double temperature;
  final double pm25;
  final double pm10;
  final double pm1;
  const HomeUI(
      {Key? key,
      required this.temperature,
      required this.pm25,
      required this.pm10,
      required this.pm1})
      : super(key: key);
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: 420,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/cloud2.jpg',
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
                                      image: Image.asset(getImagePathUS(
                                              getCalAqiUS(widget.pm25)))
                                          .image,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${getCalAqiUS(widget.pm25).round()}',
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              getqualityUS(getCalAqiUS(widget.pm25)),
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: Text(
                              '${formattedDate}',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Row(
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
                                                  5, 4, 30, 0),
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
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 2, 0, 0),
                                        child: Text(
                                          '${widget.pm1.round()}',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
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
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 2, 0, 0),
                                        child: Text(
                                          '${widget.pm25.round()}',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
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
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 2, 0, 0),
                                        child: Text(
                                          '${widget.pm10.round()}',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
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
                                                  0, 4, 25, 0),
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
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 2, 0, 0),
                                        child: Text(
                                          '${widget.temperature.round()}',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
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
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Text(
                              'health advice:',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                            child: Text(
                              getadviceUS(getCalAqiUS(widget.pm25)),
                            ),
                          ),
                        ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  //AQI = ((AQIHigh - AQILow) / (ConcHigh - ConcLow)) * (Concentration - ConcLow) + AQILow
  double getCalAqi(double pm25) {
    if (pm25 > 0 && pm25 <= 25) {
      return (((25 - 0) / (25 - 0)) * (pm25 - 0) + 0);
    } else if (pm25 > 25 && pm25 <= 37) {
      return (((50 - 26) / (37 - 26)) * (pm25 - 26) + 26);
    } else if (pm25 > 37 && pm25 <= 50) {
      return (((100 - 51) / (50 - 38)) * (pm25 - 38) + 51);
    } else if (pm25 > 50 && pm25 <= 90) {
      return (((200 - 101) / (90 - 51)) * (pm25 - 51) + 101);
    } else {
      return (((100) / (91)) * (pm25 - 91) + 200);
    }
  }

  double getCalAqiUS(double pm25) {
    if (pm25 > 0 && pm25 <= 12) {
      return (((50 - 0) / (12 - 0)) * (pm25 - 0) + 0);
    } else if (pm25 > 12 && pm25 <= 35) {
      return (((100 - 51) / (32 - 13)) * (pm25 - 13) + 51);
    } else if (pm25 > 35 && pm25 <= 55) {
      return (((150 - 101) / (55 - 36)) * (pm25 - 16) + 101);
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

  String getImagePath(double aqi) {
    if (aqi > 0 && aqi <= 25) {
      return 'assets/images/blue.png';
    } else if (aqi > 25 && aqi <= 50) {
      return 'assets/images/green.png';
    } else if (aqi > 50 && aqi <= 100) {
      return 'assets/images/yellow.png';
    } else if (aqi > 100 && aqi <= 200) {
      return 'assets/images/red.png';
    } else {
      return 'assets/images/red.png';
    }
  }

  String getImagePathUS(double aqi) {
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

  String getquality(double aqi) {
    if (aqi > 0 && aqi <= 25) {
      return 'คุณภาพอากาศดีมาก';
    } else if (aqi > 25 && aqi <= 50) {
      return 'คุณภาพอากาศดี';
    } else if (aqi > 50 && aqi <= 100) {
      return 'คุณภาพอากาศปานกลาง';
    } else if (aqi > 100 && aqi <= 200) {
      return 'คุณภาพอากาศเริ่มแย่';
    } else {
      return 'คุณภาพอากาศแย่มาก';
    }
  }

  String getqualityUS(double aqi) {
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

  String getadviceUS(double aqi) {
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

  String getadvice(double aqi) {
    if (aqi > 0 && aqi <= 25) {
      return 'คุณสามารถเพลิดเพลินกับกิจกรรมกลางแจ้งตามปกติได้ คุณอาจเลือกเปิดหน้าต่างและระบายอากาศในบ้านเพื่อให้ได้รับอากาศภายนอก';
    } else if (aqi > 25 && aqi <= 50) {
      return 'คุณสามารถเพลิดเพลินกับกิจกรรมกลางแจ้งได้ตามปกติ';
    } else if (aqi > 50 && aqi <= 100) {
      return 'หลีกเลี่ยงการระบายอากาศภายในอาคารด้วยอากาศภายนอก และปิดหน้าต่างเพื่อหลีกเลี่ยงไม่ ให้มลพิษทางอากาศภายนอกอาคารภายในอาคาร ';
    } else if (aqi > 100 && aqi <= 200) {
      return 'คุณภาพอากาศไม่ดีต่อสุขภาพสำหรับกลุ่มที่บอบบาง ทุกคนมีความเสี่ยงที่จะระคายเคืองตา ผิวหนัง และลำคอ รวมถึงปัญหาระบบทางเดินหายใจ ประชาชนควรลดการออกแรงกลางแจ้งอย่างมาก';
    } else {
      return 'ทุกคนควรหลีกเลี่ยงและสวมหน้ากากป้องกันมลพิษกลางแจ้ง หมดกำลังใจในการระบายอากาศ ควรเปิดเครื่องฟอกอากาศ';
    }
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
