import 'package:drug_alert_frontend/core/utils/extensions/widget_extensions.dart';
import 'package:drug_alert_frontend/features/home/providers/drug_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class CreateNewDrug extends ConsumerStatefulWidget {
  const CreateNewDrug({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateNewDrugState();
}

class _CreateNewDrugState extends ConsumerState<CreateNewDrug> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _batchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final drug = ref.read(drugProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[900],
        ),
      ),
      backgroundColor: Colors.blueGrey[100],
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MediaQuery.of(context).padding.top.spacingH,
                kToolbarHeight.spacingH,
                0.spacingH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Track your care',
                          style: GoogleFonts.kanit(
                            fontSize: 26,
                            color: Colors.grey[900],
                          ),
                        ),
                        10.spacingH,
                        Text(
                          'Add new drug',
                          style: GoogleFonts.kanit(
                            fontSize: 12,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/pills.png',
                      height: 90,
                    ),
                  ],
                ),
                20.spacingH,
                TextFormField(
                  controller: _nameController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter the name of the drug';
                    }
                    return null;
                  },
                  decoration: _inputDecoration('Name of medicine'),
                  style: GoogleFonts.kanit(
                    fontSize: 20,
                    color: Colors.grey[900],
                  ),
                  cursorColor: Colors.grey[900],
                ),
                30.spacingH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateController
                          ..text =
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Choose a date';
                          }

                          return null;
                        },
                        decoration: _inputDecoration('Expiry date'),
                        style: GoogleFonts.kanit(
                          fontSize: 20,
                          color: Colors.grey[900],
                        ),
                        enabled: false,
                        cursorColor: Colors.grey[900],
                      ),
                    ),
                    10.spacingW,
                    Expanded(
                      child: TextFormField(
                        controller: _batchController,
                        decoration: _inputDecoration('Batch number'),
                        style: GoogleFonts.kanit(
                          fontSize: 20,
                          color: Colors.grey[900],
                        ),
                        cursorColor: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
                20.spacingH,
                SizedBox(
                  height: 250,
                  child: ScrollDatePicker(
                    selectedDate: DateTime.now(),
                    maximumDate: DateTime.now().add(
                      const Duration(days: 999999),
                    ),
                    onDateTimeChanged: (DateTime value) {
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(value);
                    },
                  ),
                ),
                50.spacingH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('in');
                          String name = _nameController.text;
                          if (_batchController.text.trim().isNotEmpty) {
                            name += '\$Batch: ${_batchController.text}';
                          }
                          drug.createDrug(
                            context,
                            drugName: name,
                            expiryDate: _dateController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        'Add',
                        style: GoogleFonts.kanit(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.purple[800]!,
          width: 2,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.purple[800]!,
          width: 2,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.purple[800]!,
          width: 2,
        ),
      ),
      hintStyle: GoogleFonts.kanit(
        fontSize: 12,
        color: Colors.grey[900],
      ),
      label: Text(label),
      labelStyle: GoogleFonts.kanit(
        fontSize: 14,
        color: Colors.grey[900],
      ),
    );
  }
}
