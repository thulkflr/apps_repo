import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Cubit/cubit.dart';
import 'package:project_flutter/Cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  get dataBase => null;

  @override
  Widget build(BuildContext context) {
    int counter = 0;

    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>( //listener
        listener: (context, state)
    {
      if (state is ChangeMinusState)
    {
      print ('its MINUS');

    }
      if (state is ChangePlusState)
    {
      print ('its PLUS');

    }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Database Tester'),
              actions: [Icon(Icons.accessible_forward_sharp)],
            ),
            body: Column(
              children: [
                Expanded(
                    child: Column(
                      children: [
                        Text(
                          ' ',
                          style: TextStyle(fontSize: 30),
                        ),
                        FloatingActionButton(
                          child: Icon(Icons.label),
                          onPressed: () {

                            ;
                          },
                        ),
                      ],
                    )),
                Expanded(
                    child: Column(
                      children: [
                        Text(
                          'CounterCubit.get(context).counter',
                          style: TextStyle(fontSize: 30),
                        ),
                        FloatingActionButton(
                          child: Icon(Icons.plus_one),
                          onPressed: () {

                          },
                        ),
                      ],
                    )),
              ],
            ),
          );
        }, // ,
      ),
    );
  }

  void creatDB() async {
    var database = await openDatabase('todo.db', version: 1,
        onCreate: (dataBase, version) {
          print('database created');
//int id
//title string
//date string
//time string
//status string
          dataBase
              .execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)')
              .then((value) {
            print('table created');
          }).catchError((onError) {
            print('error ${onError.toString}');
          });
        }, onOpen: (dataBase) {
          print('database opened');
        });
  }

  void insertTODB() {
    dataBase.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("first Task, "12312", "12334", "very good")')
          .then((value) {
        print('successfully');
      }).catchError((onError) {
        print('not successfully ${onError.toString()}');
      });
    });
  }
}
