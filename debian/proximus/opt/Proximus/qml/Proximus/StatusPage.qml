import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: tabStatus
    tools:     commonTools

    TextArea {
        id: txtLog
        text: qsTr("Welcome to Proximus\n Log goes here")
        anchors {top: parent.top; left: parent.left; right: parent.right;}
        readOnly: true;
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
