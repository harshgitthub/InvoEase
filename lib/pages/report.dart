import 'package:cloneapp/pages/home.dart';
import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REPORTS"),
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
            icon: const Icon(Icons.support_agent_rounded),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notification_add_rounded),
            onPressed: () {
              // Implement filter functionality
            },
          ),
        ],
      ),
      drawer: drawer(context),
      body: ListView(
        children: [
          // Sales heading in blue color
          Container(
            padding: const EdgeInsets.all(20.0),
            child:const Text(
              'Sales',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Subheadings
          ListTile(
            title: const Text('Sales by Customer'),
            onTap: () {
              
            },
          ),
          ListTile(
            title: const Text('Sales by Item'),
            onTap: () {
             
            },
          ),
          ListTile(
            title: const Text('Sales by Sales Person'),
            onTap: () {
             
            },
          ),
         const Divider(),

         Container(
            padding: const EdgeInsets.all(20.0),
            child:const Text(
              'Receivables',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Subheadings
          ListTile(
            title: const Text('Customer Balances'),
            onTap: () {
              
            },
          ),
          ListTile(
            title: const Text('Aging Summary'),
            onTap: () {
             
            },
          ),
          ListTile(
            title: const Text('Payments Received'),
            onTap: () {
             
            },
          ),
         const Divider(),
         Container(
            padding: const EdgeInsets.all(20.0),
            child:const Text(
              'Expenses',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Subheadings
          ListTile(
            title: const Text('Expenses by Category'),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
