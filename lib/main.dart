import 'package:bloc_example/bloc/remote_bloc/remote_bloc.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloC Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = RemoteBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<RemoteState>(
          stream: bloc.stateController.stream,
          initialData: bloc.state,
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            return Text('Âm lượng hiện tại: ${snapshot.data?.volume}');
          },
        )
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(onPressed: () {
            bloc.eventController.sink.add(IncrementEvent(5));
          },
          child: const Icon(Icons.volume_up)),
           FloatingActionButton(onPressed: () {
            bloc.eventController.sink.add(DecrementEvent(5));
            
          },
          child: const Icon(Icons.volume_down)
          ),
           FloatingActionButton(onPressed: () {
            bloc.eventController.sink.add(MuteEvent());
            },
            child: const Icon(Icons.volume_mute),
            )
        ],
      ),
    );
  }
}