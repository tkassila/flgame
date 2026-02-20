/*
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
*/
import 'dart:async';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  const BorderedContainer({super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
        color: color,
      ),
      child: child,
    );
  }
}

final TextStyle textStyle = TextStyle(fontSize: ScreenUtil().setSp(20),
    color: Colors.orangeAccent, backgroundColor: Colors.black);

const TextStyle textStyleHtml = TextStyle(fontSize: 16,
    color: Colors.black,
fontWeight: FontWeight.bold
/* Colors.grey */);

var htmlStyle = {
  "table": Style(
    backgroundColor: Colors.white /* const Color.fromARGB(0x50, 0xee, 0xee, 0xee) */,
  ),
  "tr": Style(
    border: const Border(bottom: BorderSide(color: Colors.white)),
  ),
  "th": Style(
    padding: HtmlPaddings.all(6),
    backgroundColor: Colors.white,
  ),
  "td": Style(
    padding: HtmlPaddings.all(6),
    alignment: Alignment.topLeft,
    backgroundColor: Colors.white,
  ),
  "div": Style(
    backgroundColor: Colors.white,
    padding: HtmlPaddings.all(10),
  ),
  "p": Style(
    padding: HtmlPaddings.all(6),
    backgroundColor: Colors.white,
    color: Colors.black,
    fontSize: FontSize.large,
    alignment: Alignment.center,
      fontWeight: FontWeight.bold
  ),
  'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
};

/*
<div class="container">
    <div class="image">
        <img alt="L game board and starting setup, with neutral pieces shown as black discs"
             aria-hidden="true"
             height="150" src="assets/L_Game_start_position.svg.png" text width="150">
    </div>
    <div class="">
        <h3>L game board and starting setup, with neutral pieces shown as black discs</h3>
    </div>
</div>

 */

const String strHelp = r"""

<div class="text">
    <h2>L game - tablet and phone game
    </h2>
    <p>You can use main menu to select next options in the game:</p>
    <p>This game can store un/finished game sessions with current game situation. Select that 
        option to see a list of store sessions and game boards. You can also remove old game 
        sessions to press garbage picture on the row. You can select some unfinished game 
        to continue the game where players left the selected game.</p>
    
    <h3>After started new L game</h3>
    
    <p>L piece for Player 1 has marked with white numbers 1 and the same for Player 2 has been
    marked with white numbers 2. 2 neutral pieces has been marked with white numbers 0. And in turn player's 
    L move black frame is marked with black 1 or 2 numbers on each move frame square.
    </p>    

    <h2>From Wikipedia</h2>
    <p>From Wikipedia, the free encyclopedia
        L game board and starting setup, with neutral pieces shown as black discs:
    </p>
  </div>  
    """;

const String strHelp_2 = r"""

<div>
    <p>
        The L game is a simple abstract strategy board game invented by Edward de Bono. It was introduced in his book The Five-Day Course in Thinking (1967).
    </p>
    <h3>Description</h3>
    <p>
        The L game is a two-player game played on a board of 4×4 squares. Each player has a 3×2 L-shaped tetromino, and there are two 1×1 neutral pieces.
    </p>
        
   <h3>Rules</h3>

    <p>
        On each turn, a player must first move their L piece, and then may optionally move either one of the neutral pieces. The game is won by leaving the opponent unable to move their L piece to a new position.
    </p>
    </div>
    """;


const String strHelp2 = r"""
<div class="text">
    <p>
        Pieces may not overlap or cover other pieces, or let the pieces off the board. On moving the L piece, it is picked up and then placed in empty squares anywhere on the board. It may be rotated or even flipped over in doing so; the only rule is that it must end in a different position from the position it started—thus covering at least one square it did not previously cover. To move a neutral piece, a player simply picks it up then places it in an empty square anywhere on the board.
    </p>

    <h1>Strategy</h1>

    <p>
        One basic strategy is to use a neutral piece and one's own piece to block a 3×3 square in one corner, and use a neutral piece to prevent the opponent's L piece from swapping to a mirror-image position. Another basic strategy is to move an L piece to block a half of the board, and use the neutral pieces to prevent the opponent's possible alternate positions.
    </p>

    <p>
        These positions can often be achieved once a neutral piece is left in one of the eight killer spaces on the perimeter of the board. The killer spaces are the spaces on the perimeter, but not in a corner. On the next move, one either makes the previously placed killer a part of one's square, or uses it to block a perimeter position, and makes a square or half-board block with one's own L and a moved neutral piece.
    </p>

    <h1>Analysis</h1>

    <p>
        All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing.
        All possible final positions, Blue has won
    </p>
    </div>
""";

