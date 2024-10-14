import 'package:flutter/material.dart';

class BuyAirtimePage extends StatefulWidget {
  const BuyAirtimePage({super.key});

  @override
  _BuyAirtimePageState createState() => _BuyAirtimePageState();
}

class _BuyAirtimePageState extends State<BuyAirtimePage> {
  // Controllers to manage the input fields
  final TextEditingController numberController =
      TextEditingController(); // Controller for the phone number input
  final TextEditingController amountController =
      TextEditingController(); // Controller for the airtime amount input

  // Key for the form to manage validation
  final _airtimeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Airtime'), // Title displayed in the AppBar
        backgroundColor: Colors.deepOrange, // Background color of the AppBar
        centerTitle: true, // This centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form content
        child: Form(
          key: _airtimeFormKey, // Assign the form key to manage form validation
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Centers the column's content vertically
            children: [
              // Input field for phone number
              TextFormField(
                controller:
                    numberController, // Connect the controller to manage the phone number input
                decoration: const InputDecoration(
                  labelText:
                      'Phone Number', // Label for the phone number input field
                  border:
                      OutlineInputBorder(), // Outline border around the input field
                ),
                keyboardType: TextInputType
                    .phone, // Numeric keyboard for phone number input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipient\'s number'; // Error if the field is empty
                  }
                  if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                    return 'Please enter a valid 11-digit phone number'; // Ensure valid phone number
                  }
                  return null; // No error if the field is valid
                },
              ),
              const SizedBox(height: 16.0), // Space between the input fields

              // Input field for airtime amount
              TextFormField(
                controller:
                    amountController, // Connect the controller to manage the airtime amount input
                decoration: const InputDecoration(
                  labelText:
                      'Amount', // Label for the airtime amount input field
                  border:
                      OutlineInputBorder(), // Outline border around the input field
                ),
                keyboardType: TextInputType
                    .number, // Numeric keyboard for entering amount
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
                  height:
                      20.0), // Space between the input fields and the button

              // Buy Airtime button
              ElevatedButton(
                onPressed: () {
                  // Validate the form before proceeding with the buy airtime logic
                  if (_airtimeFormKey.currentState!.validate()) {
                    // Logic to handle the buy airtime action when the button is pressed
                    String number = numberController
                        .text; // Get the phone number from the input field
                    String amount = amountController
                        .text; // Get the airtime amount from the input field

                    // Show a message with the payment details (for demonstration)
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Purchase Confirmation'),
                          content: Text(
                            'Buying $amount of Airtime for $number\n'
                            'Phone Number: $number\n'
                            'Amount: $amount',
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

                    // Add the buy airtime logic here (e.g., API call)
                    //print('Buying $amount of airtime for $number'); // Debug output to the console
                    // Optionally, you can show a confirmation message or navigate to another page after the operation
                  }
                }, // Text displayed on the button
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepOrange, // Background color of the button
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0), // Padding inside the button
                ),
                child: Text('Buy Airtime'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
