import 'package:airme/ui/weatherCutyUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;

import '../_models/pmCity.dart';

class WeatherCity extends StatefulWidget {
  const WeatherCity({Key? key}) : super(key: key);

  @override
  State<WeatherCity> createState() => _WeatherCityState();
}

class _WeatherCityState extends State<WeatherCity> {
  bool isLoading = true;
  PmCity? apiData;
  List<Datum>? data;
  int aqi = 0;
  int listIndex = 0;
  // void initState() {
  //   super.initState();
  //   print('initState');
  //   getdata();
  // }

  final List<String> items = [
    "AFGANISTAN",
    "ALGERIA",
    "ANDORRA",
    "ARGENTINA",
    "AUSTRALIA",
    "AUSTRIA",
    "BAHRAIN",
    "BANGLADESH",
    "BELGIUM",
    "BOLIVIA",
    "BOSNIA AND HERZEGOVINA",
    "BOSNIA HERZEGOVINA",
    "BRUNEI",
    "BULGARIA",
    "CANADA",
    "CHAD",
    "CHILE",
    "CHINA",
    "COLOMBIA",
    "COSTA RICA",
    "CROATIA",
    "CURACAO",
    "CYPRUS",
    "CZECH REPUBLIC",
    "DENMARK",
    "ECUADOR",
    "EGYPT",
    "ESTONIA",
    "ETHIOPIA",
    "FINLAND",
    "FRANCE",
    "GEORGIA",
    "GERMANY",
    "GHANA",
    "GIBRALTAR",
    "GREECE",
    "GUATEMALA",
    "GUINEA",
    "HONG KONG",
    "HUNGARY",
    "ICELAND",
    "INDIA",
    "INDONESIA",
    "IRAN",
    "IRAQ",
    "IRELAND",
    "ISRAEL",
    "ITALY",
    "IVORY COAST",
    "JAPAN",
    "JORDAN",
    "KAZAKHSTAN",
    "KENYA",
    "KOSOVO",
    "KUWAIT",
    "KYRGYZSTAN",
    "LAOS",
    "LATVIA",
    "LITHUANIA",
    "LUXEMBOURG",
    "MACAO",
    "MACEDONIA",
    "MADAGASCAR",
    "MALAYSIA",
    "MALI",
    "MALTA",
    "MAYNMAR",
    "MEXICO",
    "MONGOLIA",
    "MONTENEGRO",
    "NETHERLANDS",
    "NEW CALEDONIA",
    "NEW ZEALAND",
    "NIGERIA",
    "NORTH KOREA",
    "NORWAY",
    "OMAN",
    "PAKISTAN",
    "PERU",
    "PHILIPPINES",
    "POLAND",
    "PORTUGAL",
    "PUERTO RICO",
    "QATAR",
    "ROMANIA",
    "RUSSIA",
    "SAUDI ARABIA",
    "SERBIA",
    "SINGAPORE",
    "SLOVAKIA",
    "SLOVENIA",
    "SOUTH AFRICA",
    "SOUTH KOREA",
    "SPAIN",
    "SRI LANKA",
    "SWEDEN",
    "SWITZERLAND",
    "TAIWAN",
    "TAJIKISTAN",
    "THAILAND",
    "TRINIDAD AND TOBAGO",
    "TUNISIA",
    "TURKEY",
    "TURKMENISTAN",
    "UAE",
    "UKRAINE",
    "UNITED KINGDOM",
    "UNITED STATES",
    "UNITED STATES OF AMERICA",
    "URUGUAY",
    "UZBEKISTAN",
    "VENEZUELA",
    "VIETNAM",
    "YEMEN",
    "ZAMBIA",
    "ZIMBABWE"
  ];
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 0, 0, 0),
            )),
        title: Text(
          'Air Quality ',
          style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
                    child: Text(
                      'Select Item',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              //Text('${selectedValue}'),
              Container(
                child: Column(
                  children: [
                    FutureBuilder<PmCity?>(
                      future: selectedValue != null ? getdata() : null,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child:
                                CircularProgressIndicator(), // แสดงอินดิเคเตอร์ในระหว่างกำลังดึงข้อมูล
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            physics:
                                NeverScrollableScrollPhysics(), // ไม่อนุญาตให้เลื่อนใน ListView
                            shrinkWrap: true,
                            itemCount:
                                listIndex, // จำนวนรอบที่คุณต้องการแสดง BoxAll
                            itemBuilder: (context, index) {
                              return BoxAll(index);
                            },
                          );
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
                  ],
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
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'Station data and source:',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
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
                  ))
            ],
          ),
        ),
      ),
    );
  }

  //https://api.waqi.info/search/?token=37f877675e52898d4a3dc3bce7c5bd6e3bd3eff4&keyword=japan
  Future<PmCity?> getdata() async {
    String api =
        "https://api.waqi.info/search/?token=37f877675e52898d4a3dc3bce7c5bd6e3bd3eff4&keyword="
        "${selectedValue}";
    var response = await http.get(Uri.parse(api));
    print(response.body);
    print("=============");
    //print(apiData?.data?.iaqi?.pm25?.v);
    apiData = pmCityFromJson(response.body);
    List<Datum>? dataList = apiData!.data;
    listIndex = apiData!.data!.length;
    print(listIndex);
    for (int i = 0; i < apiData!.data!.length; i++) {
      print(dataList![i].station!.name);
      print(dataList![i].station!.url);
    }
    data = dataList;
    // setState(() {
    // });
    return apiData;
  }

//https://api.waqi.info/feed/Mueang%20Chiang%20Rai/?token=37f877675e52898d4a3dc3bce7c5bd6e3bd3eff4
  Widget BoxAll(int index) {
    String input = data![index].station!.url!;
    List<String> words = input.split(" ");
    String filteredText = words.take(words.length - 1).join(" ");

    return GestureDetector(
      onTap: () {
        // ดำเนินการที่คุณต้องการเมื่อ Container ถูกแตะ
        print('Container clicked!${index}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WeatherCutyUi(
                    apiKey: "https://api.waqi.info/feed/"
                        "${input}"
                        "/?token=37f877675e52898d4a3dc3bce7c5bd6e3bd3eff4",
                  )),
        );
        print(input); // Output: "This is"
        print("https://api.waqi.info/feed/"
            "${input}"
            "/?token=37f877675e52898d4a3dc3bce7c5bd6e3bd3eff4");
      },
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
        child: Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: Color(0xFF94CCF9),
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 110, 147, 250),
                Color.fromARGB(255, 38, 123, 250)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.4, 1.0],
            ),
          ),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
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
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                '${getImagePath(int.parse(data![index].aqi!))}',
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
                                '${data![index].aqi}',
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
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 75,
                              width: 250,
                              //color: Color.fromARGB(255, 243, 243, 243),
                              child: Text(
                                "Station: ${data![index].station!.name}",
                                //textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 20,
                                ),
                              ),
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
}
