import 'dart:ui';

import 'package:airme/ui/weatherCity.dart';
import 'package:airme/ui/weatherMain.dart';
import 'package:airme/ui/weatherMe.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          //centerTitle: true,
          title: Text(
            'AirMe',
            style: TextStyle(
                fontSize: 35, color: Color.fromARGB(255, 33, 59, 255)),
          ),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.language_rounded,
                  color: Colors.black,
                  size: 35,
                ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(1, 0, 1, 0),
                //   child: Container(
                //     width: 55,
                //     child: ElevatedButton(
                //       child: Text('TH'),
                //       onPressed: () {
                //         print('Button pressed ...');
                //       },
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                //   child: Container(
                //     width: 55,
                //     child: ElevatedButton(
                //       child: Text('EN'),
                //       onPressed: () {
                //         print('Button pressed ...');
                //       },
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                //   child: Container(
                //     width: 55,
                //     child: ElevatedButton(
                //       child: Text('JP'),
                //       onPressed: () {
                //         print('Button pressed ...');
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.95, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Text(
                      'Situation Report',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.95, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Text(
                      'air quality near me and around the world',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 360,
            height: 301,
            decoration: BoxDecoration(color: Colors.white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/index.jpg',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.95, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Text(
                'Select Item',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: 360,
            height: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherMe()),
                  );
                },
                child: const Text(
                  'My Air Quality',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 76, 89, 227),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: 360,
            height: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherMain()),
                  );
                },
                child: const Text(
                  'Overall Air Quality',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 76, 227, 94),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: 360,
            height: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherCity()),
                  );
                },
                child: const Text(
                  'Air Quality By Country',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 227, 76, 91),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 60,
          // ),
          // Align(
          //     alignment: AlignmentDirectional(0, 0),
          //     child: Padding(
          //       padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          //       child: Column(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          //             child: Text(
          //               'Station data and source:',
          //               style: TextStyle(
          //                 fontFamily: 'Readex Pro',
          //                 fontSize: 15,
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
          //             child: Row(
          //               children: [
          //                 Image.asset(
          //                   'assets/images/logoPm.png', // ตำแหน่งของไฟล์รูปภาพในโฟลเดอร์ assets
          //                   width: 30,
          //                   height: 30,
          //                 ),
          //                 SizedBox(
          //                   width: 10,
          //                 ),
          //                 Text(
          //                   'The World Air Quality Project',
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ))
        ]));
  }
}
