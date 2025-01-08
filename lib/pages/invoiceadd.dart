import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloneapp/pages/subpages/billing.dart';
import 'package:cloneapp/pages/subpages/settings/invoicedraft.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:cloneapp/pages/home.dart';

class InvoiceAdd extends StatefulWidget {
  final String customerID;
  const InvoiceAdd({super.key, required this.customerID});

  @override
  _InvoiceAddState createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
  String _invoiceId = '';
  String formattedDate = '';
  DateTime? _selectedDate;
  String? _paymentMethod;
  final List<String> _paymentMethods = [
    'Advance',
    'Due on receipt',
    'Due at end of week',
    'Due within 15 days',
    'Due end of the month'
  ];
  List<Map<String, dynamic>> _selectedItems = [];
  String? _customerName;
  String? _customerAddress;
  String? _customerEmail;
  String? _customerWorkPhone;
  String? _customerMobile;
  String? _customerid;
  final currentuser = FirebaseAuth.instance.currentUser;
  double _totalAmount = 0.0 ;
final _taxController = TextEditingController();
  final _discountController = TextEditingController();
  double _tax = 0;
  double _discount= 0 ; 
  double _totalBill = 0.0;

  @override
  void initState() {
    _fetchCustomerDetails();
    super.initState();
    _generateInvoiceId();
    _formatDate();
    _calculateTotalAmount();
     _calculatetotalbill(); // Initial calculation

    // Add listener to tax controller
    _taxController.addListener( _calculatetotalbill);
    // Add listener to discount controller
    _discountController.addListener( _calculatetotalbill);
     _taxController.text = _tax.toString();
    _discountController.text = _discount.toString();
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
    formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }


  void _fetchCustomerDetails() async {
    try {
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentuser!.uid)
          .collection('customers')
          .doc(widget.customerID)
          .get();

      if (customerSnapshot.exists) {
        setState(() {
          String salutation = customerSnapshot['Salutation'] ?? ''; // Fetching salutation
          String firstName = customerSnapshot['First Name'] ?? '';
          String lastName = customerSnapshot['Last Name'] ?? '';
          _customerName = '$salutation $firstName $lastName';
          _customerAddress = customerSnapshot['Address'];
          _customerEmail = customerSnapshot['Email'];
          _customerWorkPhone = customerSnapshot['Work-phone'];
          _customerMobile = customerSnapshot['Mobile'];
          _customerid = customerSnapshot["customerID"];
        });
      }
    } catch (e) {
      print("Error fetching customer details: $e");
    }
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

  void _addItems() async {
    final Map<String, dynamic>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddItems()),
    );
    if (result != null) {
      setState(() {
        _selectedItems.add(result);
        _calculateTotalAmount();
        _calculatetotalbill();
      });
    }
  }

  void _calculateTotalAmount() {
    double total = 0.0;
    _selectedItems.forEach((item) {
       double price = item['price'].toDouble(); 
      total += price;
    });
    setState(() {
      _totalAmount = total;
      _calculatetotalbill();
    });
  }
 void _calculatetotalbill() {
  // Calculate total amount of selected items
   _tax = double.tryParse(_taxController.text) ?? 0.0;
    _discount = double.tryParse(_discountController.text) ?? 0.0;
  double totalAmount = _totalAmount;

  // Get tax and discount values from text controllers
  double tax = double.tryParse(_taxController.text) ?? 0.0; // Assuming _tax is a TextEditingController
  double discount = double.tryParse(_discountController.text) ?? 0.0; // Assuming _discount is a TextEditingController

  // Calculate tax amount
  double taxAmount = totalAmount * (tax / 100); // Assuming _tax is in percentage

  // Calculate discount amount
  double discountAmount = totalAmount * (discount / 100); // Assuming _discount is in percentage

  // Calculate total bill amount
  double totalBill = totalAmount + taxAmount - discountAmount;

  // Optionally update state or perform other actions with totalBill
  setState(() {
    
    _totalBill = totalBill;
  });
}

