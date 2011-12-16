import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2

Page{
    id: mapPage

    property double longitudeReq
    property double latitudeReq
    property int  radiusSize: 500
    property variant ruleCircleObj

//    Component{
//        id: ruleCircle
//        MapCircle {}
//    }

//    function putRuleCircle(){
//       // var ruleCircleObj = ruleCircle.createObject(mapPage);
//        map.removeMapObject(ruleCircleObj)
//        ruleCircleObj = ruleCircle.createObject(mapPage);
//        ruleCircleObj.border.color = "orange" //stupid read only properties cause this mess
//        ruleCircleObj.border.width = 4
//        ruleCircleObj.radius = radiusSize
//        ruleCircleObj.center = map.center
//        ruleCircleObj.z = 55 //doesn't work
//        ruleCircleObj.opacity = 0.5 //why the **** doesn't this work either?
//        ruleCircleObj.center = ruleCoordForCircleObj
//        map.addMapObject(ruleCircleObj)
//    }

    Component.onCompleted: {
      //  putRuleCircle();
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
//    Coordinate{
//        id: ruleCoordForCircleObj
//        altitude: 0;
//        longitude: longitudeReq;
//        latitude: latitudeReq;
//    }

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
            radius: radiusSize //this is too big when you zoom in
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

