import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/style.dart';

class DetectCurrency extends StatefulWidget {
  const DetectCurrency({Key? key}) : super(key: key);

  @override
  State<DetectCurrency> createState() => _DetectCurrencyState();
}

class _DetectCurrencyState extends State<DetectCurrency> {

  File? pickedImage;
  Future<void> _getImgFromCamera() async{
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = File(photo!.path);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getImgFromCamera();
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
            pickedImage != null ?
            Image.file(pickedImage!) :
            const Text("No image selected")
          ],
        )
    );
  }
}