const String strHelp3 = r"""
<div class="text">
      <p>
        In a game with two perfect players, neither will ever win or lose. The L game is small enough to be completely solvable. There are 2296 different possible valid ways the pieces can be arranged, not counting a rotation or mirror of an arrangement as a new arrangement, and considering the two neutral pieces to be identical. Any arrangement can be reached during the game, with it being any player's turn. Each player has lost in 15 of these arrangements, if it is that player's turn. The losing arrangements involve the losing player's L piece touching a corner. Each player will also soon lose to a perfect player in an additional 14 arrangements. A player will be able to at least force a draw (by playing forever without losing) from the remaining 2267 positions.
    </p>

    <p>
        Even if neither player plays perfectly, defensive play can continue indefinitely if the players are too cautious to move a neutral piece to the killer positions. If both players are at this level, a sudden-death variant of the rules permits one to move both neutral pieces after moving. A player who can look three moves ahead can defeat defensive play using the standard rules.[clarification needed]
    </p>

    <h1>References</h1>

    <p>
        "Games and Puzzles 1974-11: Iss 30". A H C Publications. November 1974.
    </p>

    <h1>Other sources</h1>

    <p>
        de Bono, Edward (1967). "The L Game: Strategic Thinking". The Five-Day Course in Thinking. Basic Books Inc. pp. 149–206. LCCN 67027438.

    <p>
        Parlett, David (1999). "The L-Game". The Oxford History of Board Games. Oxford University Press Inc. pp. 161–62. ISBN 0-19-212998-8.

    <p>Pritchard, D. B. (1982). "The L Game". Brain Games. Penguin Books Ltd. pp. 107–12. ISBN 0-14-00-5682-3.
    </p>

    <h1>External links</h1>

    <p>L game on Edward de Bono's official site (archived)
    <p>Interactive web-based L game written in JavaScript
    </p>

    <h1>Categories:</h1>

    <p>
        Board games introduced in 1968Abstract strategy gamesMathematical gamesSolved games
    </p>
</div>
""";

class HelpPage1 extends StatelessWidget {
  const HelpPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(children: [
      Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 4.0),
      child: Text('Swipe from left into right and back between help pages. Or when needed from up into down.', style: textStyle,),
      ),
      SingleChildScrollView(
        controller: ScrollController(),
        primary: false,
        child: Container(color: Colors.white, child: Column( spacing: 0.0, children: [
          Html(style: htmlStyle, data: strHelp),
          const Image(
            width: 150,
            height: 150,
            image: AssetImage(
              'assets/L_Game_start_position.svg.png',
            ),
          ),
          Html(style: htmlStyle, data: strHelp_2),
        ],
        ),
        ),
      ),
    ],),
    )
    ;
  }
}

class HelpPage2 extends StatelessWidget {
  const HelpPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      primary: false,
      child: Html(style: htmlStyle, data: strHelp2),
    );
  }
}

class HelpPage3 extends StatelessWidget {
  const HelpPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      controller: ScrollController(),
      primary: false,
      child: Html(style: htmlStyle, data: strHelp3),
    );
  }
}

class HelpPage4 extends StatelessWidget {
  const HelpPage4({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(child: Container(
    color: Colors.white, child:
    Column(
        spacing: 0.0,
        children:  [
             const Padding(
               padding: EdgeInsets.only(top: 17.0, left: 17.0, right: 17.0, ),
               child: Image(
              width: 150,
              height: 150,
            image: AssetImage(
            'assets/L_Game_start_position.svg.png',
        ),),
        ),
          Text("Start position of L game", style: textStyleHtml,),
          const SizedBox(height: 20.0,),
         Image(
             width: width -30.0,
            image: const AssetImage(
              'assets/560px-L_Game_mate_positions.svg.png',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30.0, left: 17.0, right: 17.0, bottom: 20.0),
            child: Text("All positions, Red to move, where Red will lose " "to a perfect Blue, and maximum number of moves remaining " "for Red. By looking ahead one move and ensuring " "one never ends up in any of the above positions,"
                              " one can avoid losing.", style: textStyleHtml,),
                ),

       Image(
        width: width -30.0,
            image: AssetImage(
              'assets/560px-L_Game_all_final_positions.svg.png',
            ),
          ),
          const Text("All possible final positions, Blue has won",
            style: textStyleHtml,),
              /*
              Image(
                width: 250,
                height: 250,
                image: AssetImage(
                  'assets/560px-L_Game_mate_positions.svg.png',
                ),),
              Text("All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing."),
              Image(
                width: 250,
                height: 250,
                image: AssetImage(
                  'assets/560px-L_Game_all_final_positions.svg.png',
                ),),
              Text("All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing."),
               */
              const SizedBox(height: 20.0,)
            ],
    ),
    ),
    );
  }
}

class HelpRoute extends StatefulWidget {
  const HelpRoute({super.key});

