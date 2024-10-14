import 'package:flutter/material.dart';
import 'package:pocket_banking/services/m_pesa_service.dart';

// Defining the PayBillsPage class, which is a StatefulWidget
class PayBillsPage extends StatefulWidget {
  const PayBillsPage({super.key});

  @override
  State<PayBillsPage> createState() => _PayBillsPageState();
}

class _PayBillsPageState extends State<PayBillsPage> {
  final MpesaService _mpesaService = MpesaService();

  // Controllers to handle input for the bill number, account number, and amount
  final TextEditingController billNumberController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  // List of available bill types for the dropdown menu
  final List<String> billTypes = ['DSTV', 'Water', 'Netflix', 'Showmax'];

  // Variable to store the currently selected bill type
  String selectedBillType = 'DSTV';

  // Define a GlobalKey for the Form widget
  final _billsFormKey = GlobalKey<FormState>();

  // Building the widget for PayBillsPage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Bills'), // Title displayed in the AppBar
        backgroundColor: Colors.deepOrange, // Background color of the AppBar
        centerTitle: true, // This centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Form(
          key: _billsFormKey, // Assign the Key to the Form widget
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the column vertically
            children: [
              // Dropdown button for selecting the type of bill
              DropdownButton<String>(
                value: selectedBillType, // Current selected bill type
                onChanged: (String? newValue) {
                  setState(() {
                    // Update selected bill type when a new value is chosen
                    if (newValue != null) {
                      selectedBillType = newValue;

                      // Switch case based on selected bill type
                      switch (selectedBillType) {
                        case 'DSTV':
                          print('DSTV selected');
                          break;
                        case 'Water':
                          print('Water selected');
                          break;
                        case 'Netflix':
                          print('Netflix selected');
                          break;
                        case 'Showmax':
                          print('Showmax selected');
                          break;
                        default:
                          print('Unknown bill type selected');
                      }
                    }
                  });
                },
                items: billTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value, // The value for the dropdown item
                    child: Row(
                      children: [
                        const Icon(Icons.receipt,
                            size: 24), // Placeholder icon for each bill type
                        const SizedBox(width: 8), // Space between icon and text
                        Text(value), // Display the bill type text
                      ],
                    ),
                  );
                }).toList(), // Convert the list of bill types to dropdown items
              ),
              const SizedBox(
                  height: 16.0), // Space between the dropdown and input fields

              // Input field for entering the bill number
              TextFormField(
                controller:
                    billNumberController, // Connects the controller to the input field
                decoration: const InputDecoration(
                  labelText: 'Bill Number', // Label shown in the input field
                  border:
                      OutlineInputBorder(), // Outline border for the input field
                ),

                keyboardType: TextInputType.phone, // Show numeric keyboard for phone number input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipient\'s number'; // Error if the field is empty
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Please enter a valid digit number'; // Ensure valid phone number
                  }
                  return null; // No error if the field is valid
                },
              ),
              const SizedBox(height: 16.0), // Space between input fields

              // Input field for entering the account number
              TextFormField(
                controller:
                    accountNumberController, // Connects the controller to the input field
                decoration: const InputDecoration(
                  labelText: 'Account Number', // Label shown in the input field
                  border:
                      OutlineInputBorder(), // Outline border for the input field
                ),

                keyboardType: TextInputType.phone, // Show numeric keyboard for phone number input
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
              const SizedBox(height: 16.0), // Space between input fields

              // Input field for entering the amount to pay
              TextFormField(
                controller:
                    amountController, // Connects the controller to the input field
                keyboardType:
                    TextInputType.number, // Show numeric keyboard for input
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
                decoration: const InputDecoration(
                  labelText: 'Amount', // Label shown in the input field
                  border:
                      OutlineInputBorder(), // Outline border for the input field
                ),
              ),

              const SizedBox(
                  height: 20.0), // Space between input fields and button

              // Button to trigger the payment action
              ElevatedButton(
                onPressed: () async {
                  // Call validate() on form key, which triggers the validator
                  if (_billsFormKey.currentState?.validate() == true) {
                    // Logic to handle payment would go here
                    final billNumber = billNumberController.text;
                    final accountNumber = accountNumberController.text;
                    final amount = double.parse(amountController.text);

                    // Show a message with the payment details (for demonstration)
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Payment Confirmation'),
                          content: Text(
                            'Paying $amount for $selectedBillType\n'
                            'Bill Number: $billNumber\n'
                            'Account Number: $accountNumber',
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
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepOrange, // Background color of the button
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0), // Padding for the button
                ),
                child: const Text('Send Payment'), // Button label
              ),
            ],
          ),
        ),
      ),
    );
  }
}
