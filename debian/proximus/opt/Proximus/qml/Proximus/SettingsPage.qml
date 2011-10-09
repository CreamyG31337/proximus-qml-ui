import QtQuick 1.1
import com.nokia.meego 1.0

Page {
   // id: settingsPage
    tools: commonTools
    anchors { fill: parent; topMargin: 20;}
    Label {
        id: label
        //anchors.centerIn: parent
        anchors{top: parent.top}
        text: qsTr("settings page")
        visible: false
    }
    Row{
        id: rowRow
        spacing: 10
        anchors.top: label.bottom
        Switch{
            id: swGPS
        }
        Text{
            width: rowRow.width - rowRow.spacing - swGPS.width
            height: swGPS.height
            verticalAlignment: Text.AlignVCenter
            text: "Use GPS"
            font.pixelSize: platformStyle.fontSizeMedium
            color: platformStyle.colorNormalLight
        }
    }



    Button{
        id: btnNew
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: rowRow.bottom
            topMargin: 10
        }
        text: qsTr("New")
        onClicked: label.visible = true
    }
    Button{
        id: btnEdit
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: btnNew.bottom
            topMargin: 10
        }
        text: qsTr("Edit")
        onClicked: label.visible = true
    }
    Button{
        id: btnDelete
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: btnEdit.bottom
            topMargin: 10
        }
        text: qsTr("Delete")
        onClicked: label.visible = true
    }
}
