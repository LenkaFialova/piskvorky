import QtQuick 2.0

Rectangle {
    id: container

    property alias caption: txt.text
    signal clicked
    radius: 10
    width: parent.width

    height: 40

    color: ma.pressed ? "silver" : "#f2b179"

    Text {
        id: txt

        font.family: "monospace"
        font.bold: true
        font.pixelSize: 16
        anchors.centerIn: parent
        color: "black"
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        onClicked: container.clicked()

    }
}
