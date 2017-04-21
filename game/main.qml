import QtQuick 2.5
import QtQuick.Window 2.2


Window {

    id: game
    visible: true
    width: 1600
    height: 600
    title: qsTr("Run2.0")
    property bool initialized: false
    property int globalX: bg.x
    property int collision: 0
    property int count: 0

    signal boomSignal()
    onBoomSignal: {collision++
        obstacles.clear()
        if(collision==3){
            bg.stop()
        }

    }
    Background {
        id: bg
    }
    Text{
        x: 1200
        text: "Cтолкновений: "+collision
        color: "white"
        font.pixelSize: 30
    }
    ListModel {
        id: obstacles
    }

    Repeater {
        model: obstacles
        Obstacle {
            x: ox+ globalX
            y: oy
            playerX: player.x
            playerY: player.y
            playerW: player.width
            playerH: player.height

            Component.onCompleted: {
                boomSignal.connect(player.boomSignal)
                boomSignal.connect(game.boomSignal)
//                mArea.connect(game.mArea)
            }
        }
    }
    Timer{
        running: true
        repeat: true
        id: rocketT
        interval: 1000
        onTriggered: {obstacles.append({"ox": count*300+1800 , "oy": player.y} ), count+=1}
    }


    Player {
        x: 100
        id: player
        y: game.height/2
        width: 50
        height: 50
        maxY: game.height - height
        collision: game.collision


    }

    Text {
        text: -globalX
        color: "white"
        font.pixelSize: 24
    }

    MouseArea {
        id:mArea
        anchors.fill: parent
        onClicked: {
            bg.stop()

        }
    }

}
