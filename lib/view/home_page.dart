import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_dog/popup_windows/walk_finish_popup.dart';
import 'package:happy_dog/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:happy_dog/config/ipAddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String? userEmail;
  const HomePage({super.key, required this.userEmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
    return int.parse(digitMinutes) + int.parse(digitHours * 60);
  }

  //reset function
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
    });
  }

  //start function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  bool status = false;
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  String ipAddress = IpAddress.ipAddress;
  int? id;

  void getLastRouteId() async {
    http.Response response =
        await http.get(Uri.parse('http://$ipAddress/lastRouteId'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      id = parsingData['lastId'];

      print('routeListId ---  $id');
    } else {
      print(response.statusCode);
    }
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: WalkFinished(
            hours: digitHours,
            minutes: digitMinutes,
            seconds: digitSeconds,
            routeLastId: id,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initalization();
  }

  List<Marker> markers = [];
  int markerId = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Dog'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                getLastRouteId();
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: googleMapUI()),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 110,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '산책 시간 : $digitHours:$digitMinutes:$digitSeconds',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            reset();
                          },
                          icon: Icon(
                            Icons.settings_backup_restore,
                            color: Colors.green,
                          ),
                          label: Text(
                            '시간 초기화',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          '산책중',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FlutterSwitch(
                            activeColor: Colors.orangeAccent,
                            value: status,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                              if (status == false) {
                                print('산책 종료');
                                int walkingTime = stop();
                                showAlert(context);
                                print('walkingTime : $walkingTime');
                              } else {
                                print('산책 시작');
                                start();
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget googleMapUI() {
    return Consumer<LocationProvider>(builder: (consumeContext, model, child) {
      if (model.locationPosition != null) {
        return Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: model.locationPosition, zoom: 18),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onTap: (LatLng latLng) {
                  Marker newMarker = Marker(
                    markerId: MarkerId('$markerId'),
                    position: LatLng(latLng.latitude, latLng.longitude),
                    infoWindow: InfoWindow(title: 'New place'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                  );
                  markers.add(newMarker);
                  markerId = markerId + 1;
                  setState(() {});
                  print('our lat and lng : $latLng');
                },
                markers: markers.map((e) => e).toSet(),
                onMapCreated: (GoogleMapController controller) {},
              ),
            )
          ],
        );
      }
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
