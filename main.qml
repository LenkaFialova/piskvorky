import QtQuick 2.0

Rectangle {
    width: 320
    height: 480


    Item {
        width: parent.width
        height: parent.height
        Menu1 {
            id: menu1
            visible: true
        }

        Menu2 {
            id: menu2
            visible: false
        }

        Game {
            id: game
            visible: false
            property bool gameAgaintsPC: false
            property bool pcStarts: false
            property bool difficult: false
        }

        About {
            id: about
            visible: false
        }

        Starter {
            id: starter
            visible: false
        }

        Message{
            id: message
            visible: false
        }


    }




    function getRandomInt(min, max) {
      return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function sleep(milliseconds) {
      var start = new Date().getTime();
      for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds){
          break;
        }
      }
    }
}
