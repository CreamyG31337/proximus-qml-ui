import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0

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

    function showError(errorString)
    {
        errorMessageBanner.text = errorString;
        errorMessageBanner.show();
    }

    MapPage {
        id: mapPage
    }    

    InfoBanner{
        id: errorMessageBanner
        z: 99
    }

    Flickable{
    anchors.fill: parent
    contentHeight: 600
        MouseArea {//not sure why but if you don't do this the keyboard won't close when you try to click away from the input fields
            anchors.fill: parent
            onClicked: {txtLocLongitude.closeSoftwareInputPanel();}
            }
        Label {
            id: lblRuleName
            anchors.top : parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            text: mode + " rule "
            height: 45
        }
        Rectangle{
            id: recRuleName
            anchors.top: lblRuleName.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 45
            border.width: 2
            border.color: "#4b4b4b"
            color: "white"
            radius: 5
            TextInput{
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                id: txtRuleName
                text: tabSettings.selectedRuleName //if blank...
                font.pixelSize: 26
                //validator:
                maximumLength: 64
            }
        }
////////////////////////ACTIONS
        Label{
            id: lblActionHeader
            text: "Action to take"
            anchors.top: recRuleName.bottom
            height: 20
            visible: false
        }
        Switch{
            anchors.top: lblActionHeader.bottom
            id: swChangeProfile
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Actions/Run/enabled",true)
            onCheckedChanged: {
                radiusSlider.enabled = swUseLocation.checked;
                txtLocLatitude.enabled = swUseLocation.checked;
                txtLocLongitude.enabled = swUseLocation.checked;
            }
        }
        Label{
            id: lblSwProfile
            anchors.top: lblActionHeader.bottom
            anchors.left: swChangeProfile.right
            height: swGPS.height
            verticalAlignment: Text.AlignVCenter
            text: "Switch Profile "
        }
        TumblerButton{
            id: btnChooseProfile
            anchors.left: lblSwProfile.right
            anchors.verticalCenter: lblSwProfile.verticalCenter
            text: "choose"
            onClicked: tDialog.open();
        }
        TumblerDialog{
            id: tDialog
            titleText: "Select Profile"
            columns: [ profileColumn ]
            acceptButtonText: "Ok"
            onAccepted: btnChooseProfile.text = profileColumn.items[profileColumn.selectedIndex]; //thanks for depricating label...
        }
        TumblerColumn{
            id: profileColumn
            items: objProfileClient.profileTypes()
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
                radiusSlider.enabled = swUseLocation.checked;
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
            text: "Radius (m): "
        }
        CountBubble{
            id: cbRadius
            //anchors.top: swUseLocation.bottom
            anchors.verticalCenter: lblLocationRadius.verticalCenter
            anchors.left: lblLocationRadius.right
            value: radiusSlider.value
            largeSized: true
        }
        Slider{
            id: radiusSlider
            width: parent.width - lblLocationRadius.width - cbRadius.width
            anchors.verticalCenter: lblLocationRadius.verticalCenter
            anchors.left: cbRadius.right
            stepSize: 10
            maximumValue: 2000
        }
        Label {
            height: 45
            verticalAlignment: Text.AlignVCenter
            anchors.top: radiusSlider.bottom
            id: lblLocationLatitude
            text: "Latitude: "
        }
        Rectangle{
            id: recLatitude
            anchors.top: radiusSlider.bottom
            anchors.left: recLongitude.left
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
        }

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
        }
        Button{
            id: btnFillFromMap
            anchors {
                right: parent.right
                top: recLatitude.top
            }
            width: 170
            height: 45*2
            text: qsTr("Fill From Map")
            //onClicked: appWindow.pageStack.push(mapPage)
            //doing this way everywhere seems dumb because everything is created too early,
            //gps activates when u launch the app. but it still does that.
            onClicked: {
                appWindow.pageStack.push(Qt.resolvedUrl("MapPage.qml"),
                  {longitudeReq: txtLocLongitude.text, latitudeReq: txtLocLatitude.text, radiusSize: cbRadius.value} );
            }
            style: PositiveButtonStyle {}
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
        }

        //////////////////////////TIMES
        Switch{
            id: swUseTime
            anchors.top: recCalendarKeywords.bottom
            anchors.left: parent.left
            checked: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Time/enabled",true)
            onCheckedChanged: {
                radiusSlider.enabled = swUseLocation.checked;
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
        TumblerButton{
            id: btnTime1
            anchors {
                left: parent.left
                top: swUseTimeNot.bottom
            }
            width: 200
            text: objQSettings.getValue("/rules/" + tabSettings.selectedRuleName + "/Time/TIME1","set time 1")
            onClicked: {
                appWindow.pageStack.push(Qt.resolvedUrl("TimePicker.qml"),
                  {time: 1} );
            }
            style: TumblerButtonStyle {}
        }
        TumblerButton{
            id: btnTime2
            anchors {
                left: btnTime1.right
                top: swUseTimeNot.bottom
            }
            width: 200
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
                var errorString = "";
                if (txtRuleName.text.length < 1)
                {
                    errorString = "Rule name is blank or not valid"
                    showError(errorString);
                    return;
                }

                //check if name changed and remove old one if so
                if (tabSettings.selectedRuleName != txtRuleName.text)
                {
                    objQSettings.remove("/rules/" + tabSettings.selectedRuleName)
                }

                objQSettings.setValue("/rules/" + txtRuleName.text + "/Actions/Profile/enabled",swChangeProfile.checked);
                //set selected profile

                objQSettings.setValue("/rules/" + txtRuleName.text + "/Location/enabled",swUseLocation.checked);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Location/NOT",swUseLocationNot.checked);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Location/RADIUS",cbRadius.value);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Location/LATITUDE",txtLocLatitude.text);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Location/LONGITUDE",txtLocLongitude.text);

                objQSettings.setValue("/rules/" + txtRuleName.text + "/Time/enabled",swUseTime.checked);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Time/NOT",swUseTimeNot.checked);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Time/TIME1",btnTime1.text);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Time/TIME2",btnTime2.text);

                objQSettings.setValue("/rules/" + txtRuleName.text + "/Calendar/enabled",swUseCalendar.checked);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Calendar/NOT",swUseCalendarNOT.checked);
                objQSettings.setValue("/rules/" + txtRuleName.text + "/Calendar/KEYWORDS",txtCalendarKeywords.text);

                txtLocLongitude.closeSoftwareInputPanel(); // is this my job? i am the manager of keyboards :(
                appWindow.pageStack.pop()
                resetList();
            }
        }
    }
}
