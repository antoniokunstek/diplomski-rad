import 'package:core/pages/user/wallets/accounts_page.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_bloc.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_event.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_bloc.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_events.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_state.dart';
import 'package:diplomski_rad_transactions_module/model/transaction.dart';
import 'package:diplomski_rad_transactions_module/model/transaction_form.dart';
import 'package:diplomski_rad_transactions_module/utils/category_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';
import '../../utils/shared_preferences_utils.dart';

class TransactionForm extends StatefulWidget {
  final String accountId;
  final String? jwtToken;

  TransactionForm({
    required this.accountId,
    required this.jwtToken
  });

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  int? _transactionType;
  List<Category> incomeList = Category.getIncomeCategoryList();
  List<Category> expenseList = Category.getExpenseCategoryList();
  Category? _selectedItem;

  TransactionFormModel _formModel = TransactionFormModel(transactionLabel: '',
      amount: 0,
      note: '',
      categoryId: 0,
      accountId: '',
      transactionType: 1);

  void _addTransaction(BuildContext context) async {
    BlocProvider.of<AccountsBloc>(context).add(
        OnWidgetInit(authJwtToken: await LocalStorage.getUserFromLocalStorage()));
    BlocProvider.of<TransactionBloc>(context).add(
       AddTransaction(authJwtToken: await LocalStorage.getUserFromLocalStorage(), model: _formModel));
    BlocProvider.of<AccountsBloc>(context).add(
        OnWidgetInit(authJwtToken: await LocalStorage.getUserFromLocalStorage()));
  }

  @override
  void initState() {
    super.initState();
    _transactionType = 1;
    _selectedItem = expenseList.first;
    _formModel.accountId = widget.accountId;
    _formModel.categoryId = expenseList.first.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add transaction")),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if(state is TransactionCreated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => (const WalletPage())));
          } else if (state is TransactionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Greška prilikom kreiranja transakcije"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a transaction label';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formModel.transactionLabel = value!;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Amount'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formModel.amount = num.parse(value!);
                        },
                      ),
                      DropdownButtonFormField<int>(
                          value: _transactionType,
                          onChanged: (int? newValue) {
                            setState(() {
                              _transactionType = newValue;
                              newValue == 1 ? _selectedItem = expenseList.first :
                              _selectedItem = incomeList.first;
                              _formModel.transactionType = newValue!;
                            });
                          },
                          items: const [DropdownMenuItem<int>(
                              value: 1,
                              child: Text('EXPENSES')),
                            DropdownMenuItem<int>(
                                value: 2,
                                child: Text('INCOMES'))],
                          decoration: const InputDecoration(labelText: 'Select an option'),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select an option';
                            }
                            return null;
                          }),

                      DropdownButtonFormField<Category>(
                          value: _selectedItem,
                          onChanged: (value) {
                            _formModel.categoryId = value!.categoryId;                          },
                          items: _transactionType == 1 ?
                          expenseList.map((Category category) {
                            return DropdownMenuItem<Category>(
                              value: category,
                              child: Text(category.categoryName),
                            );
                          }).toList() :
                          _transactionType == 2 ?
                          incomeList.map((Category category) {
                            return DropdownMenuItem<Category>(
                              value: category,
                              child: Text(category.categoryName),
                            );
                          }).toList() :
                          [],
                          decoration: const InputDecoration(labelText: 'Select an option'),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select an option';
                            }
                            return null;
                          }),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Note'),
                        onSaved: (value) {
                          _formModel.note = value!;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _addTransaction(context);
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

