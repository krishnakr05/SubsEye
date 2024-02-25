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
          return SubscriptionCard(
            subscriptionName: subscriptions[index],
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

class SubscriptionCard extends StatelessWidget {
  final String subscriptionName;

  const SubscriptionCard({
    Key? key,
    required this.subscriptionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          subscriptionName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            // Add functionality to delete subscription
          },
        ),
      ),
    );
  }
}