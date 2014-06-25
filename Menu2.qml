import QtQuick 2.0

Rectangle {
    width: parent.width
    height: parent.height
    color: "#888888"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }

        Column {
               width: parent.width
               anchors.centerIn: parent
               spacing: 8

               Button {
                   caption: "Hra dvou hráčů";
                   onClicked: {
                       menu2.visible = false
                       game.visible = true
                       game.gameAgainstPC = false;
                   }
               }
               Button {
                   caption: "Hra proti PC - EASY";
                   onClicked: {
                       menu2.visible = false
                       starter.visible = true
                       game.difficult = false;
                       game.gameAgainstPC = true;
                   }
               }
               Button {
                   caption: "Hra proti PC - HARD";
                   onClicked: {
                       menu2.visible = false
                       starter.visible = true
                       game.difficult = true
                       game.gameAgainstPC = true;
                   }
               }
               Button {
                   caption: "Zpět";
                   onClicked: {
                       menu2.visible = false;
                       menu1.visible = true;

                   }
               }

           }
    }
}
