import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow
    //initialPage: Qt.resolvedUrl("StatusPage.qml");
//    initialPage: SettingsPage { }
//    initialPage: StatusPage { }
    initialPage: mainPage
    MainPage {
        id: mainPage
    }

    Component.onCompleted: {
        //tabGroup.currentTab = tabStatus;
    }

    ToolBarLayout {
        id: commonTools
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
