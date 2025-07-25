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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Request'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Recipient Information',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                DropdownButtonFormField<String>(
                  value: _orgType,
                  decoration: const InputDecoration(
                    labelText: 'Organization Type',
                    prefixIcon: Icon(Icons.business),
                    border: OutlineInputBorder(),
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
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Person',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter contact person' : null,
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  controller: _orgController,
                  decoration: const InputDecoration(
                    labelText: 'Organization Name',
                    prefixIcon: Icon(Icons.business),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter organization name' : null,
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Information',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter contact information' : null,
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  'Food Needs',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  controller: _foodNeedController,
                  decoration: const InputDecoration(
                    labelText: 'Type of Food Needed',
                    prefixIcon: Icon(Icons.fastfood),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter food needs' : null,
                ),
                SizedBox(height: size.height * 0.04),
                CustomButton(
                  text: 'Submit Request',
                  icon: Icons.send,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Request submitted successfully!'),
                        ),
                      );
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
      ),
    );
  }
}