import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
const uuid=Uuid();
final dateFormat = DateFormat.yMd();
enum Category {
  food,
  travel,
  leisure,
  work
}
const categoryIcon ={
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};
class Expense{
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String formattedDate(){
    return dateFormat.format(date);
  }

  Expense({
    required this.category,
    required this.title,
    required this.amount,
    required this.date
  }):id = uuid.v4();
}
class ExpenseBucket{
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket(this.category, this.expenses);
  ExpenseBucket.forCategory(this.category, List<Expense> allExpenses):expenses=allExpenses
  .where((element) => element.category==category).toList();

  double get totalExpense{
    double sum=0;
    for(var expense in expenses){
      sum = sum +expense.amount;
    }
    return sum;
  }

}