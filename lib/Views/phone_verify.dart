// ignore_for_file: unnecessary_this

import 'package:country_pickers/country.dart';

import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grab_guard/Features/authentiction/auth_provider.dart';

class PhoneVerify extends ConsumerStatefulWidget {
  const PhoneVerify({Key? key}) : super(key: key);

  @override
  ConsumerState<PhoneVerify> createState() => PhoneVerifyState();
}

class PhoneVerifyState extends ConsumerState<PhoneVerify> {
  var _country;
  var phoneController = TextEditingController();
  Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.23,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                "+${country.phoneCode}(${country.isoCode})",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
            ),
          ],
        ),
      );

  _buildCountryPickerDropdown(
      {bool filtered = false,
      bool sortedByIsoCode = false,
      bool hasPriorityList = false,
      bool hasSelectedItemBuilder = false}) {
    double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.5;
    //respect dropdown button icon size
    double dropdownItemWidth = dropdownButtonWidth - 30;
    double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.32,
          child: Container(
            padding: EdgeInsets.only(left: 2.0),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.07,
            color: Colors.black12,
            child: CountryPickerDropdown(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              itemHeight: null,
              isDense: false,
              itemBuilder: (Country country) =>
                  _buildDropdownItem(country, dropdownItemWidth),
              initialValue: 'GB',
              priorityList: hasPriorityList
                  ? [
                      CountryPickerUtils.getCountryByIsoCode('GBR'),
                      CountryPickerUtils.getCountryByIsoCode('CN'),
                    ]
                  : null,
              sortComparator: sortedByIsoCode
                  ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
                  : null,
              onValuePicked: (Country country) {
                setState(() {
                  this._country = country;
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Phone",
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.035,
            right: MediaQuery.of(context).size.width * 0.035,
            top: MediaQuery.of(context).size.height * 0.1),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Enter your mobile number",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _buildCountryPickerDropdown(filtered: false),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "We'll send you login code",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(
                  Icons.check_box,
                  size: 30,
                ),
                Text(
                  "I agree to Grab a Guard's",
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
                Text(
                  "Terms and Conditions & Privacy Policy",
                  style: TextStyle(fontSize: 11, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                //Here we call the method of our provider

                ref.read(authControllerProvider).signInWithPhone(context,
                    '+' + this._country!.phoneCode + phoneController.text);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Or continue with",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        child: Image.asset(
                          "images/facebook.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Facebook",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.black,
                      child: ClipRRect(
                        child: Image.asset(
                          "images/google.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Google",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
