import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/maps.dart';
import '../utils/color.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    Key? key,
    required this.hint,
    required this.homeText,
    required this.isLocation,
    this.onPress,
  }) : super(key: key);
  final String hint;
  final String homeText;
  final bool isLocation;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                hint,
                style: TextStyle(fontSize: 14, color: ColorConst.textGreyColor),
              ),
            ),
            Expanded(
              child: Text(
                homeText,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConst.textSalColor,
                ),
              ),
            ),
            isLocation
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: IconButton(
                        onPressed: () {
                          onPress!();
                        }, icon: const Icon(Icons.my_location)),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        const Divider(),
      ],
    );
  }
}
