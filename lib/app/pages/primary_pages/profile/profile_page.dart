import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/profile_body.dart';
import 'package:text/app/pages/primary_pages/profile/profile_header.dart';

import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';


import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MapSample();
    // Column(
    //   children: [
    //   const ProfileHeader(),
    //   ProfileBody(),
    // ]);
  }
}






class MyButtonString extends StatelessWidget {
  const MyButtonString({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ThemeAppSize.kInterval12,
        vertical: ThemeAppSize.kInterval5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.primaryColor),
        borderRadius: BorderRadius.all(
          Radius.circular(
            ThemeAppSize.kRadius12 / 2,
          ),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          SmallText(
            text: text,
            color: context.theme.primaryColor,
          ),
        ],
      ),
    );
  }
}





class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