  @override
  State<HelpRoute> createState() => _HtmlViewExampleState();
}

class _HtmlViewExampleState extends State<HelpRoute> {

  Future<Null> _fetchPartner() async {
    print('Please Wait');
  }

  /*
    <html>
<head>
    <title>L game help</title>
</head>
<body>
<h1>L game</h1>
   */


  /*
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LGame help'),
        centerTitle: true,
      ),
      body: /* SingleChildScrollView(
      controller: ScrollController(),
        child:  HtmlWidget(strHelp +strHelp2 +strHelp3),
      ), */
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                Text(Iterable.generate(100, (i) => "Hello Flutter $i").join('\n')),
              ],
    ),
          ),

      ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text(Iterable.generate(100, (i) => "Hello Flutter $i").join('\n')),
          ]
      ),
       */
      /*
      Center(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(), // new
          controller: _controller,
        children: <Widget>[
        Row(children: [
          Text(Iterable.generate(100, (i) => "Hello Flutter $i").join('\n'))
      ]),

    );
  }
}
*/


/*
class HelpRoute extends StatelessWidget {
 // final NavigatorState parentNavigator;
  const HelpRoute({super.key /*, required this.parentNavigator, */});

  Future<String> loadHelpAsset()
  async {
    return await rootBundle.loadString('assets/help.html');
  }
 */

  final String strHelp0 = r"""
  <html>
<head>
    <title>L game help</title>
</head>
<body>
<h1>L game</h1>

<div class="container">
    <div class="image">
        <!--
        <img alt="L game board and starting setup, with neutral pieces shown as black discs"
             aria-hidden="true"
             height="150" src="L_Game_start_position.svg.png" text width="150>
        -->
    </div>
    <div class="">
        <h3>L game board and starting setup, with neutral pieces shown as black discs</h3>
    </div>
</div>


<div class="text">
    <p>From Wikipedia, the free encyclopedia
        L game board and starting setup, with neutral pieces shown as black discs
    </p>

    <p>
        The L game is a simple abstract strategy board game invented by Edward de Bono. It was introduced in his book The Five-Day Course in Thinking (1967).
        Description
    </p>

    <p>
        The L game is a two-player game played on a board of 4×4 squares. Each player has a 3×2 L-shaped tetromino, and there are two 1×1 neutral pieces.
        Rules
    </p>

    <p>
        On each turn, a player must first move their L piece, and then may optionally move either one of the neutral pieces. The game is won by leaving the opponent unable to move their L piece to a new position.
    </p>

    <p>
        Pieces may not overlap or cover other pieces, or let the pieces off the board. On moving the L piece, it is picked up and then placed in empty squares anywhere on the board. It may be rotated or even flipped over in doing so; the only rule is that it must end in a different position from the position it started—thus covering at least one square it did not previously cover. To move a neutral piece, a player simply picks it up then places it in an empty square anywhere on the board.
    </p>

    <h1>Strategy</h1>

    <p>
        One basic strategy is to use a neutral piece and one's own piece to block a 3×3 square in one corner, and use a neutral piece to prevent the opponent's L piece from swapping to a mirror-image position. Another basic strategy is to move an L piece to block a half of the board, and use the neutral pieces to prevent the opponent's possible alternate positions.
    </p>

    <p>
        These positions can often be achieved once a neutral piece is left in one of the eight killer spaces on the perimeter of the board. The killer spaces are the spaces on the perimeter, but not in a corner. On the next move, one either makes the previously placed killer a part of one's square, or uses it to block a perimeter position, and makes a square or half-board block with one's own L and a moved neutral piece.
    </p>

    <h1>Analysis</h1>

    <p>
        All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing.
        All possible final positions, Blue has won
    </p>

    <p>
        In a game with two perfect players, neither will ever win or lose. The L game is small enough to be completely solvable. There are 2296 different possible valid ways the pieces can be arranged, not counting a rotation or mirror of an arrangement as a new arrangement, and considering the two neutral pieces to be identical. Any arrangement can be reached during the game, with it being any player's turn. Each player has lost in 15 of these arrangements, if it is that player's turn. The losing arrangements involve the losing player's L piece touching a corner. Each player will also soon lose to a perfect player in an additional 14 arrangements. A player will be able to at least force a draw (by playing forever without losing) from the remaining 2267 positions.
    </p>

    <p>
        Even if neither player plays perfectly, defensive play can continue indefinitely if the players are too cautious to move a neutral piece to the killer positions. If both players are at this level, a sudden-death variant of the rules permits one to move both neutral pieces after moving. A player who can look three moves ahead can defeat defensive play using the standard rules.[clarification needed]
    </p>

    <h1>References</h1>

    <p>
        "Games and Puzzles 1974-11: Iss 30". A H C Publications. November 1974.
    </p>

    <h1>Other sources</h1>

    <p>
        de Bono, Edward (1967). "The L Game: Strategic Thinking". The Five-Day Course in Thinking. Basic Books Inc. pp. 149–206. LCCN 67027438.

    <p>
        Parlett, David (1999). "The L-Game". The Oxford History of Board Games. Oxford University Press Inc. pp. 161–62. ISBN 0-19-212998-8.

    <p>Pritchard, D. B. (1982). "The L Game". Brain Games. Penguin Books Ltd. pp. 107–12. ISBN 0-14-00-5682-3.
    </p>

    <h1>External links</h1>

    <p>L game on Edward de Bono's official site (archived)
    <p>Interactive web-based L game written in JavaScript
    </p>

    <h1>Categories:</h1>

    <p>
        Board games introduced in 1968Abstract strategy gamesMathematical gamesSolved games
    </p>
</div>

</body>
</html>
""";

  /*
  @override
  Widget build(BuildContext context)
  {
    final ButtonStyle buttonStyle =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: ScreenUtil().setSp(20)),
        backgroundColor: Colors.amberAccent);

    //  rootBundle = context;
    return MaterialApp(
      title: 'LGame help',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LGame help'),
          actions: [
          ElevatedButton(
            style: buttonStyle,
          child: Text(
              'back into LGame',
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/lgamefor2");
            },
          ),
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
        children: [
        Image(
        image: AssetImage(
        'assets/L_Game_start_position.svg.png',
        ),
      ),
      Scrollbar(
      controller: ScrollController(),
        child: SingleChildScrollView(
        controller: ScrollController(),
          child: Html(
            data: """
<h1>Demo Page</h1>
<p>Selfish strong christianity ascetic fearful spirit deceptions justice mountains decrepit. Reason fearful depths chaos truth will justice reason battle pious marvelous zarathustra ocean deceptions. Free battle oneself right christian reason holiest god ocean society faithful free decieve inexpedient.</p>
<p>Oneself deceptions chaos derive merciful evil holiest. Spirit moral christianity mountains eternal-return decrepit of salvation philosophy decrepit. Depths reason madness ultimate burying law superiority strong noble. Enlightenment prejudice depths justice love overcome oneself truth disgust. Ascetic eternal-return love convictions ascetic disgust ubermensch against self faithful decrepit moral endless play. Against reason dead madness virtues truth enlightenment insofar moral pinnacle ubermensch intentions.</p>
<p>Depths dead faithful superiority morality joy abstract depths joy zarathustra eternal-return holiest war. Christianity eternal-return pinnacle snare enlightenment derive transvaluation good sea inexpedient reason pious evil ultimate. Enlightenment joy inexpedient hatred aversion deceptions marvelous inexpedient ultimate.</p>
""",
          ),
        ),
      ),
      ],
      ),
      ),
    );
  }
}
*/

  /*
  final htmlStyle = {
    "table": Style(
      backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
    ),
    "tr": Style(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    "th": Style(
      padding: HtmlPaddings.all(6),
      backgroundColor: Colors.grey,
    ),
    "td": Style(
      padding: HtmlPaddings.all(6),
      alignment: Alignment.topLeft,
    ),
    "p": Style(
      padding: HtmlPaddings.all(6),
      fontSize: FontSize.large,
      alignment: Alignment.center,
    ),
    'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
  };
   */
  // final PageController pageController = PageController();
  final pageView = PageView(
    controller: PageController(),
    scrollDirection: Axis.horizontal,
    children: const [
      HelpPage1(),
      HelpPage2(),
      HelpPage3(),
      HelpPage4(),
    ],
  );

  @override
  Widget build(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(textStyle: TextStyle(fontSize:
     ScreenUtil().setSp(15), fontWeight: FontWeight.bold),
      backgroundColor: Colors.amberAccent);

  return SafeArea(
      minimum: const EdgeInsets.all(4.0),
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
    // leadingWidth: MediaQuery.of(context).padding.top,
        primary: false,
        title: Text('LGame help', style: textStyle,),
        centerTitle: false,
        actions: [
          Padding(padding: const EdgeInsets.only(top: 5.0, right: 10.0),
        child: Semantics(
          readOnly: true,
          label: "Wrap",
          hint: 'Wrap button',
          child: ElevatedButton(
            style: buttonStyle,
            child: const Text(
              'Back into LGame',
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2",
                  ModalRoute.withName('/lgamefor2'));
            },
          ),
          ),
          ),
        ],
      ),
      body: pageView ,
      ),
      );
  }
  }

  /*
        RefreshIndicator(
        onRefresh: _fetchPartner,
        child: SingleChildScrollView(
        controller: ScrollController(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      child: Text(
                        'L Game help',
                      ),
                    ),
                  ],
                ),
              ),

          Container(
            // width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor),
                  top: BorderSide(color: Theme.of(context).dividerColor)
              ),
              color: Colors.white,
            ),
            child: const Column(children: [
              Image(
                width: 150,
                height: 150,
                image: AssetImage(
                  'assets/L_Game_start_position.svg.png',
                ),),
              Text('Start position of L game'),
              Image(
                width: 250,
                height: 250,
                image: AssetImage(
                  'assets/560px-L_Game_mate_positions.svg.png',
                ),),
              Text("All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing."),
              Image(
                width: 250,
                height: 250,
                image: AssetImage(
                  'assets/560px-L_Game_all_final_positions.svg.png',
                ),),
              Text("All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing."),

            ]),
          ),

              ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics() /*NeverScrollableScrollPhysics() */ ,
                itemCount: 1,
                itemBuilder: (c, i) => InkWell(
                  onTap: () {},
                  child: BorderedContainer(
                    child: /* Text(
                      'List Item ${i + 1}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ) */
                    SingleChildScrollView(
                    controller: ScrollController(),
                      primary: true,
                      child: Html(style: htmlStyle, data: (strHelp0))  /* HtmlWidget(strHelp +strHelp2 +strHelp3) */,
                    ),
                  ),
                ),
              ),

             ],
          ),
        ),
        ),
