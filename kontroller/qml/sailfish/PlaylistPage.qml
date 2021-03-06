import QtQuick 2.0
import harbour.eu.tgcm 1.0
import Sailfish.Silica 1.0
import "."
Page{
    id:main

    property alias playlistId : service.playlistId
    property alias playlistType: service.playlistType
    property alias playlistPosition: service.playlistPosition

    onStatusChanged: {
        if(status === PageStatus.Active)
            service.refresh()
    }

    PlaylistControl
    {
        id :service
    }

    SilicaListView {
        header:PageHeader {
            title:qsTr("Current playlist");
        }

        id:thelist
        anchors.fill:parent
        model: service.items
        clip:true
        spacing:1
        currentIndex: service.playlistPosition

        delegate : ListItem {
            contentHeight: Theme.itemSizeMedium
            highlighted: service.playlistPosition === index
            IconButton {
                id:switchTo
                icon.source: "image://theme/icon-m-enter-next"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                onClicked: activateItem(model)
            }

            Label {
                id : theText
                text: model.label
                elide: Text.ElideRight
                clip:true
                anchors.left: switchTo.right
                anchors.right: remove.left
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }
            IconButton {
                id: remove
                icon.source: "image://theme/icon-m-remove"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                onClicked: service.removeElement(model.index)
            }
        }
    }

    function activateItem(modelItem)
    {
        service.switchToItem(modelItem.index)
    }

    function clear()
    {
        service.clearPlaylist()
    }


}

