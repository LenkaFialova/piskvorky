import QtQuick 2.0

Rectangle {
    id: rectGame
    width: parent.width
    height: parent.height
    color: "#888888"
    property bool gameAgainstPC: false
    property bool difficult: false

    Column {
        width: 320
        anchors.centerIn: parent
        spacing: 8

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            id: gameName
            font.family: "monospace"
            font.bold: true
            font.pixelSize: 25
            text: qsTr("Piškvorky")
            color: "white"
        }

        Text {
            id : text;
            font.family: "monospace"
            font.bold: true
            font.pixelSize: 16
            anchors.horizontalCenter: parent.horizontalCenter            
            color: "white";
            text: defaultText;
            property string defaultText: qsTr(" Na rade je O")
            property string defaultColor: "white"
        }

        Grid {
            id: gameGrid
            anchors.horizontalCenter: parent.horizontalCenter
            property string player: "O"
            property real boardSize: 3
            property real turnsCounter: 0
            property string defaultText: "·"
            property bool finished: false
            property var pos : {
                "r1": 1,
                "r2": 2,
                "r3": 3,
                "c1": 4,
                "c2": 5,
                "c3": 6,
                "d1": 7,
                "d2": 8,
                "full": 9,
                "noPos": 0,
            };


            columns: boardSize
            rows: boardSize
            Repeater {
                id: gridRepeater
                model: parent.boardSize * parent.boardSize
                Cell {
                    id: cell
                    width: 320/3
                    height: width
                }
            }


            //Funkce, ktera kontroluje, zda nedoslo k tahu, ktery ukoncuje hru - vyhra/plne hraci pole
            function checkForWin() {
                var tmp = gameGrid.pos.noPos;
                //maly pocet tahu
                if (gameGrid.turnsCounter < (boardSize*2-2)) return tmp;
                //kontrola radku
                if ((tmp = checkRows()) !== 0) return tmp;
                //kontrola sloupcu
                if ((tmp = checkCols()) !== 0) return tmp;
                //kontrola diagonal
                if ((tmp = checkDiagonals()) !== 0) return tmp;
                //kontrola na plne hraci pole -> zadny vitez = nerozhodna hra
                if (gameGrid.turnsCounter >= gameGrid.boardSize * gameGrid.boardSize) return gameGrid.pos.full;
                return tmp;
            }//checkForWin()

            //Funkce kontrolujici radky (hleda tri stejne symboly)
            function checkRows(){
                var winner;
                var firstCell = defaultText;
                var element;

                for(var r = 0; r < boardSize; r++){
                    firstCell = defaultText;

                    for(var i = 0; i < boardSize ; i++) {
                        element = gridRepeater.itemAt(r * boardSize + i);
                        //empty cell
                        if (element.state === defaultText) break;
                        if (firstCell === defaultText) firstCell = element.state;
                        else if (firstCell !== element.state) break;

                        if (i == 2) {
                            winner = firstCell;
                            if (r == 0) return gameGrid.pos.r1;
                            if (r == 1) return gameGrid.pos.r2;
                            if (r == 2) return gameGrid.pos.r3;
                        }
                    }
                }
                return gameGrid.pos.noPos;
            }//checkRows()

            //Funkce kontrolujici sloupce
            function checkCols(){
                var winner;
                var firstCell = defaultText;
                var element;

                for(var c = 0; c < boardSize; c++){
                    firstCell = defaultText;

                    for(var i = 0; i < boardSize ; i++) {
                        element = gridRepeater.itemAt(c + boardSize * i);

                        //empty cell
                        if (element.state === defaultText) break;

                        if (firstCell === defaultText) firstCell = element.state;
                        else if (firstCell !== element.state) break;

                        if (i == 2) {
                            if (c == 0) return gameGrid.pos.c1;
                            if (c == 1) return gameGrid.pos.c2;
                            if (c == 2) return gameGrid.pos.c3;
                        }
                    }
                }
                return gameGrid.pos.noPos;
            }//checkCols()

            //Funkce kontrolujici diagonaly
            function checkDiagonals(p){
                var winner;
                var firstCell = defaultText;
                var element;

                //kontrola diagonaly z praveho horniho rohu
                for(var i = 1; i <= boardSize ; i++) {
                    element = gridRepeater.itemAt(boardSize * i - i);
                    //empty cell
                    if (element.state === defaultText) break;
                    if (firstCell === defaultText) firstCell = element.state;
                    else if (firstCell !== element.state) break;
                    if (i == boardSize) return gameGrid.pos.d2;
                }

                //kontrola diagonaly z leveho horniho rohu
                firstCell = defaultText;
                for(i = 0; i < boardSize ; i++) {
                    element = gridRepeater.itemAt(boardSize * i + i);

                    //prazdne policko
                    if (element.state === defaultText) break;

                    if (firstCell === defaultText) firstCell = element.state;
                    else if (firstCell !== element.state) break;

                    if (i == 2) {
                        return gameGrid.pos.d1;
                    }
                }
                return gameGrid.pos.noPos;
            }//checkDiagonals()
        }
        Button {
            caption: "Nová hra";
            onClicked: {
                newGame();
            }
        }
        Button {
            caption: "Zpět";
            onClicked: {
                newGame();
                game.visible = false;
                menu1.visible = true;
            }
        }
    }

    //Funkce pro zahajeni nove hry
    function newGame() {
        gameGrid.turnsCounter = 0;
        gameGrid.finished = false;
        gameGrid.player = "X"
        text.text =  text.defaultText;
        text.color = text.defaultColor;

        //reset hraciho pole
        for (var i = 0; i < gameGrid.boardSize * gameGrid.boardSize; i++) {
            var element = gridRepeater.itemAt(i);
            element.state = gameGrid.defaultText;
        }

        //pokud jde o hru proti pocitaci a zacina pocitac, zahraje rovnou prvni tah
        if (game.gameAgainstPC && game.pcStarts){
            text.text = qsTr(" Na řade je X")
            element = gridRepeater.itemAt(getRandomInt(0, gameGrid.boardSize * gameGrid.boardSize));
            element.state = "O";
            gameGrid.turnsCounter++
        }
    }

    //Funkce zobrazujici vysledek ukoncene hry
    function showResult(pos) {
        text.color = "yellow"
        var winner;
        if (pos === gameGrid.pos.full) {
            text.text = "Hra skončila remízou";

            //zvyrazneni celeho pole
            for (var r = 0; r < gameGrid.boardSize; r++){
                for(var i = 0; i < gameGrid.boardSize; i++){
                   winner = gridRepeater.itemAt(r * gameGrid.boardSize + i);
                   winner.color = "yellow";
                }
            }
        }
        else{
            for(i = 0; i < gameGrid.boardSize; i++){
                if (pos === gameGrid.pos.r1) winner = gridRepeater.itemAt(i);
                else if (pos === gameGrid.pos.r2) winner = gridRepeater.itemAt(gameGrid.boardSize + i);
                else if (pos === gameGrid.pos.r3) winner = gridRepeater.itemAt(2 * gameGrid.boardSize + i);
                else if (pos === gameGrid.pos.c1) winner = gridRepeater.itemAt(gameGrid.boardSize * i);
                else if (pos === gameGrid.pos.c2) winner = gridRepeater.itemAt(1 + gameGrid.boardSize * i);
                else if (pos === gameGrid.pos.c3) winner = gridRepeater.itemAt(2 + gameGrid.boardSize * i);
                else if (pos === gameGrid.pos.d1) winner = gridRepeater.itemAt(gameGrid.boardSize * i + i);
                else if (pos === gameGrid.pos.d2) winner = gridRepeater.itemAt(gameGrid.boardSize * (i+1) - (i+1));
                winner.color = "yellow";
            }

            if (game.gameAgainstPC){
                if ((winner.state === "X" && game.pcStarts) || (winner.state === "O" && game.pcStarts == false)){
                    text.text = "Gratuluji, jsi vítěz!";
                }
                else text.text = "Prohrál jsi..:(";

            }
            else{
                text.text = "Hráč '" + winner.state + "'" + " vyhrává";
            }

        }
        message.show(text.text)
    }//showResult()

}


