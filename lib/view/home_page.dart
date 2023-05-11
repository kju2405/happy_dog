import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_dog/popup_windows/walk_finish_popup.dart';
import 'package:happy_dog/provider/location_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String? userEmail;
  const HomePage({super.key, required this.userEmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: WalkFinished(),
        );
      },
    );
  }

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initalization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('산책'),
      //   backgroundColor: Color.fromARGB(255, 13, 128, 23),
      // ),
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
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '산책 시간 : 00시00분',
                      style: TextStyle(fontSize: 20),
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
                                showAlert(context);
                              } else {
                                print('산책 시작');
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
