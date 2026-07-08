import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.services

ContentPage {
    forceWidth: true

    ContentSection {
        icon: "sports_esports"
        title: Translation.tr("Game Mode")

        NoticeBox {
            Layout.fillWidth: true
            text: Translation.tr("When a game window is focused, switches Hyprland to a restricted submap so keybinds don't interfere with gameplay.")
        }

        ConfigRow {
            uniform: true
            ConfigSwitch {
                buttonIcon: "power_settings_new"
                text: Translation.tr("Enable")
                checked: Config.options.gamemode.enable
                onCheckedChanged: Config.options.gamemode.enable = checked;
                StyledToolTip {
                    text: Translation.tr("Watches active window class and automatically switches to menu submap when a game is focused")
                }
            }

        }

        ContentSubsection {
            title: Translation.tr("Game list")

            ConfigRow {
                MaterialTextArea {
                    id: newGameField
                    Layout.fillWidth: true
                    placeholderText: Translation.tr("Add process (e.g. steam, osu!, lutris)")
                    wrapMode: TextEdit.NoWrap
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                            event.accepted = true;
                    }
                }
                RippleButton {
                    implicitWidth: 80
                    Layout.fillHeight: true
                    enabled: newGameField.text.trim() !== ""
                    colBackground: Appearance.colors.colLayer2
                    onClicked: {
                        var game = newGameField.text.trim();
                        if (game) {
                            var src = Config.options.gamemode.games;
                            var arr = [];
                            arr.push(game);
                            if (src) for (var i = 0; i < src.length; i++) arr.push(src[i]);
                            Config.options.gamemode.games = arr;
                            newGameField.text = "";
                        }
                    }
                    contentItem: RowLayout {
                        spacing: 6
                        MaterialSymbol {
                            text: "add"
                            iconSize: 20
                            Layout.alignment: Qt.AlignVCenter
                        }
                        StyledText {
                            text: Translation.tr("Add")
                            font.pixelSize: Appearance.font.pixelSize.small
                            color: Appearance.colors.colOnSecondaryContainer
                            Layout.alignment: Qt.AlignVCenter
                        }
                    }
                }
            }

            Repeater {
                model: Config.options.gamemode.games
                delegate: ConfigRow {
                    Layout.fillWidth: true
                    Layout.minimumHeight: 40

                    MaterialSymbol {
                        text: "sports_esports"
                        iconSize: 20
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 8
                        color: Appearance.colors.colOnSurface
                    }
                    StyledText {
                        text: modelData
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        font.pixelSize: Appearance.font.pixelSize.normal
                        elide: Text.ElideRight
                    }
                    RippleButton {
                        implicitWidth: 36
                        implicitHeight: 36
                        Layout.alignment: Qt.AlignVCenter
                        Layout.rightMargin: 4
                        buttonRadius: Appearance.rounding.full
                        colBackground: Appearance.colors.colLayer2
                        onClicked: {
                            var arr = Config.options.gamemode.games.filter((v, i) => i !== index);
                            Config.options.gamemode.games = arr;
                        }
                        contentItem: MaterialSymbol {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            text: "close"
                            iconSize: 20
                        }
                    }
                }
            }
        }
    }
}
