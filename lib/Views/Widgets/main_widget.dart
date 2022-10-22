import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:grab_guard/Features/storage/create_job.dart';
import 'package:grab_guard/Features/storage/data_provider.dart';

import 'package:grab_guard/Models/guard_model.dart';
import 'package:grab_guard/Models/job_model.dart';
import 'package:grab_guard/Models/user_model.dart';
import 'package:grab_guard/Views/Screens/details_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grab_guard/Views/Widgets/dateselect.dart';
import 'package:grab_guard/Views/Widgets/google_map.dart';

class MainScreenWidget extends ConsumerStatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends ConsumerState<MainScreenWidget> {
  List<String> _serviceTypes = [
    'Events Manag. ,Stewards,Door supervisor',
    'Key Holding & Alarm Response',
    'Dog handling ',
    'CCTV monitoring',
    'VIP close protection',
    'Traffic Marshal operative/Vehicle immobi. ',
    'other type of services'
  ]; // Option 2

  TextEditingController cityController = TextEditingController();
  var _selectedService;
  var document = ['user 1', 'user 2'];
  int listLength = 0;
  bool isloading = true;
  List<GuardModel> guardlist = [];
  int pageIndex = 0;
  bool isNoGuard = false;
  UserModel? currentUser;
  String? City = "";
  void getData() async {
    String? city = await ref.read(dataProvier).getCurrentUserCity();
    var list = await ref.read(dataProvier).getGuardWithCity(city);

    var tempUser = await ref.read(dataProvier).getCurrentUserData();
    setState(() {
      if (list.isEmpty) {
        isNoGuard = true;
      }
      currentUser = tempUser;
      isloading = false;
      guardlist = list;
      City = city;
    });
  }

  Future<void> onReferesh() async {
    var list = await ref.read(dataProvier).getGuardWithCity(City);
    setState(() {
      {
        guardlist = list;
        isloading = false;
      }
    });
  }

  Future<void> onDropdownChange() async {
    var list = await ref
        .read(dataProvier)
        .getGuardWithService(City, _selectedService.toString());
    setState(() {
      {
        guardlist = list;
        isloading = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var SelectedGuard = JobModel(
        mtoken: "",
        weekDay: "",
        profileUrl: "",
        fee: 0.0,
        hours: 0.0,
        guardName: "",
        hirerId: ' ${FirebaseAuth.instance.currentUser?.uid}',
        hirerName: "${currentUser?.firstName} ${currentUser?.lastName}",
        guardId: "",
        duration: "",
        date: "",
        description: "",
        pending: true);
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * .4,
              //Map
              child: Stack(
                children: [
                  MapScreen(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: TextField(
                      controller: cityController,
                      onEditingComplete: () {
                        setState(() {
                          City = cityController.text;
                          isloading = true;
                          isNoGuard = false;
                        });
                        onReferesh();
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black45,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.black45),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40))),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 00, top: 4),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child: Text(
                            "Available Guards",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Text('$City'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Container(
                                //  width: MediaQuery.of(context).size.width * 0.20,
                                child: DropdownButton(
                                  hint: Text('Select service type'),
                                  // Not necessary for Option 1
                                  value: _selectedService,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedService = newValue;
                                      isloading = true;
                                    });

                                    onDropdownChange();
                                  },
                                  items: _serviceTypes.map((location) {
                                    return DropdownMenuItem(
                                      child: new Text(location),
                                      value: location,
                                    );
                                  }).toList(),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black45,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: isloading
                          ? Center(
                              child: isNoGuard
                                  ? Text("No Guards found")
                                  : CircularProgressIndicator(
                                      color: Colors.grey),
                            )
                          : RefreshIndicator(
                              onRefresh: onReferesh,
                              child: ListView.builder(
                                itemCount: guardlist.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        bottom: 10.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    DetailsScreen.routeName,
                                                    arguments:
                                                        guardlist[index]);
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          guardlist[index]
                                                              .profilePicUrl),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    color: Colors.black26,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15, left: 10),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    guardlist[index].firstName +
                                                        " " +
                                                        guardlist[index]
                                                            .lastName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "No ratings yet",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                            color:
                                                                Colors.amber),
                                                      ),
                                                      Text(
                                                        "(0)",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                            color:
                                                                Colors.amber),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                SelectedGuard.guardId =
                                                    guardlist[index].guardId;
                                                SelectedGuard.guardName =
                                                    guardlist[index].firstName +
                                                        guardlist[index]
                                                            .lastName;
                                                SelectedGuard.mtoken =
                                                    guardlist[index].token;
                                                SelectedGuard.profileUrl =
                                                    guardlist[index]
                                                        .profilePicUrl;
                                              SelectedGuard.description=  guardlist[index].service;

                                                JobData.setJobModel(
                                                    SelectedGuard);
                                                showModalBottomSheet(
                                                  isDismissible: false,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  )),
                                                  enableDrag: true,
                                                  //anchorPoint: Snap,
                                                  context: context,
                                                  builder: (context) =>
                                                      DateFormat(),
                                                );
                                              },
                                              child: Container(
                                                width: 70,
                                                height: 40,
                                                color: Colors.amber,
                                                child: Center(
                                                  child: Text(
                                                    "Hire ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
