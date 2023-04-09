import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:currency_mate_app/Screens/login_screen.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5),(){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen())
      );
    });


    return Scaffold(
      backgroundColor: Style.bgColor,
      body: Column(
        children: [
          const Gap(60),
          Expanded(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 12.0, 40.0, 0.0),
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

                            AnimatedTextKit(animatedTexts: [
                              TypewriterAnimatedText(
                                "currencyMate".toUpperCase(),
                                textStyle: Style.loadingStyle,
                                speed: const Duration(milliseconds: 200)
                              )
                            ],),
                            const Gap(10),
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
          ))

        ],

      ),
    );

  }













}
