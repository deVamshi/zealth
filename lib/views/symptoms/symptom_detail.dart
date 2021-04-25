import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:zealth/models/symptom_model.dart';
import 'package:zealth/services/api_service.dart';
import 'package:zealth/utils/constants.dart';
import 'package:zealth/utils/helpers.dart';

class SymptomDetail extends StatefulWidget {
  List<Symptom> listOfSelectedSymptoms;
  SymptomDetail({this.listOfSelectedSymptoms});

  @override
  _SymptomDetailState createState() => _SymptomDetailState();
}

class _SymptomDetailState extends State<SymptomDetail> {
  int severity = 1;
  int currentSymptomIndex = 0;
  Map<String, dynamic> dataToPost = {};

  //single title containing the severity of the symptom
  buildSeverityTile({Color color, int value, IconData icon, Symptom symptom}) {
    return Row(
      children: [
        Radio(
          activeColor: color,
          value: value,
          onChanged: (value) {
            setState(() {
              severity = value;
            });
          },
          groupValue: severity,
        ),
        Icon(
          icon,
          color: color,
        ),
        EmptyHorizontalBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            child: Text(
              symptom.severityLevelText[value - 1],
              style: AppTexts.p4,
              overflow: TextOverflow.clip,
            ),
          ),
        )
      ],
    );
  }

  final SizedBox commentComponent = SizedBox(
    width: double.maxFinite,
    height: 130,
    child: Card(
      shadowColor: Color.fromRGBO(64, 91, 116, 0.04),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Any Medication / Comments",
              style: AppTexts.h6,
            ),
            EmptyVerticalBox(
              height: 16,
            ),
            Container(
              height: 48,
              child: TextField(
                cursorColor: AppColors.PINK,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(bottom: 48 / 2, left: 20),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.PRIMARYTITLE, width: 1)),
                  hintText: "Comment",
                  hintStyle: AppTexts.p4,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xffe9efd0), width: 1)),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(LineAwesomeIcons.times),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: AppColors.PRIMARYTITLE),
          elevation: 0.0,
          backgroundColor: AppColors.GREYBG,
          centerTitle: true,
          title: Text(
            "Symptoms",
            style: AppTexts.h4,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EmptyVerticalBox(),
              Text(
                  "More about ${widget.listOfSelectedSymptoms[currentSymptomIndex].symptomName}",
                  style: AppTexts.h5),
              EmptyVerticalBox(
                height: 16,
              ),

              // This below component lets the use to choose the frequency of the symptom
              SizedBox(
                height: 180,
                child: Card(
                  shadowColor: Color.fromRGBO(64, 91, 116, 0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildSeverityTile(
                          color: Color(0xffffc515),
                          value: 1,
                          icon: LineAwesomeIcons.smiling_face,
                          symptom: widget
                              .listOfSelectedSymptoms[currentSymptomIndex]),
                      buildSeverityTile(
                          color: Color(0xffff9029),
                          value: 2,
                          icon: LineAwesomeIcons.neutral_face,
                          symptom: widget
                              .listOfSelectedSymptoms[currentSymptomIndex]),
                      buildSeverityTile(
                          color: Color(0xffff2020),
                          value: 3,
                          icon: LineAwesomeIcons.crying_face,
                          symptom: widget
                              .listOfSelectedSymptoms[currentSymptomIndex]),
                    ],
                  ),
                ),
              ),

              //some spacing
              EmptyVerticalBox(
                height: 20,
              ),
              commentComponent,
              Spacer(),

              //Two bottons to go next or previous
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffa5b2be),
                          shadowColor: Color.fromRGBO(64, 91, 116, 0.04),
                        ),
                        onPressed: () {
                          if (currentSymptomIndex == 0) {
                            return;
                          }
                          setState(() {
                            currentSymptomIndex--;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LineAwesomeIcons.arrow_left,
                              color: Colors.white,
                              size: 20,
                            ),
                            EmptyHorizontalBox(
                              width: 5,
                            ),
                            Text("Previous",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  EmptyHorizontalBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.GREEN,
                            shadowColor: Color.fromRGBO(64, 91, 116, 0.04),
                          ),
                          onPressed: currentSymptomIndex ==
                                  widget.listOfSelectedSymptoms.length - 1
                              ? () async {
                                  dataToPost[widget
                                      .listOfSelectedSymptoms[
                                          currentSymptomIndex]
                                      .symptomName] = severity;

                                  await ApiService.postSymptoms(dataToPost);
                                  Navigator.pop(context);
                                  print(
                                      "Dispaly a snack bar or dialog box showing that the action is successful");
                                }
                              : () {
                                  dataToPost[widget
                                      .listOfSelectedSymptoms[
                                          currentSymptomIndex]
                                      .symptomName] = severity;
                                  setState(() {
                                    currentSymptomIndex++;
                                  });
                                },
                          child: Text(
                              currentSymptomIndex ==
                                      widget.listOfSelectedSymptoms.length - 1
                                  ? "Update"
                                  : "Next",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))),
                    ),
                  )
                ],
              ),
              EmptyVerticalBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
