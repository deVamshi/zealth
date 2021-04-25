import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:zealth/models/symptom_model.dart';
import 'package:zealth/utils/constants.dart';
import 'package:zealth/utils/helpers.dart';

class SymptomItem extends StatelessWidget {
  Symptom symptom;
  bool isSelected;
  SymptomItem({this.symptom, this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 104,
        width: 76,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  symptom.imgPath,
                  width: 48,
                  height: 48,
                ),
                EmptyVerticalBox(
                  height: 5,
                ),
                Text(
                  symptom.symptomName,
                  style: AppTexts.h7,
                )
              ],
            ),
            isSelected
                ? Center(
                    child: Icon(
                      LineAwesomeIcons.check_circle,
                      color: AppColors.BLACKTHICK,
                    ),
                  )
                : Text("")
          ],
        ));
  }
}
