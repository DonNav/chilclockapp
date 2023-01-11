import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page{
    property date date_page : new Date();
    property string titlePage : "Titre"
    property color bk_color : background_color.color

    id: pageConfiguration

    background: Rectangle {
        anchors.fill: parent
        color: bk_color
    }
    // Titre
    Text{
        id: title
        text: titlePage
        anchors.top : parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: parent.height / 10
        font.family: "Helvetica"
        font.pointSize: sp(36)
        color: "black"
    }

    // Colonne de la soustraction de minute
    Column{
        id: columnLeft
        anchors.top : title.bottom
        anchors.left: parent.left
        anchors.topMargin: parent.height / 10
        width: parent.width / 3

        Text{
            text: "- 1 min"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Helvetica"
            font.pointSize: sp(24)
            color: "black"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    date_page = calculnewdate(date_page, -1);
                }
            }
        }

        Text{
            text: "- 5 min"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Helvetica"
            font.pointSize: sp(24)
            color: "black"


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    date_page = calculnewdate(date_page, -5);
                }
            }
        }

        Text{
            text : "- 15 min"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Helvetica"
            font.pointSize: sp(24)
            color: "black"


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    date_page = calculnewdate(date_page, -15);
                }
            }
        }
    }
    // Colonne de l'heure
    Column{
        id: columnCenter
        anchors.top : title.bottom
        anchors.left: columnLeft.right
        anchors.topMargin: parent.height / 10
        width: parent.width / 3

        Text{

            id: textheure
            text: date_page.toLocaleTimeString("hh:mm");
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Helvetica"
            font.pointSize: sp(48)
            color: "black"

        }
    }
    //Colonne d'ajout minute
    Column{
        id: columnRight
        anchors.top : title.bottom
        anchors.left: columnCenter.right
        anchors.topMargin: parent.height / 10
        width: parent.width / 3
        Text{
            text: "+ 1 min"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Helvetica"
            font.pointSize: sp(24)
            color: "black"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    date_page = calculnewdate(date_page, 1);
                }
            }

        }

        Text{
            text: "+ 5 min"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Helvetica"
            font.pointSize: sp(24)
            color: "black"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    date_page = calculnewdate(date_page, 5);
                }
            }
        }

        Text{
            text : "+ 15 min"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Helvetica"
            font.pointSize: sp(24)
            color: "black"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    date_page = calculnewdate(date_page, 15);
                }
            }
        }

    }

    // Suivant


}
