import 'package:cloneapp/pages/home.dart';
import 'package:flutter/material.dart';

class Paymentreceived extends StatelessWidget {
  const Paymentreceived({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
    length: 3,
    child:Scaffold(
       appBar: AppBar(
        title: const Text("PAYMENT RECEIVED"),
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
              Tab(text: 'Invoice'),
              Tab(text: 'Retainer'),
               
            ],
          ),
      ),
      drawer: drawer(context),
       body: const TabBarView(
          children: [
            // Contents of Tab 1
            Center(
              child: Text('All'),
            ),
            // Contents of Tab 2
            Center(
              child: Text('Invoice'),
            ),
            Center(
              child: Text('Retainer'),
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
