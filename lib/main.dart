import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  int counter = 0;

  App({super.key});

  void onClicked() {
    counter = counter + 1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Color(0xFF232B55),
            ),
          ),
          cardColor: Colors.white,
          colorScheme: const ColorScheme(
            surface: Colors.white,
            onSurface: Colors.white,
            onBackground: Color(0xFFE64D3D),
            error: Colors.black,
            onError: Colors.black,
            onPrimary: Color(0xFFE64D3D),
            onSecondary: Color(0xFF232B55),
            primary: Color(0xFF232B55),
            secondary: Color(0xFFE64D3D),
            brightness: Brightness.light,
            background: Color(0xFFE64D3D),
          ),
        ),
        home: const HomeScreen());
  }
}

final List<int> timerHour = [15, 20, 25, 30, 35];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 2;
  late int twentyFiveMinite;
  int totalSeconds = 0;
  int cycleMinites = 0;
  int cycleSeconds = 0;

  late Timer timer;

  bool isRunning = false;

  int totalPomodoros = 0;
  int goal = 0;

  _HomeScreenState() {
    twentyFiveMinite = timerHour[selectedIndex] * 60;
    totalSeconds = twentyFiveMinite;
    cycleMinites = totalSeconds ~/ 60;
    cycleSeconds = totalSeconds % 60;
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        if (totalPomodoros % 4 == 0) {
          goal = goal + 1;
          totalPomodoros = 0;
          twentyFiveMinite = 5 * 60;
          onStartPressed();
        }
        isRunning = false;
        totalSeconds = twentyFiveMinite;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
        cycleMinites = totalSeconds ~/ 60;
        cycleSeconds = totalSeconds % 60;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    setState(() {
      isRunning = false;
      totalSeconds = twentyFiveMinite;
    });
    timer.cancel();
  }

  String format(int totalSeconds) {
    var duration = Duration(seconds: totalSeconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "POMOTIMER",
              style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 130,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Text(
                  cycleMinites.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 80,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  " : ",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 60,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: 140,
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Text(
                  cycleSeconds.toString().padLeft(2, '0'),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 80,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              height: 65,
              child: Stack(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: timerHour.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            twentyFiveMinite = timerHour[selectedIndex] * 60;
                            onResetPressed();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 65,
                            height: 55,
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.5)),
                            ),

                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                timerHour[index].toString(),
                                style: TextStyle(
                                    color: selectedIndex == index
                                        ? Theme.of(context)
                                            .colorScheme
                                            .background
                                        : Colors.white.withOpacity(
                                            0.5), //Theme.of(context).colorScheme.background,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ), //here you can show the child or data from the list
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(1.0),
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(1.0),
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 55,
          ),
          Flexible(
            flex: 3,
            child: IconButton(
              iconSize: 120,
              onPressed: isRunning ? onPausePressed : onStartPressed,
              icon: Icon(isRunning ? Icons.pause_circle : Icons.play_circle),
              color: Theme.of(context).cardColor,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '$totalPomodoros/4',
                    style: TextStyle(
                        color: Colors.white.withOpacity(
                            0.5), //Theme.of(context).colorScheme.background,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "ROUND",
                    style: TextStyle(
                        color: Colors
                            .white, //Theme.of(context).colorScheme.background,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '$goal/12',
                    style: TextStyle(
                        color: Colors.white.withOpacity(
                            0.5), //Theme.of(context).colorScheme.background,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "GOAL",
                    style: TextStyle(
                        color: Colors
                            .white, //Theme.of(context).colorScheme.background,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
