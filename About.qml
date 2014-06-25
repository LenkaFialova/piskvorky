import QtQuick 2.0

Rectangle {
    width: parent.width
    height: parent.height
    color: "#888888"

    Text {
        id : text1;
        font.family: "monospace"
        font.bold: true
        font.pixelSize: 25
        text: qsTr("Piškvorky")
        color: "white"
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        font.family: "monospace"
        font.bold: true
        font.pixelSize: 16
        text: qsTr("Hra piškvorky...")
        color: "white"
        anchors.top: text1.bottom
    }



    Column {
       width: parent.width
       //sanchors.centerIn: parent
       anchors.bottom: parent.bottom
       spacing: 8

       Button {
           caption: "Zpět";
           onClicked: {
               about.visible = false;
               menu1.visible = true;
           }
       }
    }



}
