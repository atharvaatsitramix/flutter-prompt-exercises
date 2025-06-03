import 'package:flutter/material.dart';
import 'widgets/labeled_text_field.dart';

/// Simple usage examples of the LabeledTextField component
class ExampleUsage extends StatefulWidget {
  @override
  _ExampleUsageState createState() => _ExampleUsageState();
}

class _ExampleUsageState extends State<ExampleUsage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Usage Examples')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Example 1: Using predefined name field (1 line of code!)
            CommonFields.name(controller: _nameController),
            
            SizedBox(height: 16),
            
            // Example 2: Using predefined email field (1 line of code!)
            CommonFields.email(controller: _emailController),
            
            SizedBox(height: 16),
            
            // Example 3: Custom configuration (still simple!)
            LabeledTextField(
              controller: _customController,
              label: 'Custom Field',
              hintText: 'This is completely customizable',
              isRequired: true,
              prefixIcon: Icons.star,
            ),
            
            SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: () {
                // Handle form submission
                print('Name: ${_nameController.text}');
                print('Email: ${_emailController.text}');
                print('Custom: ${_customController.text}');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
} 