@override
  void dispose() {
    // Clean up controllers
    _taxController.dispose();
    _discountController.dispose();
    super.dispose();
  }


  Future<void> _saveInvoice() async {

  // Calculate total amount
 
    try {
      Map<String, dynamic> invoice = {
        "customerName": _customerName,
        "customerAddress": _customerAddress,
        "customerEmail": _customerEmail,
        "customerID": widget.customerID,
        "workphone": _customerWorkPhone,
        "mobile": _customerMobile,
        "invoiceId": _invoiceId,
        "invoiceDate": Timestamp.fromDate(DateTime.now()), // Convert invoice date to Timestamp
        "paymentMethod": _paymentMethod,
        "dueDate": _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null, // Convert due date to Timestamp
        "items": _selectedItems,
        "total amount": _totalAmount, 
        "tax": _tax,
        "discount" : _discount,
        "totalBill": _totalBill,// Add selected items to the invoice data
        "status": false
      };

      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("invoices")
          .doc(_invoiceId)
          .set(invoice);

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Invoicedraft(invoiceId: _invoiceId),
                  ),
                );
              },
            ),
          ],
        ),
      );
      setState(() {
        _selectedItems.clear();
      });
    } catch (e) {
      print("Error saving invoice: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
      ),
      
    body:SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Invoice ID: $_invoiceId',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              formattedDate,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Due Date:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: _selectDueDate,
              child: Text(
                _selectedDate == null
                    ? 'Select Due date'
                    : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    controller: _taxController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter the tax amount',
                    ),
                  ),
                ),
              ),
              Container(
                height: 40.0,
                width: 1.5,
                color: Colors.grey.shade400,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    controller: _discountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter the discount amount',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 10),
        
          
        DropdownButton<String>(
          value: _paymentMethod,
          onChanged: (String? newValue) {
            setState(() {
              _paymentMethod = newValue!;
            });
          },
          items: _paymentMethods.map<DropdownMenuItem<String>>((String value) {
            return 
             DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ElevatedButton(
            onPressed: _addItems,
            style: ElevatedButton.styleFrom(
              elevation: 0,

            ),
            child: const Text(
              '+ Add inline items',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.blue),
            ),
          ),
        ),
        if (_selectedItems.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Selected Items:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: _selectedItems.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(_selectedItems[index]['itemName']),
      subtitle: Text('${_selectedItems[index]['quantity']} X ${_selectedItems[index]['rate']}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Price: ₹${_selectedItems[index]['price'].toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 15),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _selectedItems.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  },
)
,
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Sub Total: ₹${_totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Total: ₹${_totalBill.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
           Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child:    
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,

            ),
            onPressed: _saveInvoice,
            child: const Text('Save Invoice' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.blue),),
          ),
           )
        ],
                ],
    ),
  ),
)
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120, // Adjust as needed
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12), // Adjust spacing between label and value
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
// Display Customer Name
            // Container(
            //   padding: const EdgeInsets.all(16.0),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey.shade400, width: 1.5),
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Customer Name:',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 8),
            //       Text(
            //         _customerName ?? 'Not Available',
            //         style: TextStyle(fontSize: 18),
            //       ),
            //     ],
            //   ),
            // ),
          

// add warnings and make the things compulsory awesome boxes

 // DropdownButtonFormField<String>(
              //   value: _paymentMethod,
              //   onChanged: (value) {
              //     setState(() {
              //       _paymentMethod = value!;
              //     });
              //   },
              //   decoration: const  InputDecoration(
              //     labelText: 'Select Terms of Payment',
              //     labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              //   ),
              //   items: _paymentMethods.map((String method) {
              //     return DropdownMenuItem<String>(
              //       value: method,
              //       child: Text(method),
              //     );
              //   }).toList(),
              // ),
  
 // ListTile(
              //   title: Text(
              //     ' ${_customerName ?? ''}',
                  
              //   ),
                // onTap: () {
                //   showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: const Text('Customer Details'),
                //         content: SingleChildScrollView(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               _buildDetailRow('Name', _customerName ?? ''),
                //               _buildDetailRow('Address', _customerAddress ?? ''),
                //               _buildDetailRow('Email', _customerEmail ?? ''),
                //               _buildDetailRow('Work Phone', _customerWorkPhone ?? ''),
                //               _buildDetailRow('Mobile', _customerMobile ?? ''),
                //               _buildDetailRow('Customer ID', widget.customerID),
                //             ],
                //           ),
                //         ),
              //           actions: [
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).pop();
              //               },
              //               child: const Text('Close'),
              //             ),
              //           ],
              //         );
              //       },
              //     );
              //   },
              // ),

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  String? selectedItem;
  TextEditingController quantityController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  double? rate;
  double? price;
  List<String> items = [];
  List<String> filteredItems = [];
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchItems();
    searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterItems);
    searchController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Future<void> fetchItems() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.uid)
        .collection("items")
        .get();
    setState(() {
      items = snapshot.docs.map((doc) => doc['Item Name'].toString()).toList();
      filteredItems = items;
    });
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  void calculatePrice() {
    if (quantityController.text.isNotEmpty && rate != null) {
      setState(() {
        price = double.parse(quantityController.text) * rate!;
      });
    } else {
      setState(() {
        price = null;
      });
    }
  }

  Future<void> fetchRate(String itemName) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.uid)
        .collection("items")
        .where('Item Name', isEqualTo: itemName)
        .get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        rate = snapshot.docs.first['Selling Price'].toDouble();
        calculatePrice();
      });
    }
  }

  void saveItem() {
    if (selectedItem != null &&
        quantityController.text.isNotEmpty &&
        rate != null &&
        price != null) {
      Navigator.pop(
        context,
        {
          'itemName': selectedItem,
          'quantity': quantityController.text,
          'rate': rate,
          'price': price,
        },
      );
    } else {
    _showErrorDialog(context, "Fill the details properly");
    }
  }

  void saveAndNewItem() {
    saveItem();
    setState(() {
      selectedItem = null;
      searchController.clear();
      quantityController.clear();
      rate = null;
      price = null;
    });
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/itemadd');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search box with autocomplete suggestions
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                     BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Item',
                    hintText: 'Type to search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (searchController.text.isNotEmpty && filteredItems.isNotEmpty)
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 200.0, // Limit height of suggestions box
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index]),
                        onTap: () {
                          setState(() {
                            selectedItem = filteredItems[index];
                            searchController.text = selectedItem!;
                            filteredItems.clear();
                          });
                          fetchRate(selectedItem!);
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              // Quantity input field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    calculatePrice();
                  },
                ),
              ),
              const SizedBox(height: 16),
              if (rate != null)
                Text(
                  'Rate: ${NumberFormat.currency(symbol: "\₹").format(rate)}',
                  style: const TextStyle(fontSize: 16),
                ),
              if (price != null)
                Text(
                  'Price: ${NumberFormat.currency(symbol: "\₹").format(price)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: saveAndNewItem,
                    child: const Text('Save and New'),
                  ),
                  ElevatedButton(
                    onPressed: saveItem,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showErrorDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'Error',
    desc: message,
    btnOkText: 'OK',
    btnOkColor: Colors.red,
    btnOkOnPress: () {
      // Optionally perform some action on button press
    },
  ).show();
}
}


