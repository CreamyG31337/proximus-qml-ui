import QtQuick 1.1
import com.nokia.meego 1.0

Page {
 //   id: statusPage
    tools: commonTools

    Label {
        id: label
        anchors.centerIn: parent
        text: qsTr("status page")
        visible: false
    }

    Button{
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: label.bottom
            topMargin: 10
        }
        text: qsTr("status page")
        onClicked: label.visible = true
    }
//    TabBarLayout {
//        id: tabBarLayout
//        anchors { left: parent.left; right: parent.right; top: parent.top }
//        TabButton { tab: tab1content; text: "Tab 1" }
//        TabButton { tab: tab2content; text: "Tab 2" }
//        TabButton { tab: tab3content; text: "Tab 3" }
//    }
    // define a blank tab group so we can add the pages of content later

}
