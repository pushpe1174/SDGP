import 'dart:io';

import 'package:currency_mate_app/Api/detection_api.dart';
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


  Future<void> _getImgFromCamera() async{
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    setState(() {
      pickedImage = File(photo!.path);
    });
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
          Center(
            child: ElevatedButton(
              onPressed: () async{
              _requestPermission();
              },
              child: const Text("Upload"),
            ),
          ):
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
                            onPressed: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SummaryScreen(res)),
                              );
                            },
                            icon: Icon(Icons.ice_skating),
                            label: Text("Ok"),
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