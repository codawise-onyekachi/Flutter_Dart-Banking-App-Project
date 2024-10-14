import 'package:flutter/material.dart';

// Defining the SendMoneyPage class
class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  // Controllers to manage the input fields
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController recipientNumberController =
      TextEditingController(); // Controller for recipient's number input
  final TextEditingController amountController =
      TextEditingController(); // Controller for amount input

  // Form key to manage validation
  final _sendFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'), // Title displayed in the AppBar
        backgroundColor: Colors.deepOrange, // Background color of the AppBar
        centerTitle: true, // This centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: Form(
          key:  _sendFormKey, // Connect form key for validation
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the column vertically
            children: [
              // Input field for recipient's name
              TextFormField(
                controller:
                    recipientNameController, // Connect the controller to the input field
                decoration: const InputDecoration(
                  labelText:
                      'Recipient\'s Name', // Label displayed in the input field
                  border:
                      OutlineInputBorder(), // Outline border style for the input field
                ),
                keyboardType: TextInputType
                    .text, // Show numeric keyboard for phone number input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipient\'s name'; // Error if the field is empty
                  }
                  if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                    return 'Please enter a valid name'; // Ensure valid phone number
                  }
                  return null; // No error if the field is valid
                },
              ),
              const SizedBox(height: 16.0), // Add space between the fields

              // Input field for recipient's number
              TextFormField(
                controller:
                    recipientNumberController, // Connect the controller to the input field
                decoration: const InputDecoration(
                  labelText:
                      'Recipient\'s Number', // Label displayed in the input field
                  border:
                      OutlineInputBorder(), // Outline border style for the input field
                ),
                keyboardType: TextInputType
                    .phone, // Show numeric keyboard for phone number input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipient\'s number'; // Error if the field is empty
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number'; // Ensure valid phone number
                  }
                  return null; // No error if the field is valid
                },
              ),
              const SizedBox(height: 16.0), // Add space between the fields

              // Input field for amount
              TextFormField(
                controller:
                    amountController, // Connect the controller to the input field
                decoration: const InputDecoration(
                  labelText: 'Amount', // Label displayed in the input field
                  border:
                      OutlineInputBorder(), // Outline border style for the input field
                ),
                keyboardType: TextInputType
                    .number, // Show numeric keyboard for amount input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount'; // Error if the field is empty
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid amount greater than 0'; // Ensure valid number and non-negative
                  }
                  return null; // No error if the field is valid
                },
              ),
              const SizedBox(
                  height: 20.0), // Add space between the fields and button

              // Send Money button
              ElevatedButton(
                onPressed: () {
                  // Validate the form before performing the send action
                  if ( _sendFormKey.currentState!.validate()) {
                    String name = recipientNameController.text;
                    String recipient = recipientNumberController
                        .text; // Get the recipient's number from input
                    String amount = amountController.text;
                    // Get the amount from input

                    // Add your send money logic here (e.g., API call)
                    //print(
                        //'Sending $amount to $recipient'); // Debug output to console

                    // Optionally show a success message or navigate to another page
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Sending $amount to $recipient'),
                    ));

                    // Show a message with the payment details (for demonstration)
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Payment Confirmation'),
                          content: Text(
                            'Sending $amount to $recipient\n'
                            'Recipient Name: $name\n'
                            'Account Number: $recipient',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('OK'), // Button text
                            ),
                          ],
                        );
                      },
                    );
                  }
                }, // Text displayed on the button
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepOrange, // Background color of the button
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0), // Padding for the button
                ),
                child: Text('Send Money'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
