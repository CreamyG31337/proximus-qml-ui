import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow
    initialPage: mainPage
    MainPage {
        id: mainPage
         anchors.top: statusBar.bottom
    }
    StatusBar{
        id: statusBar
    }

    Component.onCompleted: {
        //tabGroup.currentTab = tabStatus;
    }

    ToolBarLayout {
        id: commonTools
        anchors {
            left: parent.left;
            right: parent.right;
            bottom: parent.bottom
        }
        ToolIcon{  iconId: "toolbar-back";
            onClicked: { myMenu.close(); pageStack.pop(); } }
        ButtonRow {
            style: TabButtonStyle { }
            TabButton {
                tab: tabStatus
                text: "Status"
            }
            TabButton {
                tab: tabSettings
                text: "Settings"
            }
        }
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }
    TabGroup {
        id: tabGroup
        currentTab: tabStatus
        anchors {
        left: parent.left;
        right: parent.right;
        top: statusBar.bottom;
        bottom: parent.bottom
        }
        // define the content for tab 1
        StatusPage {
            id: tabStatus
            anchors { fill: tabGroup;}
        }
        // define the content for tab 2
        SettingsPage {
            id: tabSettings
            anchors { fill: tabGroup;}
        }
    }
    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem { text: qsTr("Sample menu item") }
        }
    }
}
