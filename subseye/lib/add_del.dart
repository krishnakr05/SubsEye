import 'package:flutter/material.dart';

void main() {
  runApp(SubscriptionApp());
}

// Rest of your code...


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

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final List<String> subscriptions = [
    'Netflix',
    'Spotify',
    'Amazon Prime',
    'HBO Max',
    'Disney+'
  ];

  void _addSubscription(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Add New Subscription'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Subscription Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newSubscription = controller.text.trim();
                if (newSubscription.isNotEmpty) {
                  setState(() {
                    subscriptions.add(newSubscription);
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSubscription(int index) {
    setState(() {
      subscriptions.removeAt(index);
    });
  }

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
            onDelete: () {
              _deleteSubscription(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addSubscription(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String subscriptionName;
  final VoidCallback onDelete;

  const SubscriptionCard({
    Key? key,
    required this.subscriptionName,
    required this.onDelete,
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
          onPressed: onDelete,
        ),
      ),
    );
  }
}




class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.settings)),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: theme.textTheme.headline6,
              ),
            ),
          ),
        ),

        /// Settings page
        Center(
          child: Text(
            'Settings page',
            style: theme.textTheme.headline6,
          ),
        ),
      ][currentPageIndex],
    );
  }
}

class NavigationBar extends StatelessWidget {
  final ValueChanged<int> onDestinationSelected;
  final Color indicatorColor;
  final int selectedIndex;
  final List<NavigationDestination> destinations;

  const NavigationBar({
    Key? key,
    required this.onDestinationSelected,
    required this.indicatorColor,
    required this.selectedIndex,
    required this.destinations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
          icon: destination.icon,
          label: destination.label,
        );
      }).toList(),
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.60),
      selectedIconTheme: IconThemeData(color: indicatorColor),
      unselectedIconTheme:
          IconThemeData(color: theme.colorScheme.onSurface.withOpacity(0.60)),
      showUnselectedLabels: true,
    );
  }
}

class NavigationDestination {
  final Widget icon;
  final Widget? selectedIcon;
  final String label;

  const NavigationDestination({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}

class Badge extends StatelessWidget {
  final Widget child;

  const Badge({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              '!', // This can be replaced with the count of notifications
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
