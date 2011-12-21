import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2
import com.nokia.extras 1.1

Page{
    id: mapPage

    property double longitudeReq
    property double latitudeReq
    property int  radiusSize: 500
    property variant ruleCircleObj

    Component.onCompleted: {
      //  putRuleCircle();
        instructionMessageBanner.text = "Drag the map to set target area.\nYou are the green circle.\nOrange circle is target radius.";
        instructionMessageBanner.show();
    }

    InfoBanner{
        id: instructionMessageBanner
        z: 99
        timerShowTime: 5000 //5s
    }


    PositionSource {
        id: myPositionSource
        active: true
        updateInterval: 1500
        onPositionChanged: {
            //console.log(position.coordinate)
            //ruleCoordForCircleObj = map.toCoordinate(Qt.point(map.width / 2, map.height / 2)); //map.center;
            //putRuleCircle();
        }        
    }


    Coordinate{
        id: ruleCoordForMap
        altitude: 0;
        longitude: longitudeReq;
        latitude: latitudeReq;
    }

    Button{
        z: 88
        opacity: .7
        id: btnGotoMe
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        width: 120
        text: qsTr("Find Me")

        onClicked: {
            map.center.longitude = myPositionSource.position.coordinate.longitude;
            map.center.latitude = myPositionSource.position.coordinate.latitude;
            myPosition.radius = myPositionSource.position.horizontalAccuracy  //15
            map.zoomLevel = 16
        }
    }

    Button{
        z: 88
        opacity: .7
        id: btnSaveLoc
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        width: 100
        text: qsTr("Save")
        onClicked: {
            appWindow.pageStack.pop()
            appWindow.pageStack.currentPage.setCoord(map.center.latitude,map.center.longitude)
            //that logic is so fu*ked up, i wish qml just had pointers.
        }
    }

    Map {
        z: 1
        id: map
        plugin : Plugin {name : "nokia"}
        anchors.fill: parent
        size.width: parent.width
        size.height: parent.height
        zoomLevel: 10
        center: ruleCoordForMap //if this ever changes the stupid map goes there automatically?

        MapCircle {
            id: myPosition
            color: Qt.rgba(0, 1, 0, 0.5)
            border.color: Qt.rgba(0, 1, 0, 0.7)
            radius: 500 //this is too big when you zoom in
            center: myPositionSource.position.coordinate
        }

        MapCircle {
            id: ruleCircle
            color: Qt.rgba(1, 0.3, 0, 0.5)
            border.color: Qt.rgba(1, 0.3, 0, 0.7)
            radius: radiusSize
            center: map.center
        }
    }

    PinchArea {
        id: pincharea
        property double __oldZoom
        anchors.fill: parent

        function calcZoomDelta(zoom, percent) {
            return zoom + Math.log(percent)/Math.log(2)
        }

        onPinchStarted: {
            __oldZoom = map.zoomLevel
        }

        onPinchUpdated: {
            map.zoomLevel = calcZoomDelta(__oldZoom, pinch.scale)
        }

        onPinchFinished: {
            map.zoomLevel = calcZoomDelta(__oldZoom, pinch.scale)
            //console.debug(map.zoomLevel)
            if (map.zoomLevel > 13)
                myPosition.radius = myPositionSource.position.horizontalAccuracy
            else
                myPosition.radius = 500
        }
    }

    MouseArea {
        id: mousearea

        property bool __isPanning: false
        property int __lastX: -1
        property int __lastY: -1

        anchors.fill : parent

        onPressed: {
            __isPanning = true
            __lastX = mouse.x
            __lastY = mouse.y
        }

        onReleased: {
           __isPanning = false

        }

        onPositionChanged: {
            if (__isPanning) {
               var dx = mouse.x - __lastX
               var dy = mouse.y - __lastY
               map.pan(-dx, -dy)
               __lastX = mouse.x
               __lastY = mouse.y
            }
        }

        onCanceled: {
            __isPanning = false;
        }
    }
}

