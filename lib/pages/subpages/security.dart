

import 'package:flutter/material.dart';

class Security extends StatelessWidget {
  const Security({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy & Security"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildCard(
                title: 'App Lock',
                subtitle:
                    'Set app lock to keep your data secure and add a layer of security',
                icon: Icons.lock,
              ),
              _buildCard(
                title: 'Send diagnostics and usage statistics',
                icon: Icons.analytics,
              ),
              _buildCard(
                title: 'Crash Reports',
                icon: Icons.bug_report,
              ),
              _buildCard(
                title: 'Send Anonymously',
                subtitle:
                    'Help us improve user experience by automatically sending diagnostic and usage statistics',
                icon: Icons.send,
              ),
              _buildCard(
                title: 'Push Navigation',
                subtitle: 'Choose to enable or disable push notifications',
                icon: Icons.notifications,
              ),
              _buildDivider(),
              _buildListTile(
                title: 'Acknowledgement',
                icon: Icons.info,
              ),
              _buildDivider(),
              _buildListTile(
                title: 'Terms of Service',
                icon: Icons.article,
              ),
              _buildDivider(),
              _buildListTile(
                title: 'Privacy Policy',
                icon: Icons.privacy_tip,
              ),
              _buildDivider(),
              _buildListTile(
                title: 'Close Account',
                subtitle:
                    'Closing your account will permanently delete your data associated with your account, the deleted data cannot be recovered',
                icon: Icons.delete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    String? subtitle,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 2,
      height: 16,
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildListTile({
    required String title,
    String? subtitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}
