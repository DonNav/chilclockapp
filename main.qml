import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

import QtQml 2.0

ApplicationWindow {

    signal keyReturn()

    property alias clockpage: mainPage

    property color yellow_color : "#fff85c"
    property color orange_color : "#d5a021"
    property color blue_color : "#001a65"

    property color current_color: yellow_color

    property string day_image_path : "qrc:/ChildClockApp/src/day_img.png"
    property string dawn_image_path : "qrc:/ChildClockApp/src/dauwn_img.png"
    property string night_image_path : "qrc:/ChildClockApp/src/sleeping_img.png"
    property string sieste_image_path : "qrc:/ChildClockApp/src/sieste_img.png"

    property bool is_veilleuse : false
    property real min_veille : 1

    property date currentDate: new Date();
    property date current_temp_date: new Date();
    property string dateString

    property date date_aube : Date.fromLocaleString(Qt.locale(), "06:30", "hh:mm")
    property date date_jour : Date.fromLocaleString(Qt.locale(), "07:30", "hh:mm")
    property date date_deb_sieste : Date.fromLocaleString(Qt.locale(), "13:00", "hh:mm")
    property date date_fin_sieste : Date.fromLocaleString(Qt.locale(), "15:00", "hh:mm")
    property date date_nuit : Date.fromLocaleString(Qt.locale(), "20:00", "hh:mm")


    id: mainView
    width: screenSize.width
    height: screenSize.height
    visible: true
    title: qsTr("Child Clock")
    visibility: Window.FullScreen


    background: Rectangle {
        anchors.fill: parent
        color: current_color
    }



    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainPage
    }

    footer:     Rectangle{
        id: footer_button
        height: mainView.height / 10
        width: mainView.width
        anchors.bottom: mainView.bottom
        color: current_color
        Image {
            id: conf_button
            source:  "qrc:/ChildClockApp/src/configuration_img.png"
            anchors.bottom: mainView.bottom
            anchors.left: mainView.left
            height: mainView.height / 10
            width: mainView.height / 10
            fillMode: Image.PreserveAspectFit

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    stackView.push(mainConfigurationPage)
                    footer_button.visible = false;
                }
            }
        }
    }

    Component{
        id: mainPage
        ClockPage{
        }

    }

    Component{
        id: mainConfigurationPage
        ConfigurationPage{
        }

    }



    // Capture de l'event touche BACK et 'alt + leftArrow'
    // Envoie d'un signal lors de la détection
    Component.onCompleted: {
        contentItem.Keys.released.connect(function(event) {
            if (event.key === Qt.Key_Back || event.matches(StandardKey.Back)) {
                event.accepted = true;
                keyReturn();
            }
        })
    }

    //Gestion du signal de la touche BACK
    Connections{
        target: mainView
        function onKeyReturn(){
            // Ouverture de la Popup de confirmation
            // Si c'est déjà le cas, fermeture de l'application
            if(closePopup.opened){
                mainView.close();
            }else{
                closePopup.open();
            }
        }
    }

    // Timer de mise en veille de l'écran. Régler à 5min.



    // Gestion des dimensions en fonction des écrans
    function dp(pixel){
        return  Math.ceil((pixel * 160 ) / screenDpi)
    }

    // Gestion des dimensions de text en fonction des écrans
    function sp(pixel){
        return  Math.ceil((pixel * 160 ) / textDpi)
    }

}
