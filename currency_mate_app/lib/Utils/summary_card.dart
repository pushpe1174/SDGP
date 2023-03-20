import 'package:currency_mate_app/Utils/style.dart';
import 'package:flutter/material.dart';
class SummaryCard extends StatelessWidget {
  const SummaryCard(this.noteValue , this.noteNumber, {super.key});
  final int noteValue;
  final int noteNumber;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 68,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        color: const Color(0xffe1e6dc),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rs. $noteValue",
                    style: Style.numberStyle,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "X",
                    style: Style.numberStyle,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "$noteNumber",
                    style: Style.numberStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
