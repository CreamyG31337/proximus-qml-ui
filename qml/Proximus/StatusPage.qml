import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: tabSettings
    tools: commonTools
//anchors done from main.qml

//    Label {
//        id: label
//        anchors.centerIn: parent
//        text: qsTr("status page")
//        visible: true
//    }
    TextArea {
        id: txtLog
        text: qsTr("Welcome to Proximus\n Log goes here")
        anchors {top: parent.top; left: parent.left; right: parent.right;}
        readOnly: true;
    }

//    Button{
//        anchors {
//            horizontalCenter: parent.horizontalCenter
//            top: txtLog.bottom
//            topMargin: 10
//        }
//        text: qsTr("status page")
//        onClicked: label.visible = true
//    }
}
