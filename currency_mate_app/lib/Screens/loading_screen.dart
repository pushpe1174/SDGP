import 'package:currency_mate_app/Utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 120.0, 40.0, 0.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Image.asset(
                            'assets/SplashLogo.png'
                        )
                    ),
                    const Gap(10),
                    Text(
                      "currencyMate".toUpperCase(),
                      style: Style.loadingStyle,
                    ),
                    const Gap(25),
                    const SpinKitCircle(
                      color: Color(0xff9EC359),
                      // color: Color(0xffE3BB40),
                      size: 60.0,
                    ),
                  ],
                ),
                Text(
                  "#TeamElite",
                  style: Style.loadingTeamStyle,
                )
              ]
          ),
        ),
      ),
    );
  }
}