class Itemadd2 extends StatefulWidget {
  const Itemadd2({super.key});

  @override
  State<Itemadd2> createState() => _Itemadd2State();
}

class _Itemadd2State extends State<Itemadd2> {
  var currentuser = FirebaseAuth.instance.currentUser;

  final _itemname = TextEditingController();
  final _sellingprice = TextEditingController();
  final _description = TextEditingController();

  void addItem(String itemname, int? sellingprice, String description) async {
    if (itemname.isEmpty  ) {
      _showErrorDialog(context, "Add Name of item");
      return;
    }
    if(sellingprice == null){
      _showErrorDialog(context, "Add price of item"); 
      return;
    }

    try {
      // Check if an item with the same name already exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(currentuser!.uid)
          .collection("items")
          .where("Item Name", isEqualTo: itemname)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Item with the same name exists, show warning dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Warning'),
              content: const Text('An item with this name already exists. Do you want to proceed?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Rename'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Proceed'),
                  onPressed: () {
                    // Proceed with adding the item
                    _saveItem(itemname, sellingprice, description);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // No existing item with the same name, proceed to add
        _saveItem(itemname, sellingprice, description);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

 void _saveItem(String itemname, int? sellingprice, String description) async {
  try {
    await FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentuser!.uid)
        .collection("items")
        .add({
          "Item Name": itemname,
          "Selling Price": sellingprice,
          "Description": description,
        });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Item added successfully."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                //  Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AddItems()
                //   ),
                // );
                
              },
            ),
          ],
        );
      },
    );
    _itemname.clear();
    _sellingprice.clear();
    _description.clear();
  } catch (e) {
    print("Error: $e");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to add item. Error: $e"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
 void _showErrorDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'Error',
    desc: message,
    btnOkText: 'OK',
    btnOkColor: Colors.red,
    btnOkOnPress: () {
      // Optionally perform some action on button press
    },
  ).show();
}


  @override
  void dispose() {
    _itemname.dispose();
    _sellingprice.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser ;
  return 
   StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("USERS")
        .doc(currentUser?.uid)
        .collection("details")
        .doc(currentUser?.uid)
        .snapshots(),
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Loading"),
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasError) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Loading"),
          ),
          body: Center(child: Text("Error: ${snapshot.error}")),
        );
      } else if (!snapshot.hasData || !snapshot.data!.exists) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("No data"),
          ),
          body: const Center(child: Text("No data available")),
        );
      } else {
        var userData = snapshot.data!;
        var item = userData["item"] ?? "Default Item Name";

        return Scaffold(
          appBar: AppBar(
            title: Text('Add $item'),
          ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                '$item *',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: _itemname,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add name of $item ',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: _description,
                  maxLines: null, // Allow multiple lines of description
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add description of $item',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  ),
                ),
              ),
               const SizedBox(height: 20),
              const Text(
                'Price *',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: _sellingprice,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'price of $item',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addItem(
                        _itemname.text.trim(),
                        int.tryParse(_sellingprice.text.trim()),
                        _description.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _itemname.clear();
                      _sellingprice.clear();
                      _description.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
        );
      }
    });
  }
}