import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/responsive.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveBreakpoints.getDeviceType(context);
    final horizontalPadding = ResponsiveSpacing.horizontal(context);
    final verticalPadding = ResponsiveSpacing.vertical(context);

    // Use multi-column layout on tablets
    final isTablet =
        deviceType == DeviceType.tablet ||
        MediaQuery.of(context).size.width > 600;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    // Responsive vertical padding considering keyboard
    final topPadding = verticalPadding * 3;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          topPadding,
          horizontalPadding,
          verticalPadding + keyboardHeight,
        ),
        child: Column(
          children: [
            // Title field - full width
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: InputDecoration(
                label: Text(
                  'Title',
                  style: TextStyle(fontSize: ResponsiveFontSizes.body(context)),
                ),
                border: const OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: ResponsiveFontSizes.body(context)),
            ),
            SizedBox(height: verticalPadding),

            // Amount and Date - side by side on tablet, stacked on mobile
            if (isTablet)
              Row(
                children: [
                  // Amount field
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '\$ ',
                        label: Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: ResponsiveFontSizes.body(context),
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: ResponsiveFontSizes.body(context),
                      ),
                    ),
                  ),
                  SizedBox(width: horizontalPadding),
                  // Date selector
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: ResponsiveFontSizes.small(context),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(
                                height: ResponsiveSpacing.extraSmall(context),
                              ),
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!),
                                style: TextStyle(
                                  fontSize: ResponsiveFontSizes.body(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: Icon(
                            Icons.calendar_month,
                            size: ResponsiveFontSizes.body(context) + 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else
              // Mobile layout - stacked
              Column(
                children: [
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: '\$ ',
                      label: Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: ResponsiveFontSizes.body(context),
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: ResponsiveFontSizes.body(context),
                    ),
                  ),
                  SizedBox(height: verticalPadding),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!),
                          style: TextStyle(
                            fontSize: ResponsiveFontSizes.body(context),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: Icon(
                          Icons.calendar_month,
                          size: ResponsiveFontSizes.body(context) + 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            SizedBox(height: verticalPadding),

            // Category dropdown - full width
            Row(
              children: [
                Expanded(
                  child: DropdownButton<Category>(
                    isExpanded: true,
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: ResponsiveFontSizes.body(context),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: verticalPadding * 1.5),

            // Buttons - responsive layout
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: ResponsiveFontSizes.body(context),
                    ),
                  ),
                ),
                SizedBox(width: horizontalPadding),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: Text(
                    'Save Expense',
                    style: TextStyle(
                      fontSize: ResponsiveFontSizes.body(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
