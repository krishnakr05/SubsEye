import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> saveSubscriptionDetails(String subscriptionName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/subscription_details.json');

  final subscriptionDetails = {
    'subscriptionName': subscriptionName,
  };

  await file.writeAsString(json.encode(subscriptionDetails));
}

Future<List<String>> loadSubscriptionDetails() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/subscription_details.json');

  if (!file.existsSync()) {
    return [];
  }

  final String contents = file.readAsStringSync();
  final Map<String, String> subscriptionDetailsList = json.decode(contents);

    final List<String> subscriptionNames = [];
  for (final subscriptionDetails in subscriptionDetailsList.keys) {
    final String subscriptionName = subscriptionDetailsList[subscriptionDetails] as String;
    subscriptionNames.add(subscriptionName);
  }

  return subscriptionNames;
}



void main() {
  runApp(const Subseye());
}

class Subseye extends StatelessWidget {
  const Subseye({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MySubs(),
    );
  }
}

class MySubs extends StatefulWidget {
  const MySubs({Key? key}) : super(key: key);

  @override
  State<MySubs> createState() => _MySubsState();
}

class _MySubsState extends State<MySubs> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
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
        SubscriptionScreen(),SettingsScreen(),

        /// Settings page
       
        
      ][currentPageIndex],
    );
  }
}



class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  String _notificationIcon = 'bell';
  String _country = 'United States';
  String _currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.doorbell),
          onPressed: () {
            // Handle the notification icon press here
          //   showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         title: Text('Notification'),
          //         content: Text('$_notificationIcon'),
          //      );
          //    },
          //  );
        }
        ),
        ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add TextField and DropdownButtonFormField widgets here
            Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Settings'),
    SizedBox(height: 20),

    TextField(
      decoration: InputDecoration(
        labelText: 'Country',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          _country = value;
        });
      },
    ),
    SizedBox(height: 10),
    DropdownButtonFormField<String>(
      value: _currency,
      decoration: InputDecoration(
        labelText: 'Currency',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          _currency = value!;
        });
      },
      items: [
        DropdownMenuItem(
          child: Text('USD'),
          value: 'USD',
        ),
        DropdownMenuItem(
          child: Text('EUR'),
          value: 'EUR',
        ),
        DropdownMenuItem(
          child: Text('INR'),
          value: 'INR',
        ),
      ],
    ),
    
  ],
),
          ],
        ),
      ),
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

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Notifications Screen'),
      ),
    );
  }
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

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
   List<String> subscriptions= [];

    @override
    void initState() {
      super.initState();
      loadSubscriptionDetails().then((subscriptionNames) {
        setState(() {
          subscriptions = subscriptionNames;
        });
      });
    }
  // final List<String> subscriptions = [
  //   'Netflix',
  //   'Spotify',
  //   'Amazon Prime',
  //   'HBO Max',
  //   'Disney+'
  // ];

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
                  saveSubscriptionDetails(newSubscription);
                }
                  Navigator.pop(context);
                },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _viewBillingDetails(String subscriptionName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillingDetailsScreen(subscriptionName: subscriptionName),
      ),
    );
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
          return InkWell(
            onTap: () {
              _viewBillingDetails(subscriptions[index]);
            },
            child: SubscriptionCard(
            subscriptionName: subscriptions[index],
            onDelete: () {
              _deleteSubscription(subscriptions[index]);
            },
          ),
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
  
  void _deleteSubscription(String subscription) {
  setState(() {
      subscriptions.remove(subscription);
    });
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



class BillingDetailsScreen extends StatefulWidget {
  final String subscriptionName;

  const BillingDetailsScreen({required this.subscriptionName});

  @override
  _BillingDetailsScreenState createState() => _BillingDetailsScreenState();
}

class _BillingDetailsScreenState extends State<BillingDetailsScreen> {
  String _planType = '1 Month';
  DateTime _renewalDate = DateTime.now();
  double _cost = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Billing Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter billing details for ${widget.subscriptionName}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _planType,
              decoration: InputDecoration(
                labelText: 'Subscription Plan Type',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _planType = value!;
                  if (value == '1 Month') {
                    _renewalDate = DateTime.now().add(Duration(days: 30));
                  } else if (value == '3 Months') {
                    _renewalDate = DateTime.now().add(Duration(days: 90));
                  } else if (value == '6 Months') {
                    _renewalDate = DateTime.now().add(Duration(days: 180));
                  } else if (value == '1 Year') {
                    _renewalDate = DateTime.now().add(Duration(days: 365));
                  }
                });
              },
              items: [
                DropdownMenuItem<String>(
                  child: Text('1 Month'),
                  value: '1 Month',
                ),
                DropdownMenuItem<String>(
                  child: Text('3 Months'),
                  value: '3 Months',
                ),
                DropdownMenuItem<String>(
                  child: Text('6 Months'),
                  value: '6 Months',
                ),
                DropdownMenuItem<String>(
                  child: Text('1 Year'),
                  value: '1 Year',
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Date to be Renewed',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _renewalDate = DateTime.parse(value);
                });
              },
              readOnly: true,
              controller: TextEditingController(
                text: _renewalDate.toString(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cost to be Paid',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _cost = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the billing details and navigate back
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}