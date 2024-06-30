// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';

// // // // // class taskaddScreen extends StatefulWidget {
// // // // //   final String? taskId;
// // // // //   final Map<String, dynamic>? taskData;

// // // // //   const taskaddScreen({super.key, this.taskId, this.taskData});

// // // // //   @override
// // // // //   _taskaddScreenState createState() => _taskaddScreenState();
// // // // // }

// // // // // class _taskaddScreenState extends State<taskaddScreen> {
// // // // //   final TextEditingController _taskController = TextEditingController();
// // // // //   DateTime? _selectedDate;
// // // // //   TimeOfDay? _selectedTime;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     if (widget.taskData != null) {
// // // // //       // If editing existing note, pre-fill data
// // // // //       _taskController.text = widget.taskData!['task'];
// // // // //       _selectedDate = (widget.taskData!['dateTime'] as Timestamp).toDate();
// // // // //       _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
// // // // //     }
// // // // //   }

// // // // //   Future<void> _selectDate(BuildContext context) async {
// // // // //     final DateTime? pickedDate = await showDatePicker(
// // // // //       context: context,
// // // // //       initialDate: _selectedDate ?? DateTime.now(),
// // // // //       firstDate: DateTime(2000),
// // // // //       lastDate: DateTime(2101),
// // // // //       builder: (BuildContext context, Widget? child) {
// // // // //         return Theme(
// // // // //           data: ThemeData.light().copyWith(
// // // // //             primaryColor: Colors.blue,
// // // // //           ),
// // // // //           child: child!,
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //     if (pickedDate != null && pickedDate != _selectedDate) {
// // // // //       setState(() {
// // // // //         _selectedDate = pickedDate;
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   Future<void> _selectTime(BuildContext context) async {
// // // // //     final TimeOfDay? pickedTime = await showTimePicker(
// // // // //       context: context,
// // // // //       initialTime: _selectedTime ?? TimeOfDay.now(),
// // // // //     );
// // // // //     if (pickedTime != null && pickedTime != _selectedTime) {
// // // // //       setState(() {
// // // // //         _selectedTime = pickedTime;
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   Future<void> _saveTask() async {
// // // // //     if (_taskController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
// // // // //       User? user = FirebaseAuth.instance.currentUser;

// // // // //       if (user != null) {
// // // // //         final String task = _taskController.text;
// // // // //         final DateTime dateTime = DateTime(
// // // // //           _selectedDate!.year,
// // // // //           _selectedDate!.month,
// // // // //           _selectedDate!.day,
// // // // //           _selectedTime!.hour,
// // // // //           _selectedTime!.minute,
// // // // //         );

// // // // //         try {
// // // // //           if (widget.taskId != null) {
// // // // //             // Update existing note
// // // // //             await FirebaseFirestore.instance
// // // // //                 .collection('USERS')
// // // // //                 .doc(user.uid)
// // // // //                 .collection('calendar')
// // // // //                 .doc(widget.taskId)
// // // // //                 .update({
// // // // //               'task': task,
// // // // //               'dateTime': dateTime,
// // // // //             });
// // // // //           } else {
// // // // //             // Add new note
// // // // //             await FirebaseFirestore.instance
// // // // //                 .collection('USERS')
// // // // //                 .doc(user.uid)
// // // // //                 .collection('calendar')
// // // // //                 .add({
// // // // //               'task': task,
// // // // //               'dateTime': dateTime,
// // // // //             });
// // // // //           }

// // // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // // //             SnackBar(content: Text('Task ${widget.taskId != null ? 'updated' : 'saved'} successfully!')),
// // // // //           );
// // // // //           Navigator.of(context).pop(); // Return to previous screen
// // // // //         } catch (e) {
// // // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // // //             SnackBar(content: Text('Failed to ${widget.taskId != null ? 'update' : 'save'} task')),
// // // // //           );
// // // // //         }
// // // // //       }
// // // // //     } else {
// // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // //         const SnackBar(content: Text('Please enter all details')),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text(widget.taskId != null ? 'Edit Task' : 'Add Task'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: <Widget>[
// // // // //             TextField(
// // // // //               controller: _taskController,
// // // // //               decoration: const InputDecoration(
// // // // //                 labelText: 'Task Description',
// // // // //                 border: OutlineInputBorder(),
// // // // //               ),
// // // // //             ),
// // // // //             const SizedBox(height: 16.0),
// // // // //             Row(
// // // // //               children: <Widget>[
                
// // // // //                 Expanded(
// // // // //                   child: Text(
// // // // //                     _selectedDate == null
// // // // //                         ? ''
// // // // //                         : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
// // // // //                     style: const TextStyle(fontSize: 16.0),
// // // // //                   ),
// // // // //                 ),
// // // // //                 ElevatedButton(
// // // // //                   onPressed: () => _selectDate(context),
// // // // //                   child: const Text('Choose Date'),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 16.0),
// // // // //             Row(
// // // // //               children: <Widget>[
// // // // //                 Expanded(
// // // // //                   child: Text(
// // // // //                     _selectedTime == null
// // // // //                         ? ''
// // // // //                         : 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}',
// // // // //                     style: const TextStyle(fontSize: 16.0),
// // // // //                   ),
// // // // //                 ),
// // // // //                 ElevatedButton(
// // // // //                   onPressed: () => _selectTime(context),
// // // // //                   child: const Text('Choose Time'),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 32.0),
// // // // //             Center(
// // // // //               child: ElevatedButton(
// // // // //                 onPressed: _saveTask,
// // // // //                 child: Text(widget.taskId != null ? 'Update Task' : 'Save Task'),
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';

// // // // class TaskAddScreen extends StatefulWidget {
// // // //   final String? taskId;
// // // //   final Map<String, dynamic>? taskData;

// // // //   const TaskAddScreen({super.key, this.taskId, this.taskData});

// // // //   @override
// // // //   _TaskAddScreenState createState() => _TaskAddScreenState();
// // // // }

// // // // class _TaskAddScreenState extends State<TaskAddScreen> {
// // // //   final TextEditingController _taskController = TextEditingController();
// // // //   DateTime? _selectedDate;
// // // //   TimeOfDay? _selectedTime;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     if (widget.taskData != null) {
// // // //       _taskController.text = widget.taskData!['task'];
// // // //       _selectedDate = (widget.taskData!['dateTime'] as Timestamp).toDate();
// // // //       _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
// // // //     }
// // // //   }

// // // //   Future<void> _selectDate(BuildContext context) async {
// // // //     final DateTime? pickedDate = await showDatePicker(
// // // //       context: context,
// // // //       initialDate: _selectedDate ?? DateTime.now(),
// // // //       firstDate: DateTime(2000),
// // // //       lastDate: DateTime(2101),
// // // //       builder: (BuildContext context, Widget? child) {
// // // //         return Theme(
// // // //           data: ThemeData.light().copyWith(
// // // //             primaryColor: Colors.blue,
// // // //           ),
// // // //           child: child!,
// // // //         );
// // // //       },
// // // //     );
// // // //     if (pickedDate != null) {
// // // //       setState(() {
// // // //         _selectedDate = pickedDate;
// // // //       });
// // // //     }
// // // //   }

// // // //   Future<void> _selectTime(BuildContext context) async {
// // // //     final TimeOfDay? pickedTime = await showTimePicker(
// // // //       context: context,
// // // //       initialTime: _selectedTime ?? TimeOfDay.now(),
// // // //     );
// // // //     if (pickedTime != null) {
// // // //       setState(() {
// // // //         _selectedTime = pickedTime;
// // // //       });
// // // //     }
// // // //   }

// // // //   Future<void> _saveTask() async {
// // // //     if (_taskController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
// // // //       User? user = FirebaseAuth.instance.currentUser;

// // // //       if (user != null) {
// // // //         final String task = _taskController.text;
// // // //         final DateTime dateTime = DateTime(
// // // //           _selectedDate!.year,
// // // //           _selectedDate!.month,
// // // //           _selectedDate!.day,
// // // //           _selectedTime!.hour,
// // // //           _selectedTime!.minute,
// // // //         );

// // // //         try {
// // // //           if (widget.taskId != null) {
// // // //             await FirebaseFirestore.instance
// // // //                 .collection('USERS')
// // // //                 .doc(user.uid)
// // // //                 .collection('calendar')
// // // //                 .doc(widget.taskId)
// // // //                 .update({
// // // //               'task': task,
// // // //               'dateTime': dateTime,
// // // //             });
// // // //           } else {
// // // //             await FirebaseFirestore.instance
// // // //                 .collection('USERS')
// // // //                 .doc(user.uid)
// // // //                 .collection('calendar')
// // // //                 .add({
// // // //               'task': task,
// // // //               'dateTime': dateTime,
// // // //             });
// // // //           }

// // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // //             SnackBar(content: Text('Task ${widget.taskId != null ? 'updated' : 'saved'} successfully!')),
// // // //           );
// // // //           Navigator.of(context).pop();
// // // //         } catch (e) {
// // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // //             SnackBar(content: Text('Failed to ${widget.taskId != null ? 'update' : 'save'} task')),
// // // //           );
// // // //         }
// // // //       }
// // // //     } else {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         const SnackBar(content: Text('Please enter all details')),
// // // //       );
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text(widget.taskId != null ? 'Edit Task' : 'Add Task'),
// // // //       ),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: <Widget>[
// // // //             _buildTaskDescriptionField(),
// // // //             const SizedBox(height: 16.0),
// // // //             _buildDateSelector(context),
// // // //             const SizedBox(height: 16.0),
// // // //             _buildTimeSelector(context),
// // // //             const SizedBox(height: 32.0),
// // // //             Center(
// // // //               child: ElevatedButton(
// // // //                 onPressed: _saveTask,
// // // //                 child: Text(widget.taskId != null ? 'Update Task' : 'Save Task'),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildTaskDescriptionField() {
// // // //     return TextField(
// // // //       controller: _taskController,
// // // //       decoration: const InputDecoration(
// // // //         labelText: 'Task Description',
// // // //         border: OutlineInputBorder(),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildDateSelector(BuildContext context) {
// // // //     return Row(
// // // //       children: <Widget>[
// // // //         Expanded(
// // // //           child: Text(
// // // //             _selectedDate == null
// // // //                 ? 'No date chosen!'
// // // //                 : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
// // // //             style: const TextStyle(fontSize: 16.0),
// // // //           ),
// // // //         ),
// // // //         ElevatedButton(
// // // //           onPressed: () => _selectDate(context),
// // // //           child: const Text('Choose Date'),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   Widget _buildTimeSelector(BuildContext context) {
// // // //     return Row(
// // // //       children: <Widget>[
// // // //         Expanded(
// // // //           child: Text(
// // // //             _selectedTime == null
// // // //                 ? 'No time chosen!'
// // // //                 : 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}',
// // // //             style: const TextStyle(fontSize: 16.0),
// // // //           ),
// // // //         ),
// // // //         ElevatedButton(
// // // //           onPressed: () => _selectTime(context),
// // // //           child: const Text('Choose Time'),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // // }


// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // import 'package:intl/intl.dart';

// // // class TaskAddScreen extends StatefulWidget {
// // //   final String? taskId;
// // //   final Map<String, dynamic>? taskData;

// // //   const TaskAddScreen({super.key, this.taskId, this.taskData});

// // //   @override
// // //   _TaskAddScreenState createState() => _TaskAddScreenState();
// // // }

// // // class _TaskAddScreenState extends State<TaskAddScreen> {
// // //   final TextEditingController _taskController = TextEditingController();
// // //   DateTime? _selectedDate;
// // //   TimeOfDay? _selectedTime;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     if (widget.taskData != null) {
// // //       _taskController.text = widget.taskData!['task'];
// // //       _selectedDate = (widget.taskData!['dateTime'] as Timestamp).toDate();
// // //       _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
// // //     }
// // //   }

// // //   Future<void> _selectDate(BuildContext context) async {
// // //     final DateTime? pickedDate = await showDatePicker(
// // //       context: context,
// // //       initialDate: _selectedDate ?? DateTime.now(),
// // //       firstDate: DateTime(2000),
// // //       lastDate: DateTime(2101),
// // //       builder: (BuildContext context, Widget? child) {
// // //         return Theme(
// // //           data: ThemeData.light().copyWith(
// // //             primaryColor: Colors.blue,
// // //           ),
// // //           child: child!,
// // //         );
// // //       },
// // //     );
// // //     if (pickedDate != null) {
// // //       setState(() {
// // //         _selectedDate = pickedDate;
// // //       });
// // //     }
// // //   }

// // //   Future<void> _selectTime(BuildContext context) async {
// // //     final TimeOfDay? pickedTime = await showTimePicker(
// // //       context: context,
// // //       initialTime: _selectedTime ?? TimeOfDay.now(),
// // //     );
// // //     if (pickedTime != null) {
// // //       setState(() {
// // //         _selectedTime = pickedTime;
// // //       });
// // //     }
// // //   }

// // //   Future<void> _saveTask() async {
// // //   if (_taskController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
// // //     User? user = FirebaseAuth.instance.currentUser;

// // //     if (user != null) {
// // //       final String task = _taskController.text;
// // //       final DateTime dateTime = DateTime(
// // //         _selectedDate!.year,
// // //         _selectedDate!.month,
// // //         _selectedDate!.day,
// // //         _selectedTime!.hour,
// // //         _selectedTime!.minute,
// // //       );

// // //       try {
// // //         if (widget.taskId != null) {
// // //           await FirebaseFirestore.instance
// // //               .collection('USERS')
// // //               .doc(user.uid)
// // //               .collection('calendar')
// // //               .doc(widget.taskId)
// // //               .update({
// // //             'task': task,
// // //             'dateTime': dateTime,
// // //           });
// // //         } else {
// // //           await FirebaseFirestore.instance
// // //               .collection('USERS')
// // //               .doc(user.uid)
// // //               .collection('calendar')
// // //               .add({
// // //             'task': task,
// // //             'dateTime': dateTime,
// // //           });
// // //         }

// // //         await _scheduleNotification(dateTime, task);

// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Task ${widget.taskId != null ? 'updated' : 'saved'} successfully!')),
// // //         );
// // //         Navigator.of(context).pop();
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Failed to ${widget.taskId != null ? 'update' : 'save'} task')),
// // //         );
// // //       }
// // //     }
// // //   } else {
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       const SnackBar(content: Text('Please enter all details')),
// // //     );
// // //   }
// // // }


// // // Future<void> _scheduleNotification(DateTime dateTime, String task) async {
// // //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
// // //       AndroidNotificationDetails(
// // //     'your channel id',
// // //     'your channel name',
// // //     channelDescription: 'your channel description',
// // //     importance: Importance.max,
// // //     priority: Priority.high,
// // //     showWhen: false,
// // //   );
// // //   const NotificationDetails platformChannelSpecifics =
// // //       NotificationDetails(android: androidPlatformChannelSpecifics);

// // //   await flutterLocalNotificationsPlugin.schedule(
// // //     0,
// // //     'Task Reminder',
// // //     task,
// // //     dateTime,
// // //     platformChannelSpecifics,
// // //   );
// // // }





// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(widget.taskId != null ? 'Edit Task' : 'Add Task'),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: <Widget>[
// // //             _buildTaskDescriptionField(),
// // //             const SizedBox(height: 16.0),
// // //             _buildDateSelector(context),
// // //             const SizedBox(height: 16.0),
// // //             _buildTimeSelector(context),
// // //             const SizedBox(height: 32.0),
// // //             Center(
// // //               child: ElevatedButton(
// // //                 onPressed: _saveTask,
// // //                 child: Text(widget.taskId != null ? 'Update Task' : 'Save Task'),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildTaskDescriptionField() {
// // //     return TextField(
// // //       controller: _taskController,
// // //       decoration: const InputDecoration(
// // //         labelText: 'Task Description',
// // //         border: OutlineInputBorder(),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDateSelector(BuildContext context) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.center,
// // //       crossAxisAlignment: CrossAxisAlignment.center,
// // //       children: <Widget>[
// // //         ElevatedButton(
// // //           onPressed: () => _selectDate(context),
// // //           child: const Text('Choose Date'),
// // //         ),
// // //         Expanded(
// // //           child: Text(
// // //             _selectedDate == null
// // //                 ? ''
// // //                 : 'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!.toLocal())}',
// // //             style: const TextStyle(fontSize: 16.0),
// // //           ),
// // //         ),
        
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildTimeSelector(BuildContext context) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.center,
// // //       crossAxisAlignment: CrossAxisAlignment.center,
// // //       children: <Widget>[
// // //          ElevatedButton(     
// // //           onPressed: () => _selectTime(context),
// // //           child: const Text('Choose Time'),
// // //         ),
// // //         Expanded(
// // //           child: Text(
// // //             _selectedTime == null
// // //                 ? ''
// // //                 : 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}',
// // //             style: const TextStyle(fontSize: 16.0),
// // //           ),
// // //         ),
       
// // //       ],
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:intl/intl.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // class TaskAddScreen extends StatefulWidget {
// //   final String? taskId;
// //   final Map<String, dynamic>? taskData;

// //   const TaskAddScreen({super.key, this.taskId, this.taskData});

// //   @override
// //   _TaskAddScreenState createState() => _TaskAddScreenState();
// // }

// // class _TaskAddScreenState extends State<TaskAddScreen> {
// //   final TextEditingController _taskController = TextEditingController();
// //   DateTime? _selectedDate;
// //   TimeOfDay? _selectedTime;
// //   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// //   @override
// //   void initState() {
// //     super.initState();
// //     if (widget.taskData != null) {
// //       _taskController.text = widget.taskData!['task'];
// //       _selectedDate = (widget.taskData!['dateTime'] as Timestamp).toDate();
// //       _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
// //     }
// //     _initializeNotifications();
// //   }

// //   void _initializeNotifications() {
// //     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// //     const AndroidInitializationSettings initializationSettingsAndroid =
// //         AndroidInitializationSettings('app_icon');

// //     final InitializationSettings initializationSettings = InitializationSettings(
// //       android: initializationSettingsAndroid,
// //     );

// //     flutterLocalNotificationsPlugin.initialize(initializationSettings);
// //   }

// //   Future<void> _selectDate(BuildContext context) async {
// //     final DateTime? pickedDate = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate ?? DateTime.now(),
// //       firstDate: DateTime(2000),
// //       lastDate: DateTime(2101),
// //       builder: (BuildContext context, Widget? child) {
// //         return Theme(
// //           data: ThemeData.light().copyWith(
// //             primaryColor: Colors.blue,
// //           ),
// //           child: child!,
// //         );
// //       },
// //     );
// //     if (pickedDate != null) {
// //       setState(() {
// //         _selectedDate = pickedDate;
// //       });
// //     }
// //   }

// //   Future<void> _selectTime(BuildContext context) async {
// //     final TimeOfDay? pickedTime = await showTimePicker(
// //       context: context,
// //       initialTime: _selectedTime ?? TimeOfDay.now(),
// //     );
// //     if (pickedTime != null) {
// //       setState(() {
// //         _selectedTime = pickedTime;
// //       });
// //     }
// //   }

// //  Future<void> _scheduleNotification(DateTime dateTime, String task) async {
// //   await flutterLocalNotificationsPlugin.zonedSchedule(
// //     0,
// //     'Task Reminder',
// //     task,
// //     tz.TZDateTime.from(dateTime, tz.local),
// //     const NotificationDetails(
// //       android: AndroidNotificationDetails(
// //         'your channel id',
// //         'your channel name',
// //         channelDescription: 'your channel description',
// //         importance: Importance.max,
// //         priority: Priority.high,
// //         showWhen: false,
// //       ),
// //     ),
// //     androidAllowWhileIdle: true,
// //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
// //     matchDateTimeComponents: DateTimeComponents.time,
// //   );
// // }

// //   Future<void> _saveTask() async {
// //     if (_taskController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
// //       User? user = FirebaseAuth.instance.currentUser;

// //       if (user != null) {
// //         final String task = _taskController.text;
// //         final DateTime dateTime = DateTime(
// //           _selectedDate!.year,
// //           _selectedDate!.month,
// //           _selectedDate!.day,
// //           _selectedTime!.hour,
// //           _selectedTime!.minute,
// //         );

// //         try {
// //           if (widget.taskId != null) {
// //             await FirebaseFirestore.instance
// //                 .collection('USERS')
// //                 .doc(user.uid)
// //                 .collection('calendar')
// //                 .doc(widget.taskId)
// //                 .update({
// //               'task': task,
// //               'dateTime': dateTime,
// //             });
// //           } else {
// //             await FirebaseFirestore.instance
// //                 .collection('USERS')
// //                 .doc(user.uid)
// //                 .collection('calendar')
// //                 .add({
// //               'task': task,
// //               'dateTime': dateTime,
// //             });
// //           }

// //           await _scheduleNotification(dateTime, task);

// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text('Task ${widget.taskId != null ? 'updated' : 'saved'} successfully!')),
// //           );
// //           Navigator.of(context).pop();
// //         } catch (e) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text('Failed to ${widget.taskId != null ? 'update' : 'save'} task')),
// //           );
// //         }
// //       }
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Please enter all details')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.taskId != null ? 'Edit Task' : 'Add Task'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: <Widget>[
// //             _buildTaskDescriptionField(),
// //             const SizedBox(height: 16.0),
// //             _buildDateSelector(context),
// //             const SizedBox(height: 16.0),
// //             _buildTimeSelector(context),
// //             const SizedBox(height: 32.0),
// //             Center(
// //               child: ElevatedButton(
// //                 onPressed: _saveTask,
// //                 child: Text(widget.taskId != null ? 'Update Task' : 'Save Task'),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildTaskDescriptionField() {
// //     return TextField(
// //       controller: _taskController,
// //       decoration: const InputDecoration(
// //         labelText: 'Task Description',
// //         border: OutlineInputBorder(),
// //       ),
// //     );
// //   }

// //   Widget _buildDateSelector(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: <Widget>[
// //         ElevatedButton(
// //           onPressed: () => _selectDate(context),
// //           child: const Text('Choose Date'),
// //         ),
// //         Expanded(
// //           child: Text(
// //             _selectedDate == null
// //                 ? ''
// //                 : 'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!.toLocal())}',
// //             style: const TextStyle(fontSize: 16.0),
// //           ),
// //         ),
        
// //       ],
// //     );
// //   }

// //   Widget _buildTimeSelector(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: <Widget>[
// //          ElevatedButton(     
// //           onPressed: () => _selectTime(context),
// //           child: const Text('Choose Time'),
// //         ),
// //         Expanded(
// //           child: Text(
// //             _selectedTime == null
// //                 ? ''
// //                 : 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}',
// //             style: const TextStyle(fontSize: 16.0),
// //           ),
// //         ),
       
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;

// class TaskAddScreen extends StatefulWidget {
//   final String? taskId;
//   final Map<String, dynamic>? taskData;

//   const TaskAddScreen({super.key, this.taskId, this.taskData});

//   @override
//   _TaskAddScreenState createState() => _TaskAddScreenState();
// }

// class _TaskAddScreenState extends State<TaskAddScreen> {
//   final TextEditingController _taskController = TextEditingController();
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.taskData != null) {
//       _taskController.text = widget.taskData!['task'];
//       _selectedDate = (widget.taskData!['dateTime'] as Timestamp).toDate();
//       _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
//     }
//     _initializeNotifications();
//   }

//   void _initializeNotifications() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: Colors.blue,
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime ?? TimeOfDay.now(),
//     );
//     if (pickedTime != null) {
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     }
//   }

//   Future<void> _scheduleNotification(DateTime dateTime, String task) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Task Reminder',
//       task,
//       tz.TZDateTime.from(dateTime, tz.local),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'your channel id',
//           'your channel name',
//           channelDescription: 'your channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//           showWhen: false,
//         ),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }

//   Future<void> _saveTask() async {
//     if (_taskController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         final String task = _taskController.text;
//         final DateTime dateTime = DateTime(
//           _selectedDate!.year,
//           _selectedDate!.month,
//           _selectedDate!.day,
//           _selectedTime!.hour,
//           _selectedTime!.minute,
//         );

//         try {
//           if (widget.taskId != null) {
//             await FirebaseFirestore.instance
//                 .collection('USERS')
//                 .doc(user.uid)
//                 .collection('calendar')
//                 .doc(widget.taskId)
//                 .update({
//               'task': task,
//               'dateTime': dateTime,
//             });
//           } else {
//             await FirebaseFirestore.instance
//                 .collection('USERS')
//                 .doc(user.uid)
//                 .collection('calendar')
//                 .add({
//               'task': task,
//               'dateTime': dateTime,
//             });
//           }

//           await _scheduleNotification(dateTime, task);

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Task ${widget.taskId != null ? 'updated' : 'saved'} successfully!')),
//           );
//           Navigator.of(context).pop();
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to ${widget.taskId != null ? 'update' : 'save'} task')),
//           );
//         }
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter all details')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.taskId != null ? 'Edit Task' : 'Add Task'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             _buildTaskDescriptionField(),
//             const SizedBox(height: 16.0),
//             _buildDateSelector(context),
//             const SizedBox(height: 16.0),
//             _buildTimeSelector(context),
//             const SizedBox(height: 32.0),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _saveTask,
//                 child: Text(widget.taskId != null ? 'Update Task' : 'Save Task'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTaskDescriptionField() {
//     return TextField(
//       controller: _taskController,
//       decoration: const InputDecoration(
//         labelText: 'Task Description',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }

//   Widget _buildDateSelector(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         ElevatedButton(
//           onPressed: () => _selectDate(context),
//           child: const Text('Choose Date'),
//         ),
//         Expanded(
//           child: Text(
//             _selectedDate == null
//                 ? ''
//                 : 'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!.toLocal())}',
//             style: const TextStyle(fontSize: 16.0),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTimeSelector(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         ElevatedButton(
//           onPressed: () => _selectTime(context),
//           child: const Text('Choose Time'),
//         ),
//         Expanded(
//           child: Text(
//             _selectedTime == null
//                 ? ''
//                 : 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}',
//             style: const TextStyle(fontSize: 16.0),
//           ),
//         ),
//       ],
//     );
//   }
// }
