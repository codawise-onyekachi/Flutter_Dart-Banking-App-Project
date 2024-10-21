import 'package:flutter/material.dart';

// Defining the WithdrawPage class
class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  // Controllers to manage the input fields
  final TextEditingController amountController =
      TextEditingController(); // Controller for withdrawal amount input
  final TextEditingController pinController =
      TextEditingController(); // Controller for PIN input
  final TextEditingController agentNumberController =
      TextEditingController(); // Controller for agent number input

  // List of withdrawal options
  final List<String> withdrawalMethods = [
    'ATM',
    'Agent'
  ]; // Available withdrawal methods
  String? selectedMethod; // Variable to store the selected method

  // Form key to manage validation
  final _withdrawFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw'), // Title displayed in the AppBar
        backgroundColor: Colors.deepOrange, // Background color of the AppBar
        centerTitle: true, // This centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form content
        child: Form(
          key: _withdrawFormKey, // Connect form key for validation
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Center the column's content vertically
            children: [
              // Dropdown for selecting the withdrawal method
              DropdownButton<String>(
                hint:
                    const Text('Select Withdrawal Method'), // Placeholder text
                value: selectedMethod, // Current selected method
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMethod = newValue; // Update the selected method
                  });
                },
                items: withdrawalMethods
                    .map<DropdownMenuItem<String>>((String method) {
                  return DropdownMenuItem<String>(
                    value: method, // Value to be set on selection
                    child: Text(method), // Displayed text for each item
                  );
                }).toList(),
              ),
              const SizedBox(
                  height:
                      16.0), // Space between the dropdown and the input fields

              // Input field for withdrawal amount
              TextFormField(
                controller:
                    amountController, // Connects the controller to manage the amount input
                decoration: const InputDecoration(
                  labelText:
                      'Withdrawal Amount', // Label for the amount input field
                  border:
                      OutlineInputBorder(), // Outline border around the input field
                ),
                keyboardType: TextInputType
                    .number, // Numeric keyboard for entering the amount
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
              const SizedBox(height: 16.0), // Space between the input fields

              // Input field for PIN
              TextFormField(
                controller:
                    pinController, // Connects the controller to manage the PIN input
                decoration: const InputDecoration(
                  labelText: 'Enter PIN', // Label for the PIN input field
                  border:
                      OutlineInputBorder(), // Outline border around the input field
                ),
                obscureText: true, // Hides the input text for security
                keyboardType: TextInputType
                    .number, // Numeric keyboard for entering the PIN
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipient\'s number'; // Error if the field is empty
                  }
                  if (!RegExp(r'^\d{4}$').hasMatch(value)) {
                    return 'Please enter a valid 4-digit pin number'; // Ensure valid phone number
                  }
                  return null; // No error if the field is valid
                },
              ),
              const SizedBox(
                  height:
                      16.0), // Space between the PIN input and agent number input

              // Conditional input field for agent number
              if (selectedMethod == 'Agent') ...[
                TextFormField(
                  controller:
                      agentNumberController, // Connects the controller to manage the agent number input
                  decoration: const InputDecoration(
                    labelText:
                        'Agent Number', // Label for the agent number input field
                    border:
                        OutlineInputBorder(), // Outline border around the input field
                  ),
                  keyboardType: TextInputType
                      .phone, // Numeric keyboard for entering the agent number
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
                const SizedBox(height: 16.0), // Space between the input fields
              ],

              // Withdraw button
              ElevatedButton(
                onPressed: () {
                  // Logic to handle the withdrawal action when the button is pressed
                   // Validate the form before performing the send action
                  if (_withdrawFormKey.currentState!.validate()) {
                    String amount = amountController
                        .text; // Get the withdrawal amount from the input field
                    String pin =
                        pinController.text; // Get the PIN from the input field
                    String agentNumber = agentNumberController
                        .text; // Get the agent number from the input field

                    // Add your withdrawal logic here (e.g., API call)
                    // if (selectedMethod == 'Agent') {
                    //   print(
                    //       'Withdrawing $amount from Agent $agentNumber with PIN: $pin'); // Debug output to console
                    // } else {
                    //   print(
                    //       'Withdrawing $amount from ATM with PIN: $pin'); // Debug output for ATM
                    // }

                    // Optionally, you can show a confirmation message or navigate to another page after the operation
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Withdrawal of $amount initiated via $selectedMethod.'),
                    ));

                    var message = "";
                    if (selectedMethod == 'Agent') {
                      // Message for withdrawal via Agent
                      message = 'Withdrawing $amount via Agent\nAgent Number: $agentNumber';
                    } else if (selectedMethod == 'ATM') {
                      // Message for withdrawal via ATM
                      message = 'Withdrawing $amount via ATM';
                    } else {
                      message = 'Invalid withdrawal method selected';
                    }

                    // Show the dialog with the appropriate message
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Withdrawal Confirmation'),
                          content: Text(message),
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
                      vertical: 16.0), // Padding inside the button
                ),
                child: Text('Withdraw'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';

// class WithdrawPage extends StatefulWidget {
//   const WithdrawPage({super.key});

//   @override
//   _WithdrawPageState createState() => _WithdrawPageState();
// }

// class _WithdrawPageState extends State<WithdrawPage> {
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController pinController = TextEditingController();
//   final TextEditingController agentNumberController = TextEditingController();

//   final List<String> withdrawalMethods = ['ATM', 'Agent'];
//   String? selectedMethod;
//   final _withdrawFormKey = GlobalKey<FormState>();

//   // Function to show the withdrawal confirmation dialog
//   void showWithdrawalDialog(BuildContext context, String method, String amount,
//       {String? agentNumber}) {
//     String message;
//     if (method == 'Agent') {
//       message = 'Withdrawing $amount via Agent\nAgent Number: $agentNumber';
//     } else if (method == 'ATM') {
//       message = 'Withdrawing $amount via ATM';
//     } else {
//       message = 'Invalid withdrawal method selected';
//     }

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Withdrawal Confirmation'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Withdraw'),
//         backgroundColor: Colors.deepOrange,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _withdrawFormKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownButton<String>(
//                 hint: const Text('Select Withdrawal Method'),
//                 value: selectedMethod,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedMethod = newValue;
//                   });
//                 },
//                 items: withdrawalMethods
//                     .map<DropdownMenuItem<String>>((String method) {
//                   return DropdownMenuItem<String>(
//                     value: method,
//                     child: Text(method),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: amountController,
//                 decoration: const InputDecoration(
//                   labelText: 'Withdrawal Amount',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an amount';
//                   }
//                   if (double.tryParse(value) == null ||
//                       double.parse(value) <= 0) {
//                     return 'Please enter a valid amount greater than 0';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: pinController,
//                 decoration: const InputDecoration(
//                   labelText: 'Enter PIN',
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the PIN';
//                   }
//                   if (!RegExp(r'^\d{4}$').hasMatch(value)) {
//                     return 'Please enter a valid 4-digit PIN';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               if (selectedMethod == 'Agent') ...[
//                 TextFormField(
//                   controller: agentNumberController,
//                   decoration: const InputDecoration(
//                     labelText: 'Agent Number',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the agent\'s number';
//                     }
//                     if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                       return 'Please enter a valid 10-digit phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//               ],
//               ElevatedButton(
//                 onPressed: () {
//                   if (_withdrawFormKey.currentState!.validate()) {
//                     String amount = amountController.text;
//                     String pin = pinController.text;
//                     String? agentNumber = agentNumberController.text.isNotEmpty
//                         ? agentNumberController.text
//                         : null;

//                     if (selectedMethod == 'Agent') {
//                       showWithdrawalDialog(
//                           context, selectedMethod!, amount,
//                           agentNumber: agentNumber);
//                     } else if (selectedMethod == 'ATM') {
//                       showWithdrawalDialog(context, selectedMethod!, amount);
//                     }
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.deepOrange,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 32.0, vertical: 16.0),
//                 ),
//                 child: const Text('Withdraw'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }