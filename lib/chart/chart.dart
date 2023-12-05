import 'package:expenses_app/chart/chart_bar.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;
  List<ExpenseBucket> get buckets{
    return[
      ExpenseBucket.forCategory(Category.work, expenses),
      ExpenseBucket.forCategory(Category.leisure, expenses),
      ExpenseBucket.forCategory(Category.travel, expenses),
      ExpenseBucket.forCategory(Category.food, expenses),
    ];
  }
  double get maxTotalExpense{
    double maxTotalExpense=0;

    for(var element in buckets){
      if(element.totalExpense>maxTotalExpense){
        maxTotalExpense=element.totalExpense;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
      width: double.infinity,
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(.3),
            Theme.of(context).colorScheme.primary.withOpacity(.0),
          ],
            begin: Alignment.bottomCenter,
            end:Alignment.topCenter
        )
      ),
      child: Column(
        children: [
          Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for(final element in buckets) ChartBar(fill: element.totalExpense==0?0:element.totalExpense/maxTotalExpense,),
                ],
              )
          ),
          SizedBox(height: 12,),
          Row(
            children: buckets.map((e) =>
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(categoryIcon[e.category]),
                    ),
                )).toList(),
          )
        ],
      ),
    );
  }
}
