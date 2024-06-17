import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text('ClientID'),
              TextField(),
            ],
          ),
          Row(
            children: [
              Text('ClientSecret'),
              TextField(),
            ],
          ),
          Row(
            children: [
              Text('HostName'),
              TextField(),
            ],
          ),
        ],
      ),
    );
  }
}