*/

  /*
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  */

  /*
  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ListTile selection',
          ),
          leading: isSelectionMode
              ? IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                isSelectionMode = false;
              });
              initializeSelection();
            },
          )
              : const SizedBox(),
          actions: <Widget>[
            if (_isGridMode)
              IconButton(
                icon: const Icon(Icons.grid_on),
                onPressed: () {
                  setState(() {
                    _isGridMode = false;
                  });
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _isGridMode = true;
                  });
                },
              ),
            if (isSelectionMode)
              TextButton(
                  child: !_selectAll
                      ? const Text(
                    'select all',
                    style: TextStyle(color: Colors.white),
                  )
                      : const Text(
                    'unselect all',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _selectAll = !_selectAll;
                    setState(() {
                      _selected =
                      List<bool>.generate(listLength, (_) => _selectAll);
                    });
                  }),
          ],
        ),
        body: _isGridMode
            ? GridBuilder(
          isSelectionMode: isSelectionMode,
          selectedList: _selected,
          onSelectionChange: (bool x) {
            setState(() {
              isSelectionMode = x;
            });
          },
        )
            : ListBuilder(
          isSelectionMode: isSelectionMode,
          selectedList: _selected,
          onSelectionChange: (bool x) {
            setState(() {
              isSelectionMode = x;
            });
          },
        ));
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final ValueChanged<bool>? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.selectedList.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () => _toggle(index),
            onLongPress: () {
              if (!widget.isSelectionMode) {
                setState(() {
                  widget.selectedList[index] = true;
                });
                widget.onSelectionChange!(true);
              }
            },
            child: GridTile(
                child: Container(
                  child: widget.isSelectionMode
                      ? Checkbox(
                      onChanged: (bool? x) => _toggle(index),
                      value: widget.selectedList[index])
                      : const Icon(Icons.image),
                )),
          );
        });
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final ValueChanged<bool>? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.selectedList.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () => _toggle(index),
              onLongPress: () {
                if (!widget.isSelectionMode) {
                  setState(() {
                    widget.selectedList[index] = true;
                  });
                  widget.onSelectionChange!(true);
                }
              },
              trailing: widget.isSelectionMode
                  ? Checkbox(
                value: widget.selectedList[index],
                onChanged: (bool? x) => _toggle(index),
              )
                  : const SizedBox.shrink(),
              title: Text('item $index'));
        });
  }
}
*/

/*

class HelpRoute extends StatefulWidget {
  const HelpRoute({super.key});

  @override
  State<HelpRoute> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpRoute> {
 // late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadFlutterAsset('assets/help.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
 */
