import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:zealth/models/symptom_model.dart';
import 'package:zealth/utils/constants.dart';
import 'package:zealth/utils/helpers.dart';
import 'package:zealth/views/symptoms/symptom_detail.dart';
import 'package:zealth/views/symptoms/symptoms_components/symptom_item.dart';

class SymptomsScreen extends StatefulWidget {
  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  List<Symptom> selectedSymptoms = [];
  List<Symptom> allSymptoms = [
    Symptom(
        symptomName: "Fatigue",
        imgPath: "assets/images/fatigue.png",
        severityLevelText: [
          "Able to do most activities",
          "In bed less than 50% of the day",
          "In bed more than 50% of the day"
        ]),
    Symptom(
        symptomName: "Vomiting",
        imgPath: "assets/images/vomit.png",
        severityLevelText: [
          "Vomited once during the day",
          "Vomited 2-5 times during the day",
          "Vomited 6 or more times during the day"
        ]),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmptyVerticalBox(),
          Text("Search & Add your symptoms", style: AppTexts.h5),
          EmptyVerticalBox(
            height: 16,
          ),
          Container(
            height: 48,
            child: TextField(
              autofocus: false,
              cursorColor: AppColors.PINK,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  bottom: 48 / 2,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: AppColors.PRIMARYTITLE, width: 1)),
                prefixIcon: selectedSymptoms.isEmpty
                    ? Icon(
                        Icons.search,
                        color: Color(0xff272755),
                      )
                    : Row(children: [
                        for (Symptom symp in selectedSymptoms)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSymptoms.remove(symp);
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    symp.imgPath,
                                    width: 26,
                                    height: 26,
                                  ),
                                  EmptyHorizontalBox(
                                    width: 2,
                                  ),
                                  Text(
                                    symp.symptomName,
                                    style: AppTexts.p4,
                                  )
                                ],
                              ),
                            ),
                          )
                      ]),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (selectedSymptoms.isEmpty) return;
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SymptomDetail(
                                    listOfSelectedSymptoms: selectedSymptoms,
                                  )));
                    },
                    child: Chip(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      backgroundColor: selectedSymptoms.isEmpty
                          ? Color(0xffeaeff4)
                          : Color(0xffffe9e4),
                      label: Text(
                        "Check",
                        style: selectedSymptoms.isEmpty
                            ? AppTexts.h7
                            : TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.PINK),
                      ),
                    ),
                  ),
                ),
                hintText: selectedSymptoms.isEmpty ? "Search symptoms" : "",
                hintStyle: AppTexts.p4,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffa5b2be), width: 1)),
              ),
            ),
          ),
          EmptyVerticalBox(),
          Text("Suggested symptoms", style: AppTexts.h7),
          EmptyVerticalBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (Symptom symp in allSymptoms)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedSymptoms.contains(symp)) {
                        selectedSymptoms.remove(symp);
                      } else {
                        selectedSymptoms.add(symp);
                      }
                    });
                  },
                  child: SymptomItem(
                    symptom: symp,
                    isSelected: selectedSymptoms.contains(symp) ? true : false,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

