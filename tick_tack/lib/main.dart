import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF00FFFF), // Neon Cyan
          onPrimary: Color(0xFFFFFFFF), // White
          secondary: Color(0xFFFF00FF), // Neon Magenta
          onSecondary: Color(0xFFFFFFFF), // White
          background: Color(0xFF000000), // Black
          onBackground: Color(0xFFFFFFFF), // White
          surface: Color(0xFF121212), // Dark Surface
          onSurface: Color(0xFFFFFFFF), // White
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFFFFFFFF), // White
            fontSize: 32.0,
            fontFamily: 'Creepster', // Optional spooky font
          ),
          headlineMedium: TextStyle(
            color: Color(0xFFFFFFFF), // White
            fontSize: 24.0,
            fontFamily: 'Creepster', // Optional spooky font
          ),
          bodyLarge: TextStyle(
            color: Color(0xFFBDBDBD), // Grey
            fontSize: 20.0,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFFBDBDBD), // Grey
            fontSize: 18.0,
          ),
        ),
      ),
      home: const TickPage(),
    );
  }
}

class TickPage extends StatefulWidget {
  const TickPage({super.key});

  @override
  State<TickPage> createState() => _TickPageState();
}

class _TickPageState extends State<TickPage> {
  int col = 3;
  int row = 3;
  bool isPlayer1 = true;
  var array = List<List<String>>.generate(
      3, (i) => List<String>.generate(3, (j) => ''));
  var colors = List<List<Color>>.generate(
      3, (i) => List<Color>.generate(3, (j) => Colors.transparent));

  void playerClick(int i, int j) {
    if (array[i][j] == '' && _checkWinner() == null) {
      setState(() {
        if (isPlayer1) {
          array[i][j] = 'X';
          colors[i][j] = Color(0xFF00FFFF); // Neon Cyan for Player 1
          isPlayer1 = false;
        } else {
          array[i][j] = 'O';
          colors[i][j] = Color(0xFFFF00FF); // Neon Magenta for Player 2
          isPlayer1 = true;
        }
        _checkWinner();
      });
    }
  }

  String? _checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (array[i][0] == array[i][1] &&
          array[i][1] == array[i][2] &&
          array[i][0] != '') {
        _showWinnerDialog(array[i][0]);
        return array[i][0];
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (array[0][i] == array[1][i] &&
          array[1][i] == array[2][i] &&
          array[0][i] != '') {
        _showWinnerDialog(array[0][i]);
        return array[0][i];
      }
    }
    // Check diagonals
    if (array[0][0] == array[1][1] &&
        array[1][1] == array[2][2] &&
        array[0][0] != '') {
      _showWinnerDialog(array[0][0]);
      return array[0][0];
    }
    if (array[0][2] == array[1][1] &&
        array[1][1] == array[2][0] &&
        array[0][2] != '') {
      _showWinnerDialog(array[0][2]);
      return array[0][2];
    }
    // Check for draw
    if (array.every((row) => row.every((cell) => cell != ''))) {
      _showWinnerDialog('Draw');
      return 'Draw';
    }
    return null;
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(winner == 'Draw' ? 'It\'s a Draw!' : 'Winner!'),
          content: Text(winner == 'Draw'
              ? 'The game ended in a draw.'
              : 'Player ${winner == 'X' ? '1' : '2'} has won!'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  array = List<List<String>>.generate(
                      3, (i) => List<String>.generate(3, (j) => ''));
                  colors = List<List<Color>>.generate(
                      3, (i) => List<Color>.generate(3, (j) => Colors.transparent));
                  isPlayer1 = true;
                  Navigator.of(context).pop();
                });
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  Widget tableCell(int i, int j) {
    return TableCell(
      child: GestureDetector(
        onTap: () {
          playerClick(i, j);
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border:
                Border.all(color: Color(0xFF00FFFF), width: 4.0), // Neon Cyan
          ),
          child: Center(
            child: Text(
              array[i][j],
              style: TextStyle(
                color: colors[i][j], // Use the color from the array
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: colors[i][j], // Neon effect based on player
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Tic Tac Toe',
            style: TextStyle(
              fontSize: 32.0,
              color: Color(0xFF00FFFF), // Neon Cyan
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Color(0xFF00FFFF), // Neon Cyan
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF2A2A2A)
            ], // Black to Dark Grey
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isPlayer1
                    ? AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(
                            'Player 1: ',
                            speed: Duration(milliseconds: 800),
                            textStyle: TextStyle(
                              color: Color(0xFFBDBDBD), // Grey
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Player 1: ',
                        style: TextStyle(
                          color: Color(0xFFBDBDBD), // Grey
                          fontSize: 20.0,
                        ),
                      ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close,
                        color: Color(0xFF00FFFF), size: 20.0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !isPlayer1
                    ? AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(
                            'Player 2: ',
                            speed: Duration(milliseconds: 800),
                            textStyle: TextStyle(
                              color: Color(0xFFBDBDBD), // Grey
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Player 2: ',
                        style: TextStyle(
                          color: Color(0xFFBDBDBD), // Grey
                          fontSize: 20.0,
                        ),
                      ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.radio_button_unchecked,
                        color: Color(0xFFFF00FF), size: 20.0)),
              ],
            ),
            Text(
              'Are you ready to play?',
              style: TextStyle(
                color: Color(0xFFFFFFFF), // White
                fontSize: 20.0,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Color(0xFF00FFFF), // Neon Cyan
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
              child: Table(
                border: TableBorder(
                  horizontalInside: BorderSide(
                    width: 4.0,
                    color: Color(0xFF00FFFF), // Neon Cyan
                  ),
                  verticalInside: BorderSide(
                    width: 4.0,
                    color: Color(0xFF00FFFF), // Neon Cyan
                  ),
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      tableCell(0, 0),
                      tableCell(0, 1),
                      tableCell(0, 2),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      tableCell(1, 0),
                      tableCell(1, 1),
                      tableCell(1, 2),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      tableCell(2, 0),
                      tableCell(2, 1),
                      tableCell(2, 2),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  array = List<List<String>>.generate(
                      3, (i) => List<String>.generate(3, (j) => ''));
                  colors = List<List<Color>>.generate(
                      3, (i) => List<Color>.generate(3, (j) => Colors.transparent));
                  isPlayer1 = true;
                });
              },
              icon: Icon(Icons.refresh, color: Color(0xFF00FFFF), size: 40.0),
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)))),
            ),
          ],
        ),
      ),
    );
  }
}
