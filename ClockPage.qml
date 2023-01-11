import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {
    property alias timerClock : timerClock
    width: mainView.width
    height: mainView.height
    background: Rectangle {
        id: background_color
        anchors.fill: parent
        color: current_color
    }

    Image {
        id: central_image
        source:  day_image_path
        anchors.top: mainView.top
        anchors.left: mainView.left
        anchors.right: mainView.right
        height: mainView.height / 2
        width: mainView.height / 2
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

    }
    Text{
        id: time
        anchors.top : central_image.bottom
        anchors.left: mainView.left
        anchors.right: mainView.right
        anchors.horizontalCenter: parent.horizontalCenter
        text : currentDate.toLocaleTimeString("hh:mm");
        font.family: "Helvetica"
        font.pointSize: sp(48)
        color: "black"
    }

    MouseArea{
        id: mouseAreaVeille
        enabled: false
        anchors.fill: parent
        onClicked: {
            console.log("touch")
            calculAffichage();
            timerClock.restart();
            if(!is_veilleuse)
                timerVeille.restart();
            mouseAreaVeille.enabled = false;
            mainView.footer.visible = true;

        }
    }

    Timer {
        id: timerVeille
        interval: min_veille * 60000;
        running: !is_veilleuse;
        repeat: true
        onTriggered: {
            if (!is_veilleuse){
                mouseAreaVeille.enabled = true;
                timerClock.stop();
                timerVeille.stop();
                current_color = "#000";
                mainView.footer.visible = false;
            }

        }
    }

    Timer {
        id: timerClock
        interval: 60000;
        running: true;
        repeat: true
        onTriggered: {
             calculAffichage();
        }
    }
    Component.onCompleted: {
         calculAffichage();
    }

    function calculAffichage(){
        currentDate = new Date();
        time.text = currentDate.toLocaleTimeString("hh:mm");

        current_temp_date = Date.fromLocaleString(Qt.locale(), "01/01/1900 "+  currentDate.toLocaleTimeString("hh:mm"), "dd/MM/yyyy hh:mm")

        // C'est la nuit :
        if (current_temp_date >= date_nuit || current_temp_date < date_aube)
        {
            central_image.source = night_image_path;
            current_color = blue_color;
        }
        else if (current_temp_date >= date_aube && current_temp_date < date_jour){
            // c'est l'aube
            central_image.source = dawn_image_path;
            current_color = orange_color;
        }
        else if (current_temp_date >= date_deb_sieste && current_temp_date < date_fin_sieste){
            // c'est la sieste
            central_image.source = sieste_image_path;
            current_color = blue_color;
        }
        else {
            // c'est le jour sinon
             central_image.source = day_image_path;
            current_color = yellow_color;
        }
//        background_color.color = current_color;
//        footer_button.color = current_color;
    }
}
