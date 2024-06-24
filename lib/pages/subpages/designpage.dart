// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:convert';
// import 'dart:io';

// class DesignPage extends StatefulWidget {
//   @override
//   _DesignPageState createState() => _DesignPageState();
// }

// class _DesignPageState extends State<DesignPage> {
//   List<Widget> _elements = [];
//   List<Widget> _undoStack = [];

//   void _addElement(Widget element, Offset offset) {
//     setState(() {
//       _elements.add(
//         Positioned(
//           left: offset.dx,
//           top: offset.dy,
//           child: DraggableWidget(
//             child: element,
//             onDragEnd: (details) {
//               setState(() {
//                 _elements[_elements.length - 1] = Positioned(
//                   left: details.offset.dx,
//                   top: details.offset.dy,
//                   child: element,
//                 );
//               });
//             },
//           ),
//         ),
//       );
//     });
//   }

//   void _undoAction() {
//     if (_elements.isNotEmpty) {
//       setState(() {
//         _undoStack.add(_elements.removeLast());
//       });
//     }
//   }

//   void _redoAction() {
//     if (_undoStack.isNotEmpty) {
//       setState(() {
//         _elements.add(_undoStack.removeLast());
//       });
//     }
//   }

//   Future<void> _uploadImage() async {
//     // final picker = ImagePicker();
//     // final pickedFile = await picker.get(source: ImageSource.gallery);

//     // if (pickedFile != null) {
//     //   _addElement(
//     //     Image.file(
//     //       File(pickedFile.path),
//     //       width: 100,
//     //       height: 100,
//     //       fit: BoxFit.cover,
//     //     ),
//     //     Offset(50, 50),
//     //   );
//     // } else {
//     //   print('No image selected.');
//     // }
//   }

//   void _addTable() {
//     _addElement(
//       TableWidget(), // Implement TableWidget as needed
//       Offset(100, 100),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice Design'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _saveLayout,
//           ),
//           IconButton(
//             icon: Icon(Icons.upload_file),
//             onPressed: _loadLayout,
//           ),
//         ],
//       ),
//       body: Stack(
//         children: _elements.isNotEmpty
//             ? _elements
//             : [
//                 Center(
//                   child: Text(
//                     'Tap + button to add elements',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: _uploadImage,
//             child: Icon(Icons.add_a_photo),
//             heroTag: 'photo',
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: _addTable,
//             child: Icon(Icons.table_chart),
//             heroTag: 'table',
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: _undoAction,
//             child: Icon(Icons.undo),
//             heroTag: 'undo',
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: _redoAction,
//             child: Icon(Icons.redo),
//             heroTag: 'redo',
//           ),
//           SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   void _saveLayout() {
//     List<Map<String, dynamic>> serializedElements = _elements.map((element) {
//       return {
//         'left': (element as Positioned).left,
//         'top': element.top,
//         'widget': (element.child as DraggableWidget).child.toJson(),
//       };
//     }).toList();
//     String jsonLayout = jsonEncode(serializedElements);
//     // Save jsonLayout to a file or database
//   }

//   void _loadLayout() {
//     // Load jsonLayout from a file or database
//     String jsonLayout = ''; // Replace with actual loading logic
//     List<dynamic> decodedElements = jsonDecode(jsonLayout);
//     setState(() {
//       _elements = decodedElements.map((element) {
//         return Positioned(
//           left: element['left'],
//           top: element['top'],
//           child: DraggableWidget(
//             child: WidgetFromJson(element['widget']),
//             onDragEnd: (details) {
//               setState(() {
//                 // Update the position in the list
//               });
//             },
//           ),
//         );
//       }).toList();
//     });
//   }
// }

// class DraggableWidget extends StatelessWidget {
//   final Widget child;
//   final Function(DraggableDetails) onDragEnd;

//   DraggableWidget({required this.child, required this.onDragEnd});

//   @override
//   Widget build(BuildContext context) {
//     return Draggable(
//       child: child,
//       feedback: Material(
//         child: child,
//       ),
//       childWhenDragging: Container(),
//       onDraggableCanceled: (velocity, offset) {},
//       onDragEnd: onDragEnd,
//     );
//   }
// }

// class TableWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 150,
//       color: Colors.grey,
//       child: Center(
//         child: Text(
//           'Table',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

// // Implement more widgets as needed (e.g., EditableTextWidget, ImageWidget)

// // Example method to convert a Widget to JSON
// extension on Widget {
//   Map<String, dynamic> toJson() {
//     // Implement serialization logic based on widget type
//     if (this is Image) {
//       return {
//         'type': 'Image',
//         // Add more properties as needed
//       };
//     } else if (this is TableWidget) {
//       return {
//         'type': 'TableWidget',
//         // Add more properties as needed
//       };
//     }
//     // Add more widget types as needed
//     return {};
//   }
// }

