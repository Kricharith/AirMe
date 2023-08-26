import 'package:airme/ui/connectBluetooth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WeatherMe extends StatefulWidget {
  const WeatherMe({Key? key}) : super(key: key);

  @override
  State<WeatherMe> createState() => _WeatherMeState();
}

class _WeatherMeState extends State<WeatherMe> {
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
          'My Weather Meter',
          style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset('assets/images/cloud.jpg').image,
            fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดีกับพื้นที่
          ),
        ),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('assets/images/bluetooth.png'),
                  width: 200,
                  height: 160,
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConnectBluetooth()),
                    );
                  },
                  child: Text('connect bluetooth'),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Please press the button to connect to the weather meter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        color: Color.fromARGB(255, 41, 41, 41),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
      // body: SafeArea(
      //   top: true,
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.max,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Padding(
      //           padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
      //           child: Container(
      //             width: double.infinity,
      //             height: 420,
      //             decoration: BoxDecoration(
      //               image: DecorationImage(
      //                 fit: BoxFit.cover,
      //                 image: Image.network(
      //                   'https://media.istockphoto.com/id/1183232509/th/%E0%B9%80%E0%B8%A7%E0%B8%84%E0%B9%80%E0%B8%95%E0%B8%AD%E0%B8%A3%E0%B9%8C/%E0%B8%9E%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%8C%E0%B8%95%E0%B8%B9%E0%B8%99%E0%B8%97%E0%B9%89%E0%B8%AD%E0%B8%87%E0%B8%9F%E0%B9%89%E0%B8%B2%E0%B9%80%E0%B8%A1%E0%B8%86-%E0%B8%97%E0%B9%89%E0%B8%AD%E0%B8%87%E0%B8%9F%E0%B9%89%E0%B8%B2%E0%B8%AA%E0%B8%B5%E0%B8%9F%E0%B9%89%E0%B8%B2%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%A1%E0%B8%B5%E0%B9%80%E0%B8%A1%E0%B8%86%E0%B8%AA%E0%B8%B5%E0%B8%82%E0%B8%B2%E0%B8%A7%E0%B9%82%E0%B8%9B%E0%B8%AA%E0%B9%80%E0%B8%95%E0%B8%AD%E0%B8%A3%E0%B9%8C%E0%B9%81%E0%B8%9A%E0%B8%99%E0%B8%AB%E0%B8%A3%E0%B8%B7%E0%B8%AD%E0%B9%83%E0%B8%9A%E0%B8%9B%E0%B8%A5%E0%B8%B4%E0%B8%A7%E0%B9%80%E0%B8%A7%E0%B8%81%E0%B9%80%E0%B8%95%E0%B8%AD%E0%B8%A3%E0%B9%8C%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B9%81%E0%B8%9A%E0%B8%9A.jpg?s=170667a&w=0&k=20&c=n86wuId2KGYr6o4ve7Ybp_kZImzUmPHps8KjNkM80V8=',
      //                 ).image,
      //               ),
      //             ),
      //             child: Align(
      //               alignment: AlignmentDirectional(0, 0),
      //               child: Padding(
      //                 padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
      //                 child: Column(
      //                   mainAxisSize: MainAxisSize.max,
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: [
      //                     Align(
      //                       alignment: AlignmentDirectional(0, -0.65),
      //                       child: Column(
      //                         mainAxisSize: MainAxisSize.min,
      //                         children: [
      //                           ElevatedButton(
      //                             onPressed: () {
      //                               print('Button pressed ...');
      //                               Navigator.pushNamed(
      //                                   context, '/connectBluetooth');
      //                             },
      //                             child: Text('connect bluetooth'),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
