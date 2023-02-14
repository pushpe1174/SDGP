import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    setState(() {
      pickedImage = File(photo!.path);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
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
                   onPressed: (){
                     _getImgFromCamera();
                   },
                   child: Text("CLick me"),
                 ),
               ):
               Column(
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.width,
                     child: Image.file(
                         pickedImage!,
                       fit: BoxFit.contain,
                     ),
                   ),
                   const Gap(20),
                   ElevatedButton.icon(
                     onPressed: () {  },
                     icon: const Icon(
                       Icons.check,
                       size: 50,
                     ),
                     label: const Text(
                       "Proceed",
                       style: TextStyle(
                         fontSize: 30,
                       ),
                     ),
                     style: ElevatedButton.styleFrom(
                         padding: const EdgeInsets.fromLTRB(20, 10, 20, 10)
                     ),
                   ),
                 ],
               )
         ],
       ),
    );
  }
}
