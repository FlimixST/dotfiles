import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.common.widgets
import Qt5Compat.GraphicalEffects

ContentPage {
    forceWidth: true

    ContentSection {
        icon: "box"
        title: Translation.tr("Distro")
        
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            Image {
                width: 80
                height: 80
                source: Qt.resolvedUrl(Quickshell.shellPath(`assets/icons/${SystemInfo.logo}-symbolic.svg`))
                sourceSize.width: 80
                sourceSize.height: 80
                fillMode: Image.PreserveAspectFit
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                StyledText {
                    text: SystemInfo.distroName
                    font.pixelSize: Appearance.font.pixelSize.title
                }
                StyledText {
                    font.pixelSize: Appearance.font.pixelSize.normal
                    text: SystemInfo.homeUrl
                    textFormat: Text.MarkdownText
                    onLinkActivated: (link) => {
                        Qt.openUrlExternally(link)
                    }
                    PointingHandLinkHover {}
                }
            }
        }

        Flow {
            Layout.fillWidth: true
            spacing: 5

            RippleButtonWithIcon {
                materialIcon: "auto_stories"
                mainText: Translation.tr("Documentation")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.documentationUrl)
                }
            }
            RippleButtonWithIcon {
                materialIcon: "support"
                mainText: Translation.tr("Help & Support")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.supportUrl)
                }
            }
            RippleButtonWithIcon {
                materialIcon: "bug_report"
                mainText: Translation.tr("Report a Bug")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.bugReportUrl)
                }
            }
            RippleButtonWithIcon {
                materialIcon: "policy"
                materialIconFill: false
                mainText: Translation.tr("Privacy Policy")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.privacyPolicyUrl)
                }
            }
        }
    }
    ContentSection {
        icon: "folder_managed"
        title: Translation.tr("Dotfiles")

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            Image {
                width: 80
                height: 80
                source: `file:///${FileUtils.trimFileProtocol(Directories.home)}/.local/share/icons/illogical-impulse.svg`
                sourceSize.width: 80
                sourceSize.height: 80
                fillMode: Image.PreserveAspectFit
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                StyledText {
                    text: Translation.tr("illogical-impulse")
                    font.pixelSize: Appearance.font.pixelSize.title
                }
                StyledText {
                    text: "https://github.com/end-4/dots-hyprland"
                    font.pixelSize: Appearance.font.pixelSize.normal
                    textFormat: Text.MarkdownText
                    onLinkActivated: (link) => {
                        Qt.openUrlExternally(link)
                    }
                    PointingHandLinkHover {}
                }
            }
        }

        Flow {
            Layout.fillWidth: true
            spacing: 5

            RippleButtonWithIcon {
                materialIcon: "auto_stories"
                mainText: Translation.tr("Documentation")
                onClicked: {
                    Qt.openUrlExternally("https://end-4.github.io/dots-hyprland-wiki/en/ii-qs/02usage/")
                }
            }
            RippleButtonWithIcon {
                materialIcon: "adjust"
                materialIconFill: false
                mainText: Translation.tr("Issues")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/end-4/dots-hyprland/issues")
                }
            }
            RippleButtonWithIcon {
                materialIcon: "forum"
                mainText: Translation.tr("Discussions")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/end-4/dots-hyprland/discussions")
                }
            }
            RippleButtonWithIcon {
                materialIcon: "favorite"
                mainText: Translation.tr("Donate")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/sponsors/end-4")
                }
            }
        }
    }
    ContentSection {
        icon: "person"
        title: Translation.tr("About me")

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            Item {
                width: 80
                height: 80
                Image {
                    id: avatarImg
                    anchors.fill: parent
                    source: "https://github.com/FlimixST.png"
                    sourceSize.width: 80
                    sourceSize.height: 80
                    fillMode: Image.PreserveAspectCrop
                }
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: 80
                        height: 80
                        radius: 12
                    }
                }
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                StyledText {
                    text: "FlimixST"
                    font.pixelSize: Appearance.font.pixelSize.title
                }
                StyledText {
                    text: Translation.tr("Forked and stripped end-4's dots")
                    font.pixelSize: Appearance.font.pixelSize.normal
                    color: Appearance.colors.colSubtext
                    lineHeight: 1.4
                }
            }
        }

        Flow {
            Layout.fillWidth: true
            spacing: 5

            RippleButtonWithIcon {
                materialIcon: "code"
                mainText: Translation.tr("Dotfiles")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/FlimixST/dotfiles")
                }
            }
            RippleButtonWithIcon {
                materialIcon: "code"
                mainText: "Git"
                onClicked: {
                    Qt.openUrlExternally("https://github.com/FlimixST")
                }
            }
            RippleButtonWithIcon {
                materialIcon: "language"
                mainText: "flimixst.dev"
                onClicked: {
                    Qt.openUrlExternally("https://flimixst.dev")
                }
            }
        }
    }
}
