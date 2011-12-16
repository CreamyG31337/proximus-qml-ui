import QtQuick 1.1
import com.nokia.meego 1.0

Page{
    //tools: commonTools
    id: rulePage
    property string mode

    function setCoord(latitude, longitude)
    {
        txtLocLatitude.text = latitude;
        txtLocLongitude.text = longitude;
    }

    function setTime(whichTime, timeToSet)
    {
        if (whichTime == 1)
        {
            btnTime1.text = timeToSet
        }
        if (whichTime == 2)
        {
            btnTime2.text = timeToSet
        }
    }

    MapPage {
        id: mapPage
    }    

    Flickable{
    anchors.fill: parent
    contentHeight: 1000
        MouseArea {//not sure why but if you don't do this the keyboard won't close when you try to click away from the input fields
            anchors.fill: parent
            onClicked: {txtLocLongitude.closeSoftwareInputPanel();}
            }
        Label {
            id: lblRuleName
            anchors.top : parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: mode + " rule " + tabSettings.selectedRuleName
            height: 20
        }
////////////////////////ACTIONS
        Label{
            id: lblActionHeader
            text: "Action to take"
            anchors.top: lblRuleName.bottom
            height: 20
            visible: false
        }
        Switch{
            anchors.top: lblActionHeader.bottom
            id: swChangeProfile
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Actions/Run/enabled",true)
            onCheckedChanged: {
                txtLocRadius.enabled = swUseLocation.checked;
                txtLocLatitude.enabled = swUseLocation.checked;
                txtLocLongitude.enabled = swUseLocation.checked;
            }
        }
        Label{
            anchors.top: lblActionHeader.bottom
            anchors.left: swChangeProfile.right
            height: swGPS.height
            verticalAlignment: Text.AlignVCenter
            text: "Switch Profile"
        }
//////////////////RULES
        Label{
            id: lblActivationHeader
            text: "When..."
            anchors.top: swChangeProfile.bottom
            height: 20
        }
//////////////////LOCATION
        Switch{
            anchors.top: lblActivationHeader.bottom
            id: swUseLocation
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/enabled",true)
            onCheckedChanged: {
                txtLocRadius.enabled = swUseLocation.checked;
                txtLocLatitude.enabled = swUseLocation.checked;
                txtLocLongitude.enabled = swUseLocation.checked;//should grey these out
            }
        }
        Label{
            anchors.top: lblActivationHeader.bottom
            anchors.left: swUseLocation.right
            height: swGPS.height
            verticalAlignment: Text.AlignVCenter
            text: "Location match"
            color: "black"
        }
        Label{
            anchors.top: lblActivationHeader.bottom
            anchors.right: swUseLocationNot.left
            height: swGPS.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            text: "NOT"
            font.pixelSize: 24
            color: "black"

        }
        Switch{
            id: swUseLocationNot
            anchors.top: lblActivationHeader.bottom
            anchors.right: parent.right
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/NOT",false)
        }

        Label {
            anchors.top: swUseLocation.bottom
            id: lblLocationRadius
            height: 45
            verticalAlignment: Text.AlignVCenter
            text: "Radius: "
        }
        Rectangle{
            id: recRadius
            anchors.top: swUseLocationNot.bottom
            anchors.left: lblLocationRadius.right
            width: 100
            height: 45
            border.width: 2
            border.color: "#4b4b4b"
            color: "white"
            radius: 5
        TextInput{
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            id: txtLocRadius
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/RADIUS",0)
            font.pixelSize: 26
            validator: IntValidator{bottom: 1; top: 2000;}
            maximumLength: 4
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!txtLocRadius.activeFocus) {
                    txtLocRadius.forceActiveFocus()
                    txtLocRadius.selectAll();
                } else {
                    txtLocRadius.focus = false;
                }
            }
        }}
        Label {
            anchors.top: swUseLocation.bottom
            anchors.left: recRadius.right
            id: lblLocationRadiusUnits
            height: 45
            verticalAlignment: Text.AlignVCenter
            text: " (m)"
        }
        Label {
            height: 45
            verticalAlignment: Text.AlignVCenter
            anchors.top: recRadius.bottom
            id: lblLocationLatitude
            text: "Latitude: "
        }
        Rectangle{
            id: recLatitude
            anchors.top: recRadius.bottom
            anchors.left: lblLocationLatitude.right
            width: 180
            height: 45
            border.width: 2
            border.color: "#4b4b4b"
            color: "white"
            radius: 5
        TextInput{
          //  height: parent.height
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            id: txtLocLatitude
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/LATITUDE",0)
            font.pixelSize: 26
            validator: DoubleValidator{}
            maximumLength: 13
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!txtLocLatitude.activeFocus) {
                    txtLocLatitude.forceActiveFocus()
                    txtLocLatitude.selectAll();
                } else {
                    txtLocLatitude.focus = false;
                }
            }
        }}

        Label {
            anchors.top: recLatitude.bottom
            height: 45
            verticalAlignment: Text.AlignVCenter
            id: lblLocationLongitude
            text: "Longitude: "
        }
        Rectangle{
            id: recLongitude
            anchors.top: recLatitude.bottom
            anchors.left: lblLocationLongitude.right
            width: 180
            height: 45
            border.width: 2
            border.color: "#4b4b4b"
            color: "white"
            radius: 5
        TextInput{
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            id: txtLocLongitude
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Location/LONGITUDE",0)
            font.pixelSize: 26
            validator: DoubleValidator{}
            maximumLength: 13
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!txtLocLongitude.activeFocus) {
                    txtLocLongitude.forceActiveFocus()
                    txtLocLongitude.selectAll();
                } else {
                    txtLocLongitude.focus = false;
                }
            }
        }}
        Button{
            id: btnFillFromMap
            anchors {
                right: parent.right
                top: recRadius.top
            }
            width: 170
            height: 45*3
            text: qsTr("Fill From Map")
            //onClicked: appWindow.pageStack.push(mapPage)
            //doing this way everywhere seems dumb because everything is created too early,
            //gps activates when u launch the app. but it still does that.
            onClicked: {
                appWindow.pageStack.push(Qt.resolvedUrl("MapPage.qml"),
                  {longitudeReq: txtLocLongitude.text, latitudeReq: txtLocLatitude.text, radiusSize: txtLocRadius.text} );
            }
        }
        /////////////////////////CALENDAR

        Switch{
            id: swUseCalendar
            anchors.top: btnFillFromMap.bottom
            anchors.left: parent.left
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Calendar/enabled",true)
            onCheckedChanged: {

            }
        }
        Label{
            anchors.top: btnFillFromMap.bottom
            anchors.left: swUseCalendar.right
            height: swUseCalendar.height
            verticalAlignment: Text.AlignVCenter
            text: "Calendar keyword match"
            font.pixelSize: 24
            color: "black"
        }
        Label{
            height: swUseCalendar.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            text: "NOT"
            font.pixelSize: 24
            color: "black"
            anchors.right: swUseCalendarNOT.left
            anchors.top: btnFillFromMap.bottom
        }
        Switch{
            id: swUseCalendarNOT
            anchors.right: parent.right
            anchors.top: btnFillFromMap.bottom
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Calendar/NOT",false)
        }
        Rectangle{
            id:recCalendarKeywords
            width: parent.width - 20
            height: 45
            anchors.top: swUseCalendarNOT.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 2
            border.color: "#4b4b4b"
            color: "white"
            radius: 5
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            id: txtCalendarKeywords
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Calendar/KEYWORDS","")
            font.pixelSize: 26
            //validator:
            maximumLength: 255
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!txtCalendarKeywords.activeFocus) {
                    txtCalendarKeywords.forceActiveFocus()
                    //txtCalendarKeywords.openSoftwareInputPanel();
                } else {
                    txtCalendarKeywords.focus = false;
                }
            }
        }}

        //////////////////////////TIMES

        Switch{
            id: swUseTime
            anchors.top: recCalendarKeywords.bottom
            anchors.left: parent.left
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Time/enabled",true)
            onCheckedChanged: {
                txtLocRadius.enabled = swUseLocation.checked;
                txtLocLatitude.enabled = swUseLocation.checked;
                txtLocLongitude.enabled = swUseLocation.checked;
            }
        }
        Label{
            anchors.top: recCalendarKeywords.bottom
            anchors.left: swUseTime.right
            height: swUseTimeNot.height
            verticalAlignment: Text.AlignVCenter
            text: "Between these times"
            color: "black"
        }
        Label{
            anchors.top: recCalendarKeywords.bottom
            anchors.right: swUseTimeNot.left
            height: swUseTimeNot.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            text: "NOT"
            font.pixelSize: 24
            color: "black"

        }
        Switch{
            id: swUseTimeNot
            anchors.top: recCalendarKeywords.bottom
            anchors.right: parent.right
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Time/NOT",false)
        }
        Button{
            id: btnTime1
            anchors {
                left: parent.left
                top: swUseTimeNot.bottom
            }
            width: 150
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Time/TIME1","set time 1")
            onClicked: {
                appWindow.pageStack.push(Qt.resolvedUrl("TimePicker.qml"),
                  {time: 1} );
            }
        }
        Button{
            id: btnTime2
            anchors {
                left: btnTime1.right
                top: swUseTimeNot.bottom
            }
            width: 150
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Time/TIME2","set time 2")
            onClicked: {
                appWindow.pageStack.push(Qt.resolvedUrl("TimePicker.qml"),
                  {time: 2} );
            }
        }
        //////////////////////////SAVE  OR CANCEL

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
            id: btnSave
            anchors {
                right: btnCancel.left
                bottom: parent.bottom
            }
            width: 150
            text: qsTr("Save")
            onClicked: {
                //objQSettings.setValue()
                appWindow.pageStack.pop()
            }
        }
    }
}
