import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/responsive.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveSpacing.horizontal(context);
    final verticalPadding = ResponsiveSpacing.vertical(context);
    final fontSize = ResponsiveFontSizes.body(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding * 0.5,
          vertical: verticalPadding * 0.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: ResponsiveFontSizes.title(context),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: ResponsiveSpacing.extraSmall(context)),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: fontSize),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category], size: fontSize + 4),
                    SizedBox(width: ResponsiveSpacing.small(context)),
                    Text(
                      expense.formattedDate,
                      style: TextStyle(fontSize: fontSize - 1),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
