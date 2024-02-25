 // Function to add a new subscription
  void _addSubscription(String newSubscription) {
    setState(() {
      subscriptions.add(newSubscription);
      // Clear the text field after adding subscription
      _subscriptionController.clear();
    });
  }

  // Function to delete a subscription
  void _deleteSubscription(int index) {
    setState(() {
      subscriptions.removeAt(index);
    });
  } 