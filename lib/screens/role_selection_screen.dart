import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'donation_form_screen.dart';
import 'request_form_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonWidth = size.width * 0.8; // 80% of screen width
    final buttonHeight = size.height * 0.07; // 7% of screen height

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'How would you like to use ShareBite?',
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.05),
                SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: CustomButton(
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
                ),
                SizedBox(height: size.height * 0.025),
                SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: CustomButton(
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
                ),
                SizedBox(height: size.height * 0.025),
                TextButton(
                  onPressed: () {
                    // Future: Implement admin dashboard
                  },
                  child: const Text('Are you an administrator?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}