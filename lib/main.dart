import 'package:flutter/material.dart';
import 'widgets/labeled_text_field.dart';
import 'list_view_examples.dart';
import 'app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

class SimpleTextFieldDemo extends StatefulWidget {
  @override
  _SimpleTextFieldDemoState createState() => _SimpleTextFieldDemoState();
}

class _SimpleTextFieldDemoState extends State<SimpleTextFieldDemo> {
  final TextEditingController _textController = TextEditingController();
  String _displayedText = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showText() {
    setState(() {
      _displayedText = _textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Text Field'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Single text field using our reusable component
            LabeledTextField(
              controller: _textController,
              label: 'Enter some text',
              hintText: 'Type something here...',
              prefixIcon: Icons.edit,
            ),
            
            SizedBox(height: 24),
            
            // Button to show the text
            ElevatedButton(
              onPressed: _showText,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Show Text',
                style: TextStyle(fontSize: 16),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Button to navigate to ListView examples
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListViewExamples()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Explore ListView Approaches',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            
            SizedBox(height: 32),
            
            // Display what user has written (only after button press)
            Text(
              'You wrote:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            
            SizedBox(height: 8),
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                _displayedText.isEmpty ? 'Press the button to show your text...' : _displayedText,
                style: TextStyle(
                  fontSize: 18,
                  color: _displayedText.isEmpty ? Colors.grey.shade500 : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 