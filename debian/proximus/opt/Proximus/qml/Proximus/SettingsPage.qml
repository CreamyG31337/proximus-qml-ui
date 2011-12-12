import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: tabSettings
    tools: commonTools

    property string selectedRuleName

    RulePage {
        id: rulePage
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
            font.pixelSize: 25
            color: "black"
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
        onClicked: {
            tabSettings.selectedRuleName = ""
            rulesList.currentIndex = -1;
            appWindow.pageStack.push(rulePage);
            rulePage.mode = "new"
        }
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
        onClicked: {
            appWindow.pageStack.push(rulePage);
            rulePage.mode = "edit"
        }
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

//    Rectangle{
//        color: "red"
//        anchors {
//            top: lblRules.bottom
//            left: parent.left
//            right: btnDelete.left
//        }
//        height: tabSettings.height - 175
//    }
    ListView{
        id: rulesList
        model: objRulesModel
        height: tabStatus.height - 175
        delegate:  Text{
            height: 40;
            font.pixelSize: 25;
            text: "Rule " + index + " " + model.modelData.name;
            color:(model.modelData.enabled = true)?'green':'red';
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rulesList.currentIndex = index
                    tabSettings.selectedRuleName =  model.modelData.name;
                }
            }
        }
        anchors {
            top: lblRules.bottom
            left: parent.left
            right: btnDelete.left
           // bottom: parent.bottom
        }
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
        Component.onCompleted: {//not sure how to get already selected name, just remove highlight then...
            rulesList.currentIndex = -1;
        }
    }
}
