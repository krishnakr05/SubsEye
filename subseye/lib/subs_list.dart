import 'package:flutter/material.dart';

void main() {
  runApp(SubscriptionApp());
}

class SubscriptionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subscription Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SubscriptionScreen(),
    );
  }
}

class SubscriptionScreen extends StatelessWidget {
  final List<String> subscriptions = [
    'Netflix',
    'Spotify',
    'Amazon Prime',
    'HBO Max',
    'Disney+'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Subscriptions'),
      ),
      body: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subscriptions[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Add functionality to delete subscription
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to add new subscription
        },
        child: Icon(Icons.add),
      ),
    );
  }
}