import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2

Page{
    id: mapPage

    property double longitudeReq
    property double latitudeReq

    PositionSource {
        id: myPositionSource
        active: true
        updateInterval: 1000
       // onPositionChanged: console.log(position.coordinate)
    }
    Coordinate{
        id: ruleCoord
        altitude: 0;
        longitude: longitudeReq;
        latitude: latitudeReq;
    }

    Button{
        z: 2
        id: btnGotoMe
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        width: 120
        text: qsTr("Find Me")
        //onClicked: map.center = myPositionSource.position.coordinate
        onClicked: map.center = ruleCoord
    }

    Button{
        z: 2
        id: btnSaveLoc
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        width: 100
        text: qsTr("Save")
        onClicked: appWindow.pageStack.pop()
    }

    Map {
        z: 1
        id: map
        plugin : Plugin {name : "nokia"}
        anchors.fill: parent
        size.width: parent.width
        size.height: parent.height
        zoomLevel: 10
        center: ruleCoord


//            MapObjectView {
//                id: allLandmarks
//                model: landmarkModelAll
//                delegate: Component {
//                    MapCircle {
//                        color: "green"
//                        radius: 1000
//                        center: Coordinate {
//                            latitude: landmark.coordinate.latitude
//                            longitude: landmark.coordinate.longitude
//                        }
//                    }
//                }
//            }

        MapCircle {
            id: myPosition
            color: "green"
            radius: 1000
            center: myPositionSource.position.coordinate
        }
    }
}

