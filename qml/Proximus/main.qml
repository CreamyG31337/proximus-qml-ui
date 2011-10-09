import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    StatusBar{
        id: statusbar
    }

    Component.onCompleted: {
        tabGroup.currentTab = tabStatus;
    }

    ToolBar {
        id: commonTools
        anchors.bottom: parent.bottom
        tools: toolbarLayout1
    }

    ToolBarLayout {
        id: toolbarLayout1
        ToolIcon{  iconId: "toolbar-back";
            onClicked: { myMenu.close(); pageStack.pop(); } }
        ButtonRow {
            TabButton {
                id: tabBtnStatus
                tab: tabStatus
                text: "Status"
            }
            TabButton {
                id: tabBtnSettings
                tab: tabSettings
                text: "Settings"
            }
        }
    }
    TabGroup {
        id: tabGroup
        anchors {
        bottom: commonTools.top
        left: parent.left
        right: parent.right
        }
        // define the content for tab 1
        StatusPage {
            id: tabStatus
            anchors { fill: parent;}
        }
        // define the content for tab 2
        SettingsPage {
            id: tabSettings
            anchors { fill: parent;}
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
