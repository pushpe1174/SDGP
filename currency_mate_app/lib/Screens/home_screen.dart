import 'package:currency_mate_app/Screens/camera_screen.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,

      appBar: AppBar(
        title: Text(
          "Home",
          style: Style.headingStyle,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1D3557),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
        child: Container(
          // color: Colors.redAccent,
          child: Center(
            child: Column(
              children: [
                const Gap(15),
                SizedBox(
                  width: 300,
                  height: 180,
                  child: ElevatedButton(

                    onPressed: (){
                      Navigator.pushNamed(context, '/detect_currency');
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/DetectCurrency.png',
                          height: 100,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "Detect Currency",
                          style: Style.headingStyle2,
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(15),
                SizedBox(
                  width: 300,
                  height: 180,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/PreviousRecord.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          " Records",
                          style: Style.headingStyle2,
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(15),
                SizedBox(
                  width: 300,
                  height: 180,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/UploadImage.jpg',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "Upload Currency",
                          style: Style.headingStyle2,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
