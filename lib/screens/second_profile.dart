import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../utils/color.dart';
import '../widget/information_widget.dart';
import 'maps.dart';

class SecondProfile extends StatefulWidget {
  QueryDocumentSnapshot<Map<String, dynamic>> salonedata;

  SecondProfile(this.salonedata);

  @override
  State<SecondProfile> createState() => _SecondProfileState();
}

class _SecondProfileState extends State<SecondProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Container(
                    //   width: 83,
                    //   height: 83,
                    //   decoration: BoxDecoration(
                    //     color: ColorConst.imageColor,
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: Center(
                    //     child: Icon(
                    //       Icons.image,
                    //       color: ColorConst.white,
                    //     ),
                    //   ),
                    // ),
                    Image.network('${widget.salonedata.get('logo')}',
                        width: 80, fit: BoxFit.cover, height: 80),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.salonedata.get('shopName')}',
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorConst.textSalColor,
                          ),
                        ),
                        Text(
                          '${widget.salonedata.get('owner')}',
                          style: TextStyle(
                            fontSize: 11,
                            color: ColorConst.textGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size / 2),
                  child: MaterialButton(
                    elevation: 15,
                    color: ColorConst.imageColor,
                    minWidth: 150,
                    height: 50,
                    onPressed: () {},
                    child: Text(
                      'Booking',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConst.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConst.textGreyColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '${widget.salonedata.get('desc')}',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConst.textGreyColor,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'Salon  Information\'s',
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConst.textSalColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      InformationWidget(
                        hint: 'Address Line 1',
                        homeText: '15 Avenue NYC',
                        isLocation: false,
                      ),
                      InformationWidget(
                        hint: 'Address Line 2',
                        homeText: '',
                        isLocation: false,
                      ),
                      InformationWidget(
                        hint: 'City',
                        homeText: 'New York City',
                        isLocation: false,
                      ),
                      InformationWidget(
                        hint: 'Location',
                        homeText: 'Go location',
                        isLocation: true,
                        onPress: () {
                          var geoporint =
                              widget.salonedata.get('logation') as GeoPoint;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Maps(geoporint)),
                          );
                        },
                      ),
                      InformationWidget(
                        hint: 'Phone Number',
                        homeText: '+32 23223 32',
                        isLocation: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Image Gallery',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConst.textGreyColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MasonryGridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  crossAxisCount: 2,
                  itemCount:  widget.salonedata.get('post').length,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,

                  itemBuilder: (context, i) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: CachedNetworkImage(
                        imageUrl: widget.salonedata.get('post')[i],
                        // images[i],
                        placeholder: (context, _) => Container(),
                        errorWidget: (context, _, dynamic i) => Container(),
                      ),
                    ),
                  ),

                  // itemCount: imageList.length,
                  // itemBuilder: (context, index) {
                  // },
                ),
                // gridViewWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
