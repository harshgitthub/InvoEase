import 'package:cloneapp/pages/home.dart';
import 'package:flutter/material.dart';

class Estimate extends StatelessWidget {
  const Estimate({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ESTIMATE"),
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
              Tab(text: 'Sent'),
               Tab(text: 'Accepted'),
              Tab(text: 'Draft'),
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
              child: Text('Sent'),
            ),
            Center(
              child: Text('Accepted'),
            ),
            Center(
            child: Text('Draft'),
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