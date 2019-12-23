import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  List<charts.Series<Task, String>> _seriesPieData;
  _generateData(){
    var pieData = [
      new Task(task: 'Tam', taskvalue: 25, colorval: Colors.green),
      new Task(task: 'Spencer', taskvalue: 25, colorval: Colors.blue),
      new Task(task: 'Harry', taskvalue: 25, colorval: Colors.red),
      new Task(task: 'Jeremy', taskvalue: 25, colorval: Colors.purple),
    ];

    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task,_)=> task.task,
        measureFn: (Task task,_)=> task.taskvalue,
        id: "Work Spilted on App",
        labelAccessorFn: (Task row,_)=>'${row.taskvalue}',
      )
    ); 
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            bottom: TabBar(
              tabs: [Tab(icon: Icon(FontAwesomeIcons.chartPie))],
            ),
            title: Text('Chat Anayltics'),
          ),
          body: TabBarView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text('Time spent on the project', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.0,),
                        Expanded(
                          child: charts.PieChart(
                            _seriesPieData,
                            animate: true,
                            animationDuration: Duration(seconds: 3),
                            behaviors: [
                              new charts.DatumLegend(
                                outsideJustification: charts.OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                desiredMaxRows: 2,
                                cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                                entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.green.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 12
                                ),
                              )
                            ],
                            defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.inside)
                              ]
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:(){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }
}


class Task{
  String task;
  double taskvalue;
  MaterialColor colorval;

  Task({this.task, this.taskvalue, this.colorval});
}