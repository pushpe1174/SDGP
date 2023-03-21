import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Utils/style.dart';

class UploadCurrency extends StatefulWidget {
  const UploadCurrency({Key? key}) : super(key : key);

  @override
  State<UploadCurrency> createState() => _UploadCurrencyState();
}

class _UploadCurrencyState extends State<UploadCurrency> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Currency', style: Style.headingStyle),
        centerTitle: true,
        backgroundColor: const Color(0xff1D3557),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(imageFile != null)
              Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                      image: FileImage(imageFile!),
                      fit: BoxFit.cover
                  ),
                  border: Border.all(width: 7, color: Colors.black),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              )
            else
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1D3557)),
                    onPressed: ()=> getImage(source: ImageSource.camera),
                    child: const Text('Capture Image', style: TextStyle(fontSize: 20))
                    ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1D3557)),
                      onPressed: ()=> getImage(source: ImageSource.gallery),
                      child: const Text('Select Image', style: TextStyle(fontSize: 20))
                    ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
      source: source,
      maxWidth: 640,
      maxHeight: 480,
      imageQuality: 70
    );
    if(file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}