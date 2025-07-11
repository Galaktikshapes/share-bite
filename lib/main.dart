// Full ShareBite MVP UI Code – All Core Screens

import 'package:flutter/material.dart';

// ------------------------- HomeScreen -------------------------
class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? intent; // "donate" or "receive"
  String? donorType; // "individual" or "business"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ShareBite'), centerTitle: true),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: intent == null
            ? _buildMainOptions()
            : intent == "donate" && donorType == null
            ? _buildDonorTypeSelector()
            : _buildNextScreenPlaceholder(),
      ),
    );
  }

  Widget _buildMainOptions() {
    return Center(
      key: const ValueKey('mainOptions'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hi ${widget.userName}! What would you like to do today?',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _optionButton(
                  icon: Icons.volunteer_activism_outlined,
                  label: 'Donate',
                  onTap: () => setState(() => intent = "donate"),
                ),
                const SizedBox(width: 30),
                _optionButton(
                  icon: Icons.inventory_outlined,
                  label: 'Receive',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecipientDashboardScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 28),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onTap,
    );
  }

  Widget _buildDonorTypeSelector() {
    return Center(
      key: const ValueKey('donorTypeSelector'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Donating as:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _optionButton(
                  icon: Icons.person_outline,
                  label: 'Individual',
                  onTap: () => setState(() => donorType = "individual"),
                ),
                const SizedBox(width: 30),
                _optionButton(
                  icon: Icons.storefront_outlined,
                  label: 'Business',
                  onTap: () => setState(() => donorType = "business"),
                ),
              ],
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () => setState(() => intent = null),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextScreenPlaceholder() {
    return Center(
      key: const ValueKey('nextScreen'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Proceeding as ${donorType == "business" ? "Business Donor" : "Individual Donor"}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DonationFormScreen(donorType: donorType!),
                ),
              );
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

// ------------------------- DonationFormScreen -------------------------
class DonationFormScreen extends StatelessWidget {
  final String donorType; // "individual" or "business"
  const DonationFormScreen({super.key, required this.donorType});

  @override
  Widget build(BuildContext context) {
    final isBusiness = donorType == "business";

    return Scaffold(
      appBar: AppBar(title: const Text("Create Donation")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            if (isBusiness)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Business Name",
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Item",
                hintText: "e.g. Bread, Jacket",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: "food", child: Text("Food")),
                DropdownMenuItem(value: "clothing", child: Text("Clothing")),
              ],
              onChanged: (val) {},
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Quantity (optional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Notes (optional)",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle submit
              },
              child: const Text("Submit Donation"),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------- RequestFormScreen -------------------------
class RequestFormScreen extends StatelessWidget {
  const RequestFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Request Help")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "What do you need?",
                hintText: "e.g. Jacket for 7-year-old, Bread and Milk",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: "food", child: Text("Food")),
                DropdownMenuItem(value: "clothing", child: Text("Clothing")),
              ],
              onChanged: (val) {},
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Notes (optional)",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle submit
              },
              child: const Text("Submit Request"),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------- RecipientDashboardScreen -------------------------
class RecipientDashboardScreen extends StatelessWidget {
  const RecipientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Donations")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text("Bread and Milk"),
            subtitle: Text("Donated by KFC Soshanguve"),
            trailing: Text("1.2 km away"),
          ),
          Divider(),
          ListTile(
            title: Text("Winter Jacket (Size 7Y Male)"),
            subtitle: Text("Donated by Pick n Pay Wonderpark"),
            trailing: Text("4 km away"),
          ),
        ],
      ),
    );
  }
}
