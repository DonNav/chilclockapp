import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {
    id: configurationPage
    width: mainView.width
    height: mainView.height
    background: Rectangle {
        id: background_color
        anchors.fill: parent
        color: yellow_color
    }


    SwipeView {
        id: configurationSwipe
        anchors.fill: parent
        currentIndex: 0
        interactive: true

        ComposantPageConfiguration{
            date_page: date_nuit
            titlePage: "Début de la nuit :"
            bk_color: blue_color

            onDate_pageChanged: {
                date_nuit = date_page
            }
        }

        ComposantPageConfiguration{
            date_page: date_aube
            titlePage: "Début de l'aube :"
            bk_color : orange_color

            onDate_pageChanged: {
                date_aube = date_page
            }
        }

        ComposantPageConfiguration{
            date_page: date_jour
            titlePage: "Début du jour :"
            bk_color: yellow_color

            onDate_pageChanged: {
                date_jour = date_page
            }
        }

        ComposantPageConfiguration{
            date_page: date_deb_sieste
            titlePage: "Début de la sieste :"
            bk_color: blue_color

            onDate_pageChanged: {
                date_deb_sieste = date_page
            }
        }

        ComposantPageConfiguration{
            date_page: date_fin_sieste
            titlePage: "Fin de la sieste :"
            bk_color: blue_color

            onDate_pageChanged: {
                date_fin_sieste = date_page
            }

        }

        // Page de gestion de la veille
        Page{
            id: pageConfigurationVeille

            background: Rectangle {
                anchors.fill: parent
                color: background_color.color
            }

            Text{
                id: pageCongiurationavancee
                text: "Configuration finale : "
                anchors.top : parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Helvetica"
                font.pointSize: sp(36)
                color: "black"
            }

            Row{
                id: rowConfiurationAvancee
                anchors.top : pageCongiurationavancee.bottom
                anchors.left: parent.left
                anchors.topMargin: parent.height / 10
                anchors.leftMargin: parent.width / 10
                Column{
                    id: columnTitleConfigurationAvancee

                    Text{
                        font.family: "Helvetica"
                        font.pointSize: sp(30)
                        color: "black"
                        text: "Mode veilleuse :"
                    }
                    Text{
                        font.family: "Helvetica"
                        font.pointSize: sp(16)
                        color: "black"
                        text: "En mode veilleuse, l'écran reste en permanence allumé. \nNécessite d'être branché sur secteur. \nSinon, l'écran s'éteint après 1 minutes d'inactivité"
                    }
                }

            Column{
                id: columnswitchbutton

                Switch {
                    id: buttonveilleuse
                    checked: is_veilleuse
                    indicator: Rectangle {
                        implicitWidth: 48
                        implicitHeight: 26
                        x: buttonveilleuse.leftPadding
                        y: parent.height / 2 - height / 2
                        radius: 13
                        color: buttonveilleuse.checked ? "#17a81a" : "#ffffff"
                        border.color: buttonveilleuse.checked ? "#17a81a" : "#cccccc"

                        Rectangle {
                            x: buttonveilleuse.checked ? parent.width - width : 0
                            width: 26
                            height: 26
                            radius: 13
                            color: buttonveilleuse.down ? "#cccccc" : "#ffffff"
                            border.color: buttonveilleuse.checked ? (buttonveilleuse.down ? "#17a81a" : "#21be2b") : "#999999"
                        }
                    }

                        contentItem: Text {
                            text: buttonveilleuse.text
                            font: buttonveilleuse.font
                            opacity: enabled ? 1.0 : 0.3
                            color: buttonveilleuse.down ? "#17a81a" : "#21be2b"
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: buttonveilleuse.indicator.width + buttonveilleuse.spacing
                        }

                       onCheckedChanged: {
                           is_veilleuse: buttonveilleuse.checked
                       }
                   }

//                TextField {
//                    id: temps_avant_veille_textField

//                    width: parent.width * 0.70
//                    height: parent.height * 0.6

//                    placeholderText: qsTr("min avant veille")
//                    text: min_veille
//                    font.bold: true

//                    inputMethodHints: Qt.ImhDigitsOnly
//                }
            }
        }

     }


        onCurrentIndexChanged: {
            if  (currentIndex === count - 1 )
                fin_configuration.visible = true;
            else
                fin_configuration.visible = false;
        }
    }


    PageIndicator {
        id: indicator

        count: configurationSwipe.count
        currentIndex: configurationSwipe.currentIndex

        anchors.bottom: configurationSwipe.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Image{
        id: fin_configuration
        source:  "qrc:/ChildClockApp/src/button_valider.png"
        anchors.bottom: indicator.top
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false

        height: mainView.height / 10
        width: mainView.height / 10
        fillMode: Image.PreserveAspectFit
        anchors.bottomMargin: 0

        MouseArea{
            anchors.fill: parent
            onClicked: {
                stackView.push(clockpage)
                footer_button.visible = true;
            }
        }
    }




    function calculnewdate(dateToChange, mintoAdd){
        var temp_heure = parseFloat(dateToChange.getHours());
        var temp_min =   parseFloat(dateToChange.getMinutes()) + mintoAdd;

        if (temp_min < 0){
            temp_min = 60 + temp_min;
            temp_heure -= 1;
        }
        if (temp_min > 59){
            temp_min = temp_min % 60;
            temp_heure += 1;
        }

        if (temp_heure > 23)
            temp_heure = temp_heure % 24
        else if ( temp_heure < 0)
             temp_heure = 24 + temp_heure

        if (temp_min < 10)
            temp_min = "0"+temp_min;
        if (temp_heure < 10)
            temp_heure = "0"+temp_heure;
       // console.log(temp_heure+":"+temp_min)
        return Date.fromLocaleString(Qt.locale(), "01/01/1900 "+temp_heure+":"+temp_min, "dd/MM/yyyy hh:mm")
    }
}
