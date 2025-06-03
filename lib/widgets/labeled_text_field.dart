import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? description;
  final bool isRequired;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const LabeledTextField({
    Key? key,
    required this.controller,
    this.label,
    this.labelText,
    this.hintText,
    this.helperText,
    this.description,
    this.isRequired = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.enabled = true,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // External label (if provided)
        if (label != null) ...[
          Text(
            label! + (isRequired ? ' *' : ''),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          if (description != null) ...[
            SizedBox(height: 4),
            Text(
              description!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
          SizedBox(height: 8),
        ],
        
        // Text field
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            helperText: helperText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: _buildSuffixIcon(),
            alignLabelWithHint: maxLines > 1,
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    List<Widget> suffixWidgets = [];
    
    // Add required indicator if needed and no external label
    if (isRequired && label == null) {
      suffixWidgets.add(
        Text(
          '*',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }
    
    // Add custom suffix icon if provided
    if (suffixIcon != null) {
      suffixWidgets.add(suffixIcon!);
    }
    
    if (suffixWidgets.isEmpty) return null;
    
    if (suffixWidgets.length == 1) {
      return suffixWidgets.first;
    }
    
    // Multiple suffix elements
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: suffixWidgets,
    );
  }
}

// Predefined field types for common use cases
class CommonFields {
  // Name field
  static Widget name({
    required TextEditingController controller,
    bool isRequired = true,
    String? description,
  }) {
    return LabeledTextField(
      controller: controller,
      label: 'Full Name',
      hintText: 'e.g., John Doe',
      isRequired: isRequired,
      prefixIcon: Icons.person,
      textCapitalization: TextCapitalization.words,
      description: description,
    );
  }

  // Email field
  static Widget email({
    required TextEditingController controller,
    bool isRequired = true,
    String? helperText,
  }) {
    return LabeledTextField(
      controller: controller,
      labelText: 'Email Address',
      hintText: 'Enter your email',
      helperText: helperText ?? 'We\'ll never share your email',
      isRequired: isRequired,
      prefixIcon: Icons.email,
      suffixIcon: Icon(Icons.verified_user, size: 20),
      keyboardType: TextInputType.emailAddress,
    );
  }

  // Phone field
  static Widget phone({
    required TextEditingController controller,
    bool isRequired = false,
  }) {
    return LabeledTextField(
      controller: controller,
      label: 'Phone Number',
      labelText: 'Enter your phone number',
      hintText: '+1 (555) 123-4567',
      isRequired: isRequired,
      prefixIcon: Icons.phone,
      keyboardType: TextInputType.phone,
    );
  }

  // Message/Note field
  static Widget message({
    required TextEditingController controller,
    String label = 'Message',
    String? description,
    bool isRequired = false,
    int maxLines = 3,
  }) {
    return LabeledTextField(
      controller: controller,
      label: label + (isRequired ? '' : ' (Optional)'),
      labelText: 'Your ${label.toLowerCase()}',
      hintText: 'Type your ${label.toLowerCase()} here...',
      description: description ?? 'Tell us what you\'re thinking about',
      isRequired: isRequired,
      prefixIcon: Icons.message,
      textCapitalization: TextCapitalization.sentences,
      maxLines: maxLines,
    );
  }

  // Password field
  static Widget password({
    required TextEditingController controller,
    bool isRequired = true,
    bool isVisible = false,
    VoidCallback? onVisibilityToggle,
  }) {
    return LabeledTextField(
      controller: controller,
      label: 'Password',
      labelText: 'Enter your password',
      hintText: 'At least 8 characters',
      isRequired: isRequired,
      prefixIcon: Icons.lock,
      suffixIcon: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
          size: 20,
        ),
        onPressed: onVisibilityToggle,
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }

  // Search field
  static Widget search({
    required TextEditingController controller,
    String hintText = 'Search...',
    VoidCallback? onClear,
  }) {
    return LabeledTextField(
      controller: controller,
      labelText: 'Search',
      hintText: hintText,
      prefixIcon: Icons.search,
      suffixIcon: controller.text.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.clear, size: 20),
              onPressed: onClear,
            )
          : null,
      keyboardType: TextInputType.text,
    );
  }
} 