import 'dart:math';
import 'package:cloneapp/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Invoiceadd extends StatefulWidget {
  const Invoiceadd({super.key});

  @override
  State<Invoiceadd> createState() => _InvoiceaddState();
}

class _InvoiceaddState extends State<Invoiceadd> {
  String _invoiceId = '';
  String formattedDate = '';
  DateTime? _selectedDate;
  List<String> _customers = [];
  String? selectedCustomer;
  String _paymentMethod = '';
  String _review = '';
  final Set<String> _selectedProcedures = {}; // Changed to Set for multi-selection

  final currentuser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _generateInvoiceId();
    _formatDate();
  }

  Future<void> _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _generateInvoiceId() {
    const length = 5;
    const chars = 'ABC1234';
    final random = Random();
    setState(() {
      _invoiceId = String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    });
  }

  void _formatDate() {
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  }

  Future<void> saveInvoice() async {
    try {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("invoices")
          .doc(_invoiceId)
          .set({
            "customerName": selectedCustomer,
            "invoiceId": _invoiceId,
            "invoiceDate": formattedDate,
            "paymentMethod": _paymentMethod,
            "review": _review,
            "dueDate": _selectedDate,
            "procedures": _selectedProcedures.toList(), // Save as list of selected procedures
          });

           showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Invoice saved successfully'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/invoice');
              },
            ),
          ],
        ),
      );
      print("Invoice saved successfully!");
    } catch (e) {
      print("Error saving invoice: $e");
    }
  }
@override
  void dispose() {
   // fill karna hai 
    super.dispose();
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Invoice"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: drawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text("Customer Name:", style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 20),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("USERS")
                          .doc(currentuser!.uid)
                          .collection("customers")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.active) {
                          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                            _customers = snapshot.data!.docs
                                .map((doc) =>


                                 "${doc['Salutation']} ${doc['First Name']} ${doc['Last Name']}")
                                .toList();
                            return Container(
                              width: 350,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: selectedCustomer,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCustomer = newValue!;
                                  });
                                },
                                items: _customers
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          } else {
                            return const Text('No customers found.');
                          }
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          return Text('Error: ${snapshot.error}');
                        }
                      },
                    ),
                    const SizedBox(width: 30),
                    const Text("Invoice ID:", style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 20),
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          _invoiceId,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text("Invoice Date:", style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 50),
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          formattedDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 210),
                    const Text("Due Date:", style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () => _selectDueDate(),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'Select Due Date'
                                    : '${_selectedDate!.toLocal()}'.split(' ')[0],
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Payment Method:", style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        _paymentMethod = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter payment method',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Review:", style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        _review = value;
                      },
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Leave a review',
                        
                      ),
                    ),
                    const SizedBox(height: 20),
                    // const Text("Procedures:", style: TextStyle(fontSize: 20)),
                    // const SizedBox(height: 10),
                    // StreamBuilder<QuerySnapshot>(
                    //   stream: FirebaseFirestore.instance
                    //       .collection("USERS")
                    //       .doc(currentuser!.uid)
                    //       .collection("items")
                    //       .snapshots(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.active) {
                    //       if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    //         List<String> procedures = snapshot.data!.docs
                    //             .map((doc) => doc['Item Name'] as String)
                    //             .toList();

                            // return Container(
                            //   width: 350,
                            //   padding: const EdgeInsets.symmetric(horizontal: 10),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.black, width: 1),
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                                // children: procedures
                                //     .map((procedure) => CheckboxListTile(
                                //           title: Text(procedure),
                                //           value: _selectedProcedures.contains(procedure),
                                //           onChanged: (bool? value) {
                                //             setState(() {
                                //               if (value!) {
                                //                 _selectedProcedures.add(procedure);
                                //               } else {
                                //                 _selectedProcedures.remove(procedure);
                                //               }
                                //             });
                                //           },
                                //         ))
                                //     .toList(),
                        //       ),
                        //     );
                        //   } else {
                        //     return const Text('No procedures found.');
                        //   }
                        // } else if (snapshot.connectionState == ConnectionState.waiting) {
                        //   return const CircularProgressIndicator();
                        // } else {
                        //   return Text('Error: ${snapshot.error}');
                        // }

              //             }
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      saveInvoice();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ]),
    )
      )
      );
      
  }
}
