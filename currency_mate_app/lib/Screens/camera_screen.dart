import 'dart:io';
import 'package:currency_mate_app/Api/detection_api.dart';
import 'package:currency_mate_app/Api/send_to_database.dart';
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
    res = await DetectionApi.uploadImage(pickedImage!);
  }

  _setPicture(XFile photo) {
    setState(() {
      pickedImage = File(photo.path);
    });
  }

  _nextScreen(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SummaryScreen(res)),
    );
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
        pickedImage == null?
        Column(
              children: [
                Container(
                  width: 640,
                  height: 480,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(width: 7, color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Icon(Icons.photo),
                ),
                const Gap(40),
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async{
                        _requestPermission();
                      },
                      icon: const Icon(Icons.upload),
                      label: Text(
                          "Upload",
                        style: Style.numberStyle3,
                      ),
                    ),
                  ),
                )
              ],
            ) :
            Column(
              children: [
                Container(
                  width: 640,
                  height: 480,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: DecorationImage(
                        image: FileImage(pickedImage!),
                        fit: BoxFit.cover
                    ),
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                const Gap(40),
                Center(
                  child: FutureBuilder<dynamic>(
                    future: _getDetection(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error loading data');
                      } else {
                        return SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton.icon(
                              onPressed: () async{
                                SendToDatabase database = SendToDatabase(res);
                                await database.sendDatabase();
                                _nextScreen();
                              },
                              icon: const Icon(Icons.check),
                              label: Text(
                                  "Proceed",
                                style: Style.numberStyle3,
                              ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}