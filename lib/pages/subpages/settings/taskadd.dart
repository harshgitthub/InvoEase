import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class taskaddScreen extends StatefulWidget {
  final String? taskId;
  final Map<String, dynamic>? taskData;

  const taskaddScreen({super.key, this.taskId, this.taskData});

  @override
  _taskaddScreenState createState() => _taskaddScreenState();
}

class _taskaddScreenState extends State<taskaddScreen> {
  final TextEditingController _taskController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.taskData != null) {
      // If editing existing note, pre-fill data
      _taskController.text = widget.taskData!['task'];
      _selectedDate = (widget.taskData!['dateTime'] as Timestamp).toDate();
      _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _saveTask() async {
    if (_taskController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final String task = _taskController.text;
        final DateTime dateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );

        try {
          if (widget.taskId != null) {
            // Update existing note
            await FirebaseFirestore.instance
                .collection('USERS')
                .doc(user.uid)
                .collection('calendar')
                .doc(widget.taskId)
                .update({
              'task': task,
              'dateTime': dateTime,
            });
          } else {
            // Add new note
            await FirebaseFirestore.instance
                .collection('USERS')
                .doc(user.uid)
                .collection('calendar')
                .add({
              'task': task,
              'dateTime': dateTime,
            });
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Task ${widget.taskId != null ? 'updated' : 'saved'} successfully!')),
          );
          Navigator.of(context).pop(); // Return to previous screen
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to ${widget.taskId != null ? 'update' : 'save'} task')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskId != null ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? ''
                        : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Choose Date'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedTime == null
                        ? ''
                        : 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: const Text('Choose Time'),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: _saveTask,
                child: Text(widget.taskId != null ? 'Update Task' : 'Save Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
