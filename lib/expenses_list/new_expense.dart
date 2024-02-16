import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final formatter = DateFormat().add_yMd();
  Category _selectedCategory = Category.travel ;

  @override
  void dispose(){
    super.dispose();
    _titleController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    label: Text(
                        'Title'
                    )
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      maxLength: 50,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text(
                            'Amount'
                        ),
                        prefixText: '\$',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate==null ?'No Date Selected':formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: ()async{
                          final now =DateTime.now();
                          final firstDate = DateTime(now.year-1, now.month, now.day);
                           final DateTime? pickerDate=await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: firstDate,
                              lastDate: now,
                          );
                           setState(() {
                             _selectedDate=pickerDate;
                           });
                        },
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                      items: Category.values.map((e) =>
                          DropdownMenuItem(
                            value: e,
                              child: Text(
                                  e.name,
                              )))
                          .toList(),
                      onChanged: (newCat){
                        setState(() {
                          if(newCat==null){
                            return;
                          }
                          _selectedCategory=newCat;
                        });
                      },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: (){Navigator.pop(context);},
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        final double? enteredAmount =double.tryParse(_amountController.text);
                        final bool amountIsInvalid = enteredAmount == null || enteredAmount <=0;
                        if(_titleController.text.trim().isEmpty||amountIsInvalid||_selectedDate==null){
                          showDialog(context: context, builder: (ctx)=>AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Invalid Inputs'),
                            actions: [
                              TextButton(onPressed: (){Navigator.pop(ctx);}, child: const Text('ok'))
                            ],
                          ));
                        }
                        else{
                          widget.onAddExpense(
                              Expense(
                                  category: _selectedCategory,
                                  title: _titleController.text,
                                  amount: enteredAmount!,
                                  date: _selectedDate!,
                              ),
                          );
                          Navigator.pop(context);
                        }

                      },
                      child: const Text('Saved Expense'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
