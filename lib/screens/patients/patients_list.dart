/*!
 @file patients_list.dart

 @brief  PatientsList class
 @discussion This file contains the view class for the list shown in patients_list screen.

 @author Priyanka Bhatia
 @copyright  2021 Priyanka Bhatia
 @version  1.0.0
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:med_login/utils/patients_notifier.dart';
import 'package:med_login/screens/patients/patient_tile.dart';

class PatientsList extends StatefulWidget {
  const PatientsList({Key? key}) : super(key: key);
  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MLPatientsNotifier>(
      builder: (context, patientsProvider, child) {
        if (patientsProvider.allPatients.length > 0 &&
            patientsProvider.getLoadMoreStatus() != LoadMoreStatus.INITIAL) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: Colors.black,
              );
            },
            // padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: patientsProvider.allPatients.length,
            itemBuilder: (context, index) {
              return PatientTile(
                patient: patientsProvider.allPatients[index],
                index: index,
              );
            },
          );
        } else if (patientsProvider.getLoadMoreStatus() ==
            LoadMoreStatus.LOADING) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: Text(
                'Sorry, 0 patient records found',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }
      },
    );
  }
}