// // Example method to create a Widget from JSON
// Widget WidgetFromJson(Map<String, dynamic> json) {
//   switch (json['type']) {
//     case 'Image':
//       return Image.asset('assets/default_image.png'); // Replace with actual image handling
//     case 'TableWidget':
//       return TableWidget();
//     // Add more widget types as needed
//     default:
//       return Container();
//   }
// }


  import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';
  import 'dart:convert';
  import 'dart:io';

  class DesignPage extends StatefulWidget {
    @override
    _DesignPageState createState() => _DesignPageState();
  }

  class _DesignPageState extends State<DesignPage> {
    List<Widget> _elements = [];
    List<Widget> _undoStack = [];

    void _addElement(Widget element, Offset offset) {
      setState(() {
        _elements.add(
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: DraggableWidget(
              child: element,
              onDragEnd: (details) {
                setState(() {
                  _elements[_elements.length - 1] = Positioned(
                    left: details.offset.dx,
                    top: details.offset.dy,
                    child: element,
                  );
                });
              },
            ),
          ),
        );
      });
    }

    void _undoAction() {
      if (_elements.isNotEmpty) {
        setState(() {
          _undoStack.add(_elements.removeLast());
        });
      }
    }

    void _redoAction() {
      if (_undoStack.isNotEmpty) {
        setState(() {
          _elements.add(_undoStack.removeLast());
        });
      }
    }

    Future<void> _uploadImage() async {

    }

    void _addTable() {
      _addElement(
        TableWidget(columns: 2, rows: 3), // Example with 2 columns and 3 rows
        const Offset(100, 100),
      );
    }

    void _addColumn() {
      _addElement(
        Container(
          width: 2, // Adjust width as needed
          height: double.infinity,
          color: Colors.black,
        ),
        const Offset(50, 0),
      );
    }

    @override
   Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Invoice Design'),
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: _saveLayout,
        ),
        IconButton(
          icon: const Icon(Icons.upload_file),
          onPressed: _loadLayout,
        ),
      ],
    ),
    body: Container(
      color: Colors.grey[200], // Ensure this doesn't overlap with other widgets
      child: Stack(
        children: _elements.isNotEmpty
            ? _elements
            : [
                const Center(
                  child: Text(
                    'Tap + button to add elements',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
      ),
    ),
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: _uploadImage,
          child: const Icon(Icons.add_a_photo),
          heroTag: 'photo',
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          onPressed: _addTable,
          child: const Icon(Icons.table_chart),
          heroTag: 'table',
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          onPressed: _addColumn,
          child: const Icon(Icons.line_style),
          heroTag: 'column',
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          onPressed: _undoAction,
          child: const Icon(Icons.undo),
          heroTag: 'undo',
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          onPressed: _redoAction,
          child: const Icon(Icons.redo),
          heroTag: 'redo',
        ),
        const SizedBox(height: 16),
      ],
    ),
  );
}


    void _saveLayout() {
      List<Map<String, dynamic>> serializedElements = _elements.map((element) {
        return {
          'left': (element as Positioned).left,
          'top': element.top,
          'widget': (element.child as DraggableWidget).child.toJson(),
        };
      }).toList();
      String jsonLayout = jsonEncode(serializedElements);
      // Save jsonLayout to a file or database
    }

    void _loadLayout() {
      // Load jsonLayout from a file or database
      String jsonLayout = ''; // Replace with actual loading logic
      List<dynamic> decodedElements = jsonDecode(jsonLayout);
      setState(() {
        _elements = decodedElements.map((element) {
          return Positioned(
            left: element['left'],
            top: element['top'],
            child: DraggableWidget(
              child: WidgetFromJson(element['widget']),
              onDragEnd: (details) {
                setState(() {
                  // Update the position in the list
                });
              },
            ),
          );
        }).toList();
      });
    }
  }

  class DraggableWidget extends StatelessWidget {
    final Widget child;
    final Function(DraggableDetails) onDragEnd;

    DraggableWidget({required this.child, required this.onDragEnd});

    @override
    Widget build(BuildContext context) {
      return Draggable(
        child: child,
        feedback: Material(
          child: child,
        ),
        childWhenDragging: Container(),
        onDraggableCanceled: (velocity, offset) {},
        onDragEnd: onDragEnd,
      );
    }
  }

  class TableWidget extends StatelessWidget {
    final int columns;
    final int rows;

    TableWidget({required this.columns, required this.rows});

    @override
    Widget build(BuildContext context) {
      return Container(
        width: columns * 100.0, // Example width calculation
        height: rows * 50.0, // Example height calculation
        color: Colors.white,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: List.generate(
            rows,
            (rowIndex) => TableRow(
              children: List.generate(
                columns,
                (colIndex) => TableCell(
                  child: Center(
                    child: Text('Cell $rowIndex-$colIndex'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  // Implement more widgets as needed (e.g., EditableTextWidget, ImageWidget)

  // Example method to convert a Widget to JSON
  extension on Widget {
    Map<String, dynamic> toJson() {
      // Implement serialization logic based on widget type
      if (this is Image) {
        return {
          'type': 'Image',
          // Add more properties as needed
        };
      } else if (this is TableWidget) {
        return {
          'type': 'TableWidget',
          'columns': (this as TableWidget).columns,
          'rows': (this as TableWidget).rows,
          // Add more properties as needed
        };
      }
      // Add more widget types as needed
      return {};
    }
  }

  // Example method to create a Widget from JSON
  Widget WidgetFromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'Image':
        return Image.asset('assets/default_image.png'); // Replace with actual image handling
      case 'TableWidget':
        return TableWidget(
          columns: json['columns'],
          rows: json['rows'],
        );
      // Add more widget types as needed
      default:
        return Container();
    }
  }
