#!/bin/bash

# Create the directory structure
mkdir -p lib/{screens,widgets,constants}

# Create main.dart
cat > lib/main.dart << 'EOL'
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const ShareBiteApp());
}

class ShareBiteApp extends StatelessWidget {
  const ShareBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShareBite',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
EOL

# Create constants/app_colors.dart
cat > lib/constants/app_colors.dart << 'EOL'
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4CAF50);
  static const primaryDark = Color(0xFF388E3C);
  static const primaryLight = Color(0xFFC8E6C9);
  static const accent = Color(0xFF8BC34A);
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const divider = Color(0xFFBDBDBD);
}
EOL

# Create widgets/custom_button.dart
cat > lib/widgets/custom_button.dart << 'EOL'
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
EOL

# Create screens/login_screen.dart
cat > lib/screens/login_screen.dart << 'EOL'
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'role_selection_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFC8E6C9),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 120),
                const SizedBox(height: 40),
                const Text(
                  'ShareBite',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Connecting food donors with those in need',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Continue',
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoleSelectionScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
EOL

# Create screens/role_selection_screen.dart
cat > lib/screens/role_selection_screen.dart << 'EOL'
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'donation_form_screen.dart';
import 'request_form_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'How would you like to use ShareBite?',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'I want to donate food',
              icon: Icons.people,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DonationFormScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'I need food donations',
              icon: Icons.food_bank,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequestFormScreen(),
                  ),
                );
              },
              color: Colors.orange,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Future: Implement admin dashboard
              },
              child: const Text('Are you an administrator?'),
            ),
          ],
        ),
      ),
    );
  }
}
EOL

# Create screens/donation_form_screen.dart
cat > lib/screens/donation_form_screen.dart << 'EOL'
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';

class DonationFormScreen extends StatefulWidget {
  const DonationFormScreen({super.key});

  @override
  State<DonationFormScreen> createState() => _DonationFormScreenState();
}

class _DonationFormScreenState extends State<DonationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _donorType;
  String? _foodType;
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _quantityController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _quantityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Donation'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Donor Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _donorType,
                decoration: const InputDecoration(
                  labelText: 'Donor Type',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'individual',
                    child: Text('Individual'),
                  ),
                  DropdownMenuItem(
                    value: 'business',
                    child: Text('Business'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _donorType = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select donor type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact Information',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter contact information' : null,
              ),
              const SizedBox(height: 24),
              const Text(
                'Donation Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _foodType,
                decoration: const InputDecoration(
                  labelText: 'Food Type',
                  prefixIcon: Icon(Icons.fastfood),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'perishable',
                    child: Text('Perishable (fresh food)'),
                  ),
                  DropdownMenuItem(
                    value: 'non-perishable',
                    child: Text('Non-perishable (packaged food)'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _foodType = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select food type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity (estimated servings)',
                  prefixIcon: Icon(Icons.scale),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter quantity' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Pickup Location',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter pickup location' : null,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Submit Donation',
                icon: Icons.send,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Simulate submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Donation submitted successfully!'),
                      ),
                    );
                    // In future: Submit to Firebase
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
EOL

# Create screens/request_form_screen.dart
cat > lib/screens/request_form_screen.dart << 'EOL'
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import 'recipient_dashboard_screen.dart';

class RequestFormScreen extends StatefulWidget {
  const RequestFormScreen({super.key});

  @override
  State<RequestFormScreen> createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _orgType;
  final _nameController = TextEditingController();
  final _orgController = TextEditingController();
  final _contactController = TextEditingController();
  final _foodNeedController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _orgController.dispose();
    _contactController.dispose();
    _foodNeedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Request'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Recipient Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _orgType,
                decoration: const InputDecoration(
                  labelText: 'Organization Type',
                  prefixIcon: Icon(Icons.business),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'shelter',
                    child: Text('Food Shelter'),
                  ),
                  DropdownMenuItem(
                    value: 'organization',
                    child: Text('Non-profit Organization'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _orgType = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select organization type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Contact Person',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter contact person' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _orgController,
                decoration: const InputDecoration(
                  labelText: 'Organization Name',
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter organization name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact Information',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter contact information' : null,
              ),
              const SizedBox(height: 24),
              const Text(
                'Food Needs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _foodNeedController,
                decoration: const InputDecoration(
                  labelText: 'Type of Food Needed',
                  prefixIcon: Icon(Icons.fastfood),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter food needs' : null,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Submit Request',
                icon: Icons.send,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Simulate submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Request submitted successfully!'),
                      ),
                    );
                    // Navigate to dashboard
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecipientDashboardScreen(),
                      ),
                    );
                  }
                },
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
EOL

# Create screens/recipient_dashboard_screen.dart
cat > lib/screens/recipient_dashboard_screen.dart << 'EOL'
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class RecipientDashboardScreen extends StatelessWidget {
  const RecipientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Future: Refresh data from Firestore
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.dashboard, size: 48, color: AppColors.primary),
                    const SizedBox(height: 8),
                    const Text(
                      'Available Donations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '5 pending donations',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Recent Donations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Simulated data
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.fastfood, color: AppColors.primary),
                      title: Text('Donation \${index + 1}'),
                      subtitle: const Text('Fresh food - 20 servings'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        // Future: Show donation details
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Create New Request'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequestFormScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
EOL

echo "ShareBite Flutter app structure created successfully!"