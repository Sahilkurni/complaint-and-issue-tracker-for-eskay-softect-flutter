import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import 'dart:convert'; // Import for jsonEncode and jsonDecode

const Color primaryColor = Color.fromRGBO(59, 143, 241, 1);

class RaiseComplpaintPage extends StatefulWidget {
  const RaiseComplpaintPage({super.key});

  @override
  State<RaiseComplpaintPage> createState() => _RaiseComplpaintPageState();
}

class _RaiseComplpaintPageState extends State<RaiseComplpaintPage> {
  // List of complaint types
  final List<String> complaintTypes = [
    'Network Issue',
    'Billing Problem',
    'Software Not Opening',
    'File Corrupted',
    'Printer Not Working',
    'Report Not Genrating',
    'Purchase Not Tally',
    'Subscription Over',
    'Price Changed Of Product',
    'Other'
  ];

  // Variable to hold the selected complaint type
  String? selectedComplaintType;

  // Text controller for complaint description
  final TextEditingController complaintController = TextEditingController();

  // List to store all complaints, now includes the date
  List<Map<String, String>> complaints = [];

  @override
  void initState() {
    super.initState();
    _loadComplaints(); // Load saved complaints when the app starts
  }

  // Function to load complaints from shared preferences
  _loadComplaints() async {
    // Access shared preferences
    final prefs = await SharedPreferences.getInstance();

    // Try to retrieve the saved complaints data as a JSON string
    final String? complaintsJson = prefs.getString('complaints');

    // If complaints data exists in shared preferences
    if (complaintsJson != null) {
      // Decode the JSON string into a List of dynamic objects
      final List<dynamic> complaintsList = jsonDecode(complaintsJson);

      // Map each decoded object to a Map<String, String> and update the complaints list
      setState(() {
        complaints = complaintsList
            .map((complaint) => Map<String, String>.from(complaint))
            .toList();
      });
    }
  }

  // Function to save complaints to shared preferences
  _saveComplaints() async {
    // Access shared preferences
    final prefs = await SharedPreferences.getInstance();

    // Convert the complaints list to a JSON string
    final String complaintsJson = jsonEncode(complaints);

    // Save the JSON string to shared preferences
    await prefs.setString('complaints', complaintsJson);
  }

  // Function to handle form submission
  void submitComplaint() {
    if (selectedComplaintType != null && complaintController.text.isNotEmpty) {
      // Get current date
      String currentDate = DateTime.now().toString();

      // Add new complaint to the list, including the date
      setState(() {
        complaints.add({
          'type': selectedComplaintType!,
          'description': complaintController.text,
          'date': currentDate,
        });
      });

      // Clear the form after submission
      complaintController.clear();
      setState(() {
        selectedComplaintType = null;
      });
      // Proceed with complaint submission logic
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Complaint Submitted: $selectedComplaintType - ${complaintController.text}'),
      ));
    } else {
      // Show error message if any field is missing
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Please select a complaint type and provide a description.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 244, 248, 1),
      body: Container(
        height: height,
        width: width,
        child: Row(
          children: [
            Container(
              height: height,
              width: 400,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                // border: Border.all(color: Colors.black),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black, // Shadow color
                      offset: Offset.zero, // No offset
                      blurRadius: 0.10, // Small blur effect
                      spreadRadius: 0.10, // Shadow will expand slightly
                      blurStyle: BlurStyle.normal // Normal blur style
                      ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/icon.jpg")),
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          "Eskay Softech",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Our Products",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Oswald'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: primaryColor, // Line color
                      thickness: 4, // Line thickness
                      indent: 20, // Left padding
                      endIndent: 20, // Right padding
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          // ignore: deprecated_member_use
                          FontAwesomeIcons.wineGlassAlt,
                          color: Colors.black,
                          size: 20,
                        ),
                        Icon(
                          FontAwesomeIcons.cocktail,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          "LiquorLogix",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesomeIcons.wineGlassAlt,
                          color: Colors.black,
                          size: 20,
                        ),
                        Icon(
                          Icons.restaurant,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          "Bar Byte",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesomeIcons.hotel,
                          color: Colors.black,
                          size: 20,
                        ),
                        Icon(
                          FontAwesomeIcons.key,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Room Rover",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesomeIcons.cocktail,
                          color: Colors.black,
                          size: 20,
                        ),
                        Icon(
                          FontAwesomeIcons.music,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          "Eskay Club",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesomeIcons.store,
                          color: Colors.black,
                          size: 20,
                        ),
                        Icon(
                          FontAwesomeIcons.shoppingCart,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        Text(
                          "Eskay Neo",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: primaryColor, // Line color
                      thickness: 4, // Line thickness
                      indent: 20, // Left padding
                      endIndent: 20, // Right padding
                    ),
                    const Text(
                      "Contact Information",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald'),
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          "#1473/D+B+C, Bailwad Complex, Baswan Galli,\nNear Laxmi Mandir, BELGAVI-01",
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.call,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          "0831-4202928",
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.mail,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          "eskaysoftech@gmail.com",
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Oswald'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Sharavati Bar",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Oswald'),
                      )
                    ],
                  ),
                  const Text(
                    'Sorry for the inconvenience! Please fill out the form below:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Dropdown to select complaint type
                  DropdownButtonFormField<String>(
                    value: selectedComplaintType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedComplaintType = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                        labelText: 'Select Complaint Type',
                        labelStyle: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald',
                        ),
                        border: OutlineInputBorder(),
                        focusColor: primaryColor),
                    items: complaintTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) =>
                        value == null ? 'Please select a complaint type' : null,
                  ),
                  const SizedBox(height: 16),

                  // TextField to enter the complaint description
                  TextField(
                    controller: complaintController,
                    decoration: const InputDecoration(
                      labelText: 'Complaint Description',
                      labelStyle: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oswald',
                      ),
                      border: OutlineInputBorder(),
                      focusColor: primaryColor,
                    ),
                    maxLines: 4, // Allow multiple lines for the description
                  ),
                  const SizedBox(height: 16),

                  // Submit button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor, // Set the background color
                    ),
                    onPressed: submitComplaint,
                    child: const Text(
                      'Submit Complaint',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oswald',
                      ),
                    ),
                  ),
                  // Display previous complaints below the form
                  SizedBox(height: 20),
                  const Text(
                    'Previous Complaints:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
// List of all submitted complaints
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final complaint = complaints[index];
                        // Convert date string to DateTime to format it
                        DateTime complaintDate =
                            DateTime.parse(complaint['date']!);
                        String formattedDate =
                            "${complaintDate.day}/${complaintDate.month}/${complaintDate.year}";

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          color: Colors.white, // Set background color to white
                          elevation: 5, // Add shadow effect
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Type: ${complaint['type']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                    'Description: ${complaint['description']}'),
                                SizedBox(height: 4),
                                Text(
                                    'Date: $formattedDate'), // Display the formatted date
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
