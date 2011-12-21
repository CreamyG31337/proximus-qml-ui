import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: settingsPage
    tools: commonTools

    property string selectedRuleName

    function resetList(){
        objProximusUtils.refreshRulesModel();
        rulesList.currentIndex = -1;
        btnEnable.visible = false;
        btnDisable.visible = false;
        btnEdit.enabled = false;
        btnDelete.enabled = false;
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
            checked: objQSettings.getValue("/settings/GPS/enabled",true)
            onCheckedChanged: {objQSettings.setValue("/settings/GPS/enabled",swGPS.checked) }
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
    Row{
        id: rowSettings2
        spacing: 10
        anchors.top: rowSettings1.bottom
        Switch{
            id: swService
            checked: objQSettings.getValue("/settings/Service/enabled",false)
            onCheckedChanged: {objQSettings.setValue("/settings/Service/enabled",swService.checked) }
        }
        Text{
            width: rowSettings2.width - rowSettings2.spacing - swService.width
            height: swGPS.height
            verticalAlignment: Text.AlignVCenter
            text: "Enable Service"
            font.pixelSize: 25
            color: "black"
        }
    }
    Label {
        id: lblRules
        //anchors.centerIn: parent
        anchors{
            top: rowSettings2.bottom
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
            settingsPage.selectedRuleName = ""
            rulesList.currentIndex = -1;
            //appWindow.pageStack.push(rulePage);
            appWindow.pageStack.push(Qt.resolvedUrl("RulePage.qml"))
            //appWindow.pageStack.currentPage.mode = "new"
            //rulePage.mode = "new"
        }
    }
    Button{
        id: btnEdit
        anchors {
            right: parent.right
            top: btnNew.bottom
            topMargin: 10
        }
        enabled: false
        width: 150
        text: qsTr("Edit")
        onClicked: {
            //appWindow.pageStack.push(rulePage);
            appWindow.pageStack.push(Qt.resolvedUrl("RulePage.qml"),
                                     {ruleName: settingsPage.selectedRuleName});
           // appWindow.pageStack.currentPage.mode = "edit"
        }
    }
    Button{
        id: btnEnable
        anchors {
            right: parent.right
            top: btnEdit.bottom
            topMargin: 10
        }
        visible: false
        width: 150
        text: qsTr("Enable")
        onClicked: {
        objQSettings.setValue("/rules/" +  settingsPage.selectedRuleName + "/enabled",true)
        resetList();
        }
    }
    Button{
        id: btnDisable
        anchors {
            right: parent.right
            top: btnEdit.bottom
            topMargin: 10
        }
        visible: false
        width: 150
        text: qsTr("Disable")
        onClicked: {
        objQSettings.setValue("/rules/" +  settingsPage.selectedRuleName + "/enabled",false)
        resetList();
        }
    }
    Button{
        id: btnDelete
        enabled: false
        anchors {
            right: parent.right
            top: btnEnable.bottom
            topMargin: 10
        }
        width: 150
        text: qsTr("Delete")
        onClicked: {
            objQSettings.remove("/rules/"+  settingsPage.selectedRuleName)
        resetList();
        }
    }

    ListView{
        id: rulesList
        model: objRulesModel
        height: tabStatus.height - 175
        delegate:  Text{
            height: 40;
            font.pixelSize: 25;
            text: "Rule " + index + " " + model.modelData.name;
            color:(model.modelData.enabled == true)?'green':'red';
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (model.modelData.enabled == true){
                        btnDisable.visible = true
                        btnEnable.visible = false
                    }
                    else{
                        btnEnable.visible = true
                        btnDisable.visible = false
                    }
                    btnEdit.enabled = true;
                    btnDelete.enabled = true;
                    rulesList.currentIndex = index
                    settingsPage.selectedRuleName =  model.modelData.name;
                }
            }
        }
        anchors {
            top: lblRules.bottom
            left: parent.left
            right: btnDelete.left
           // bottom: parent.bottom
        }
        highlight: Rectangle {color: "lightsteelblue"; radius: 6; width: rulesList.width}
        focus: true
        Component.onCompleted: {//not sure how to get already selected name, just remove highlight then...
            rulesList.currentIndex = -1;
        }
    }
}
