import 'package:bitrise_demo_1/services/api_service.dart';
import 'package:bitrise_demo_1/ui/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<MainViewModel>(MainViewModel());
}

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitrise Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bitrise'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final viewModel = getIt<MainViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) => Center(
            child: ListView.builder(
              itemCount: viewModel.persons.length,
                itemBuilder: (context, index) => ListTile(
                    title: Text(viewModel.persons[index].name),
                    subtitle:
                        Text(viewModel.persons[index].language ?? "Unknown")))),
      ),
    );
  }
}

// 1. Parse the json into models
// 2. Display each person in a list
// 3. Display each persons favorite language, or "Unknown" if not given.
