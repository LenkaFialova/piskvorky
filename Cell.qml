import QtQuick 2.0

Rectangle {
    id: cell
    state: gameGrid.defaultText

    Text {
        id: cellText
        text: parent.state
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: parent.width/2
    }

    states: [
           State {
               name: cell.parent.defaultText
               PropertyChanges { target: gameGrid; player: "" }
               PropertyChanges { target: cellText; text: gameGrid.defaultText }
               PropertyChanges { target: cellText; color: "silver" }
           },
           State {
               name: "O"
               PropertyChanges { target: gameGrid; player: cell.state }
               PropertyChanges { target: cell; color: "white" }
               PropertyChanges { target: cellText; color: "blue" }

           },
           State {
               name: "X"
               PropertyChanges { target: gameGrid; player: cell.state }
               PropertyChanges { target: cell; color: "white" }
               PropertyChanges { target: cellText; color: "red" }
           }
       ]

    MouseArea {
        anchors.fill: parent
        onClicked: {
            var tmp = 0;
            //pole je prazdne a hra stale neskoncila
            if (cell.state === cell.parent.defaultText && gameGrid.finished == false){
                //hra proti pocitaci
                if (game.gameAgainstPC == true){
                    var element;
                    //prvni tah
                    if (gameGrid.player === ""){
                        cell.state = "O";
                        gameGrid.turnsCounter++
                        //tah pocitace
                        element = gridRepeater.itemAt(pcTurnRandom());
                        element.state = "X"
                        gameGrid.turnsCounter++

                    }
                    //dalsi tahy
                    else {
                        //hru zacal pocitac
                        if (game.pcStarts){
                            cell.state = "X";
                            gameGrid.turnsCounter++
                            tmp = gameGrid.checkForWin();
                            if (tmp === 0) {
                                //tah pocitace dle obtiznosti
                                if (game.difficult) element = gridRepeater.itemAt(pcTurnAdvanced());
                                else element = gridRepeater.itemAt(pcTurnRandom());
                                element.state = "O"
                                gameGrid.turnsCounter++
                                tmp = gameGrid.checkForWin();
                            }
                        }
                        //hru zacal hrac
                        else {
                            cell.state = "O";
                            gameGrid.turnsCounter++
                            tmp = gameGrid.checkForWin();
                            if (tmp === 0) {
                                if (game.difficult) element = gridRepeater.itemAt(pcTurnAdvanced());
                                else element = gridRepeater.itemAt(pcTurnRandom());
                                element.state = "X"
                                gameGrid.turnsCounter++
                                tmp = gameGrid.checkForWin();
                            }
                        }
                    }
                }
                // hra dvou hracu
                else {
                    if (gameGrid.player === ""){
                        text.text = " Na řade je " + "X";
                        cell.state = "O";
                    }
                    else if (gameGrid.player == "O") {
                        text.text = " Na řade je " + gameGrid.player;
                        cell.state = "X";
                    }
                    else{
                        text.text = " Na řade je " + gameGrid.player;
                        cell.state = "O";
                    }
                    gameGrid.turnsCounter++
                    tmp = gameGrid.checkForWin()
                }
                if (tmp !== 0){
                    gameGrid.finished = true
                    showResult(tmp);
                }
            }
        }
    }

    //Pocitac hraje na nahodne vybranou prazdnou pozici
    function pcTurnRandom(){
        var element;
        var index = 0;
        var emptyCells = [];

        //ziskani vsech volnych pozic
        for (var i = 0; i < gameGrid.boardSize * gameGrid.boardSize; i++){
            element = gridRepeater.itemAt(i);
            if (element.state === "·") {
                emptyCells[index] = i;
                index++;
            }
        }
        return (emptyCells[getRandomInt(0, index)]);
    }

    //Pocitac nevybira pozice nahodne, postupuje dle strategie
    function pcTurnAdvanced(){
        var tmp;
        var element;
        var pcSymbol;
        var playerSymbol;

        //pokud zacina pocitac, ma kolecko, jinak hraje s krizkem
        if (game.pcStarts == true) {
            pcSymbol = "O";
            playerSymbol = "X"
        }
        else {
            pcSymbol = "X"
            playerSymbol = "O"
        }

        //hledani pozice, kde muze PC zahrat a ihned vyhraju/ukoncim hru
        //dale hledani pozice, kde by mohl hrac v dalsim kole vyhrat hru
        for (var j = 0; j < 2; j++) {
            for (var i = 0; i < gameGrid.boardSize * gameGrid.boardSize; i++){

                element = gridRepeater.itemAt(i);

                //pokud je pozice volna
                if (element.state === "·") {
                    //zkousim zahrat na tuto pozici
                    if (j == 0) element.state = pcSymbol
                    else element.state = playerSymbol
                    gameGrid.turnsCounter++

                    //ulozeni vysledku takove hry
                    tmp = gameGrid.checkForWin();

                    //vracim tah zpet
                    element.state = "·"
                    gameGrid.turnsCounter--

                    //kontrola vysledku
                    if (tmp !== 0){
                        return i;
                    }
                }
            }
        }

        /*.....dalsi strategie...*/
        return (pcTurnRandom());
    }


}
