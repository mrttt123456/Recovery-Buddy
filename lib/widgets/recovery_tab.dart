import 'package:RecoveryBuddy/models/stretch.dart';

import 'package:flutter/material.dart';
import 'package:RecoveryBuddy/widgets/stretches_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecoveryTab extends StatefulWidget {
  @override
  _RecoveryTabState createState() => _RecoveryTabState();
}

class _RecoveryTabState extends State<RecoveryTab> {
  BodyPart? selectedBodyPart;
  Injury? selectedInjury;
  Stretch? selectedStretch;

  @override
  void initState() {
    super.initState();
    loadSelections();
  }

  Future<void> saveSelections() async {
    final prefs = await SharedPreferences.getInstance();
    if (selectedBodyPart != null) {
      prefs.setString('selectedBodyPart', selectedBodyPart!.name);
    }
    if (selectedInjury != null) {
      prefs.setString('selectedInjury', selectedInjury!.name);
    }
    // Assuming Stretch has a name property
    if (selectedStretch != null) {
      prefs.setString('selectedStretch', selectedStretch!.name);
    }
  }

  Future<void> loadSelections() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final bodyPartName = prefs.getString('selectedBodyPart');
      final injuryName = prefs.getString('selectedInjury');

      // Find the selected body part
      for (var bodyPart in bodyParts) {
        if (bodyPart.name == bodyPartName) {
          selectedBodyPart = bodyPart;
          break; // Exit the loop once the body part is found
        }
      }

      // If a body part was selected, find the selected injury
      if (selectedBodyPart != null && injuryName != null) {
        for (var injury in selectedBodyPart!.injuries) {
          if (injury.name == injuryName) {
            selectedInjury = injury;
            break; // Exit the loop once the injury is found
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recovery Plan'),
        automaticallyImplyLeading: false,
      ),
      // StretchesList widget needs to be defined in your code
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              DropdownButton<BodyPart>(
                hint: Text('Select body part'),
                value: selectedBodyPart,
                onChanged: (BodyPart? newValue) {
                  setState(() {
                    selectedBodyPart = newValue;
                    selectedInjury =
                        null; // reset the injury when changing body parts
                    selectedStretch =
                        null; // reset the stretch when changing body parts
                  });
                  saveSelections(); // Save the selections
                },
                items: bodyParts
                    .map<DropdownMenuItem<BodyPart>>((BodyPart bodyPart) {
                  return DropdownMenuItem<BodyPart>(
                    value: bodyPart,
                    child: Text('${bodyPart.name}'),
                  );
                }).toList(),
              ),
              if (selectedBodyPart != null)
                DropdownButton<Injury>(
                  hint: Text('Select injury'),
                  value: selectedInjury,
                  onChanged: (Injury? newValue) {
                    setState(() {
                      selectedInjury = newValue;
                      selectedStretch =
                          null; // reset the stretch when changing injuries
                    });
                    saveSelections(); // Save the selections
                  },
                  items: selectedBodyPart!.injuries
                      .map<DropdownMenuItem<Injury>>((Injury injury) {
                    return DropdownMenuItem<Injury>(
                      value: injury,
                      child: Text('${injury.name}'),
                    );
                  }).toList(),
                ),
              if (selectedInjury != null)
                Container(
                  height: 200.0, // or some other fixed value for testing
                  width: MediaQuery.of(context).size.width - 50,
                  child: StretchesList(stretches: selectedInjury!.stretches),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
