import QtQuick 1.1
import com.nokia.meego 1.0

Page{
    tools: commonTools
    id: rulePage
    property string mode

    Label {
        id: lblRuleName
        anchors.top : parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: mode + " rule " + tabSettings.selectedRuleName
        visible: true
    }

    Row{
        id: rowRuleLocationSwitches
        spacing: 10
        anchors.top: lblRuleName.bottom
        Switch{
            id: swUseLocation
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/enabled",true)
            onCheckedChanged: {
                txtLocRadius.enabled = swUseLocation.checked
            }
        }
        Text{
            width: rowSettings1.width - rowSettings1.spacing - swGPS.width
            height: swGPS.height
            verticalAlignment: Text.AlignVCenter
            text: "Location"
            font.pixelSize: 25
            color: "black"
        }
    }
    Row{
        id: rowRuleLocationRadius
        spacing: 10
        anchors.top: rowRuleLocationSwitches.bottom
        Label {
            id: lblLocationRadius
            text: "Radius:"
        }
        TextInput{
            id: txtLocRadius
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/RADIUS",0)
            width: 100
            font.pixelSize: 25
            validator: IntValidator{bottom: 1; top: 2000;}
            maximumLength: 4
        }
    }
    Row{
        id: rowRuleLocationLatitude
        spacing: 10
        anchors.top: rowRuleLocationRadius.bottom
        Label {
            id: lblLocationLatitude
            text: "Latitude:"
        }
        TextInput{
            id: txtLocLatitude
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/LONGITUDE",0)
            width: 100
            font.pixelSize: 25
            validator: IntValidator{bottom: 1; top: 2000;}
            maximumLength: 4
        }
    }

    Row{
        id: rowRuleLocationLongitude
        spacing: 10
        anchors.top: rowRuleLocationLatitude.bottom
        Label {
            id: lblLocationLongitude
            text: "Longitude: "
        }
        TextInput{
            id: txtLocLongitude
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/LATITUDE",0)
            width: 100
            font.pixelSize: 25
            validator: IntValidator{bottom: 1; top: 2000;}
            maximumLength: 4
        }
    }


    Button{
        id: btnCancel
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        width: 150
        text: qsTr("Cancel")
        onClicked: appWindow.pageStack.pop()
    }
    Button{
        id: btn
        anchors {
            right: btnCancel.left
            bottom: parent.bottom
        }
        width: 150
        text: qsTr("Save")
        onClicked: appWindow.pageStack.pop()
    }
}
