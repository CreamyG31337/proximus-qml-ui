import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: tabStatus
    tools:     commonTools

    TextArea {
        id: txtLog
        text: qsTr("Welcome to Proximus")
        anchors {top: parent.top; left: parent.left; right: parent.right;}
        readOnly: true;
    }
    Component.onCompleted: {
        txtLog.text += "\n" + objProximusUtils.isServiceRunning();
    }

//    Rectangle{
//        color: "red"
//        anchors {
//            top: txtLog.bottom
//            left: parent.left
//            right: parent.right
//        }
//        height: tabStatus.height - 155
//    }
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
