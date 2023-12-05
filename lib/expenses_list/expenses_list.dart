import 'package:expenses_app/expenses_list/expenses_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses, required this.onRemoveExpense,
  }) ;

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context,index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(color: Theme.of(context).colorScheme.error,margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),),
        onDismissed: (direction) =>onRemoveExpense(expenses[index]),
        child: ExpensesItem(
            expense: expenses[index],
        ),
      ),
    );
  }
}