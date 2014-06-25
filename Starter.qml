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
            font.family: "monospace"
            id : textArea
            font.bold: true
            font.pixelSize: 25
            text: qsTr("Kdo začne?")
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

       Button {
            id: btnEasy
            caption: "Hráč"
            onClicked: {
                starter.visible = false
                game.visible = true
                game.pcStarts = false
                game.newGame()

            }
        }

        Button {
            caption: "Počítač"
            onClicked: {
                starter.visible = false
                game.visible = true
                game.pcStarts = true
                game.newGame()
            }
        }
    }
}
