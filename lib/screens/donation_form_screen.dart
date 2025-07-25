import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';

class DonationFormScreen extends StatefulWidget {
  const DonationFormScreen({super.key});

  @override
  State<DonationFormScreen> createState() => _DonationFormScreenState();
}

class _DonationFormScreenState extends State<DonationFormScreen> {
  // Flow control
  int _currentStep = 0; // 0 = form, 1 = confirmation, 2 = history
  final _formKey = GlobalKey<FormState>();

  // Form data
  String? _donorType;
  String? _foodType;
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _quantityController = TextEditingController();
  final _locationController = TextEditingController();

  // Donation history
  final List<Map<String, dynamic>> _donations = [
    {
      'date': 'May 15',
      'type': 'Packaged goods',
      'quantity': '25 boxes',
      'status': 'Completed',
      'recipient': 'Community Kitchen',
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _quantityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitDonation() {
    if (_formKey.currentState!.validate()) {
      // Add new donation to history
      _donations.insert(0, {
        'date': 'Today',
        'type': _foodType ?? 'Various',
        'quantity': '${_quantityController.text} servings',
        'status': 'Pending',
        'recipient': 'Finding match...',
      });

      setState(() => _currentStep = 1); // Move to confirmation
    }
  }

  void _editDonation() {
    setState(() => _currentStep = 0); // Back to form
  }

  void _confirmAndViewHistory() {
    setState(() => _currentStep = 2); // Move to history
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentStep == 0
              ? 'New Donation'
              : _currentStep == 1
              ? 'Donation Confirmed'
              : 'Your Donations',
        ),
        centerTitle: true,
        actions: _currentStep == 1
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _editDonation,
                ),
              ]
            : null,
      ),
      body: _buildCurrentStep(),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildDonationForm();
      case 1:
        return _buildConfirmationCard();
      case 2:
        return _buildHistoryView();
      default:
        return _buildDonationForm();
    }
  }

  Widget _buildDonationForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Donor Information
            _buildSectionHeader('Your Information'),
            _buildDropdownField(
              label: 'Donor Type',
              value: _donorType,
              items: const ['Individual', 'Business/Organization'],
              onChanged: (value) => setState(() => _donorType = value),
            ),
            _buildTextFormField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person,
            ),
            _buildTextFormField(
              controller: _contactController,
              label: 'Contact Number',
              icon: Icons.phone,
            ),

            // Donation Details
            _buildSectionHeader('Donation Details'),
            _buildDropdownField(
              label: 'Food Type',
              value: _foodType,
              items: const [
                'Fresh produce',
                'Packaged goods',
                'Prepared meals',
                'Dairy',
                'Bakery',
              ],
              onChanged: (value) => setState(() => _foodType = value),
            ),
            _buildTextFormField(
              controller: _quantityController,
              label: 'Quantity',
              icon: Icons.scale,
              keyboardType: TextInputType.number,
            ),
            _buildTextFormField(
              controller: _locationController,
              label: 'Pickup Location',
              icon: Icons.location_on,
            ),

            const SizedBox(height: 24),
            CustomButton(
              text: 'Submit Donation',
              icon: Icons.send,
              onPressed: _submitDonation,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationCard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Bank-style confirmation card
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'SHAREBITE DONATION',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.verified, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 24),
                _buildCardRow('Donor', _nameController.text),
                _buildCardRow('Type', _donorType ?? 'Not specified'),
                _buildCardRow('Food', _foodType ?? 'Various'),
                _buildCardRow(
                  'Quantity',
                  '${_quantityController.text} servings',
                ),
                _buildCardRow('Location', _locationController.text),
                const SizedBox(height: 16),
                const Text(
                  'Thank you for your generosity!',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Next steps
          const SizedBox(height: 32),
          const Text(
            'Next Steps',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.notifications, color: AppColors.primary),
            title: Text('Confirmation message will be sent'),
          ),
          const ListTile(
            leading: Icon(Icons.person, color: AppColors.primary),
            title: Text('Recipient will contact you within 24 hours'),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _donations.length,
      itemBuilder: (context, index) {
        final donation = _donations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      donation['date'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Chip(
                      label: Text(donation['status']),
                      backgroundColor: donation['status'] == 'Completed'
                          ? Colors.green[100]
                          : Colors.orange[100],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${donation['type']} • ${donation['quantity']}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Going to: ${donation['recipient']}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomButtons() {
    if (_currentStep == 1) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: 'Confirm & View History',
                icon: Icons.check_circle,
                onPressed: _confirmAndViewHistory,
              ),
              const SizedBox(height: 8),
              CustomButton(
                text: 'Edit Donation',
                icon: Icons.edit,
                onPressed: _editDonation,
                color: Colors.grey[600]!,
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  // Helper Widgets
  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        value: value,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildCardRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
