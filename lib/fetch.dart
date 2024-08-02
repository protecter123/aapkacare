import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Fetch extends StatefulWidget {
  @override
  _FetchState createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  List<Map<String, dynamic>> dataList = [];
  int addedDocumentsCount = 0; // Counter for added documents

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      CollectionReference collectionRef = FirebaseFirestore.instance.collection('AllHospital').doc('mpctsurana@aapkacare.com').collection('Doctors');
      QuerySnapshot querySnapshot = await collectionRef.get();

      final allData = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      setState(() {
        dataList = allData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> saveDataToAnotherCollection() async {
    try {
      CollectionReference newCollectionRef = FirebaseFirestore.instance.collection('AllDoctors');

      for (var data in dataList) {
        // Transform data
        final transformedData = {
          'uId': data['docId'] ?? 'mpctsurana@aapkacare.com',
          'workingHospital': 'MPCT Hospital',
          'hospitalAddress': 'Mumbai',
          'city': data['city'] ?? 'Mumbai',
          'name': data['name'] ?? '',
          'qualification': data['qualification'] ?? '',
          'speciality': data['speciality'] ?? '',
          'experience': data['experience'] ?? '',
          'about': data['about'] ?? '',
          'email': '',
          'gender': data['gender'] ?? '',
          'imgUrl': data['imageUrl'] ?? '',
          'phoneNumber': '',
          'availability': data['availability'] ?? '',
          'Degree': '',
          'dob': '',
          'awards': '',
          'clinicAddress': '',
          'clinicName': '',
          'fee': '',
          'userType': 'Doctor',
          'secoundaryPhoneNo': '',
          'vcFee': '',
          'isVerified': false,
        };

        // Add document to the new collection
        await newCollectionRef.doc(data['docId']).set(transformedData);

        // Increment the counter and update the UI
        setState(() {
          addedDocumentsCount++;
        });
      }

      // Show a snackbar to indicate all data is added
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All data successfully added to the new collection')),
      );
      print('$addedDocumentsCount data successfully added');
    } catch (e) {
      print('Error saving data: $e');
      // Show a snackbar to indicate error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data Fetch Example'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveDataToAnotherCollection,
            child: Text('Add Data to New Collection'),
          ),
          SizedBox(height: 20),
          Text('Documents added: $addedDocumentsCount'), // Display the counter
          SizedBox(height: 20),
          Text('Documents: ${dataList.length}'), // Display the counter
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataList[index]['name'] ?? 'No data'),
                  // subtitle: Text(dataList[index]['city']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
