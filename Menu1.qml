import QtQuick 2.0

Rectangle {
    width: parent.width
    height: parent.height
    color: "#888888"

    Column {
       width: parent.width
       anchors.centerIn: parent
       spacing: 8

       Text {
           anchors.horizontalCenter: parent.horizontalCenter
           id: textArea
           font.family: "monospace"
           font.bold: true
           font.pixelSize: 25
           text: qsTr("Tic Tac Toe")
           color: "white"
       }

       Button {
           caption: "Hrát";
           onClicked: {
               menu1.visible = false;
               game.visible = true;
           }
       }
       Button {
           caption: "Nastavení";
           onClicked: {
               menu1.visible = false;
               menu2.visible = true;
           }
       }
       Button {
           caption: "O hře";
           onClicked: {
               menu1.visible = false;
               about.visible = true;

           }
       }
       Button { caption: "Ukončit"; onClicked: Qt.quit();}

    }
}
