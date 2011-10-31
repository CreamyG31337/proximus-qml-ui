import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: tabStatus
    tools: commonTools
    anchors { fill: parent;
        top: statusBar.bottom
    }
    Label {
        id: lblSettings
        //anchors.centerIn: parent
        anchors{top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Global Settings")
        visible: true
    }
    Row{
        id: rowSettings1
        spacing: 10
        anchors.top: lblSettings.bottom
        Switch{
            id: swGPS
            checked: objQSettings.getValue("settings/GPS",true)
            onCheckedChanged: {objQSettings.setValue("settings/GPS",swGPS.checked) }
        }
        Text{
            width: rowSettings1.width - rowSettings1.spacing - swGPS.width
            height: swGPS.height
            verticalAlignment: Text.AlignVCenter
            text: "Use GPS"
            font.pixelSize: platformStyle.fontSizeMedium
            color: platformStyle.colorNormalLight
        }
    }
    Label {
        id: lblRules
        //anchors.centerIn: parent
        anchors{
            top: rowSettings1.bottom
            topMargin: 10
        }
        text: qsTr("Rules:")
    }
    Button{
        id: btnNew
        anchors {
            right: parent.right
            top: lblRules.bottom
        }
        width: 150
        text: qsTr("New")
        onClicked: label.visible = true
    }
    Button{
        id: btnEdit
        anchors {
            right: parent.right
            top: btnNew.bottom
            topMargin: 10
        }
        width: 150
        text: qsTr("Edit")
        onClicked: label.visible = true
    }
    Button{

        id: btnEnable
        anchors {
            right: parent.right
            top: btnEdit.bottom
            topMargin: 10
        }
        width: 150
        text: qsTr("Enable")
        onClicked: label.visible = true
    }
    Button{
        id: btnDisable
        anchors {
            right: parent.right
            top: btnEnable.bottom
            topMargin: 10
        }
        width: 150
        text: qsTr("Disable")
        onClicked: label.visible = true
    }
    Button{
        id: btnDelete
        anchors {
            right: parent.right
            top: btnDisable.bottom
            topMargin: 10
        }
        width: 150
        text: qsTr("Delete")
        onClicked: label.visible = true
    }
    ListView{
        id: rulesList
        model: objRulesModel
        delegate:  Text{ text: "Rule " + index}
        anchors {
            top: lblRules.bottom
            left: parent.left
            right: btnDelete.left
        }
    }
}
