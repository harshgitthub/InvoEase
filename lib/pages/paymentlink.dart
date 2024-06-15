import 'package:cloneapp/pages/home.dart';
import 'package:flutter/material.dart';

class Paymentlink extends StatelessWidget {
  const Paymentlink({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 4,
    child: Scaffold(
       appBar: AppBar(
        title: const Text("PAYMENT LINK"),
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
        
        actions: [
          IconButton(
            icon: const Icon(Icons.filter),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement filter functionality
            },
          ),
        ],
        bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Generated'),
              Tab(text: 'Paid'),
              Tab(text: 'Expired'),
               
            ],
          ),
      ),
      drawer: drawer(context),
       body: const TabBarView(
          children: [
            // Contents of Tab 1
            Center(
              child: Text('1'),
            ),
            // Contents of Tab 2
            Center(
              child: Text('2'),
            ),
            Center(
              child: Text('3'),
            ),
             Center(
              child: Text('4'),
            ),
           ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          // Add functionality for the floating action button
        },
        child: const Icon(Icons.add),
      ),
    ),
  );
  }
}
