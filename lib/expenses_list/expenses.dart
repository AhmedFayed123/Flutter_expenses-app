import 'package:expenses_app/chart/chart.dart';
import 'package:expenses_app/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';

import 'expenses_list.dart';
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  List<Expense> _expenses=[];
  void _addExpense(Expense expense){
    setState(() {
      _expenses.add(expense);
    });
  }
  void _removeExpense(Expense expense){
    setState(() {
      _expenses.remove(expense);
    });
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title:Text('Expenses Tracker App') ,
        actions: [
          IconButton(
              onPressed: (){
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                    context: context,
                    builder: (c) =>NewExpense(onAddExpense: _addExpense,),
                );
              },
              icon: Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: width<=600?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chart(expenses: _expenses),
            Expanded(
              child: ExpensesList(expenses: _expenses, onRemoveExpense: _removeExpense,),
            ),
          ],
        ):Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Chart(expenses: _expenses)),
            Expanded(
              child: ExpensesList(expenses: _expenses, onRemoveExpense: _removeExpense,),
            ),
          ],
        ),
      ),
    );
  }
}

