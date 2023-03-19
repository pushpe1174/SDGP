import 'dart:io';

import 'package:currency_mate_app/Api/detection_api.dart';
import 'package:currency_mate_app/Api/send_to_Database.dart';
import 'package:currency_mate_app/Screens/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Utils/style.dart';

class DetectCurrency extends StatefulWidget {
  const DetectCurrency({Key? key}) : super(key: key);

  @override
  State<DetectCurrency> createState() => _DetectCurrencyState();
}

class _DetectCurrencyState extends State<DetectCurrency> {

  File? pickedImage;
  late Map<int,int> res;

  _requestPermission() async{
    PermissionStatus cameraStatus = await Permission.camera.request();
    if(cameraStatus == PermissionStatus.granted){
      _getImgFromCamera();
    }
    if(cameraStatus == PermissionStatus.permanentlyDenied){
      openAppSettings();
    }
  }

  _getDetection() async{
    res = await DetectionApi.uploadImage(pickedImage);
  }

  _setPicture(XFile photo) {
    setState(() {
      pickedImage = File(photo.path);
    });
  }


  Future<void> _getImgFromCamera() async{
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if(photo != null){
      _setPicture(photo);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detect Currency",
          style: Style.headingStyle,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1D3557),
        elevation: 0,
      ),
      body: Column(
        children: [
      pickedImage == null?
      Column(
            children: [
              Container(
                color: Colors.lightBlue,
                height: 400,
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/uploadLogo.png')),
                ),
              ),
              const Gap(70),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async{
                    _requestPermission();
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text("Upload"),
                ),
              )
            ],
          ) :
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Image.file(
                  pickedImage!,
                  fit: BoxFit.contain,
                ),
              ),
              const Gap(20),
              SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: FutureBuilder<dynamic>(
                    future: _getDetection(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error loading data');
                      } else {
                        // return Text(res.toString());
                        return ElevatedButton.icon(
                            onPressed: () async{
                              SendToDatabase database = SendToDatabase(res);
                              database.sendDatabase();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SummaryScreen(res)),
                              );
                            },
                            icon: const Icon(Icons.ice_skating),
                            label: const Text("Ok"),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}