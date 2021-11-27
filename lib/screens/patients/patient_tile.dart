/*!
 @file patient_tile.dart

 @brief  PatientTile class
 @discussion This file contains the view class for each tile shown in patients_list screen.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

import 'package:flutter/material.dart';
import 'package:med_login/constants.dart';
import 'package:med_login/models/patient.dart';

class PatientTile extends StatelessWidget {
  const PatientTile({Key? key, required this.patient, required this.index})
      : super(key: key);
  final Patient patient;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      color: index.isEven ? kMLBlueColor : kMLTealBlueColor,
      height: 110,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                    'Name: ' + patient.name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'ID: ' + patient.id.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Gender: ' + patient.gender.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 14),
                  child: Text(
                    'DOB: ' + patient.birthdate!.substring(0, 10),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
