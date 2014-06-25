import QtQuick 2.0

Rectangle {
    id: msg
    width: parent.width
    height: parent.height
    color: "black"
    opacity: 0.7

    Text {
        id: msgText
        font.family: "monospace"
        font.pixelSize: parent.height * 0.04
        font.bold: true
        color: "white"
        anchors.fill: parent
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            msg.visible = false;
        }
    }

    function show(text) {
        visible = true
        msgText.text = text
    }


}
