pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Polkit

Singleton {
    id: root
    property alias agent: polkitAgent
    property alias active: polkitAgent.isActive
    property alias flow: polkitAgent.flow
    property bool interactionAvailable: false
    property string cleanMessage: {
        if (!root.flow) return "";
        return root.flow.message.endsWith(".")
            ? root.flow.message.slice(0, -1)
            : root.flow.message
    }
    property string cleanPrompt: {
        const inputPrompt = PolkitService.flow?.inputPrompt.trim() ?? "";
        const cleanedInputPrompt = inputPrompt.endsWith(":") ? inputPrompt.slice(0, -1) : inputPrompt;
        const usePasswordChars = !PolkitService.flow?.responseVisible ?? true
        return cleanedInputPrompt || (usePasswordChars ? Translation.tr("Password") : Translation.tr("Input"))
    }

    function cancel() {
        root.flow.cancelAuthenticationRequest()
    }

    function submit(string) {
        root.flow.submit(string)
        root.interactionAvailable = false
    }

    Process {
        id: polkitCheck
        command: ["bash", "-c", "test -f /etc/polkit-1/rules.d/10-nopasswd.rules && echo 'nopasswd' || echo 'needs_agent'"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                if (data.trim() === "nopasswd") {
                    polkitAgent.noOp = true;
                }
            }
        }
    }

    Connections {
        target: root.flow
        function onAuthenticationFailed() {
            root.interactionAvailable = true;
        }
    }

    PolkitAgent {
        id: polkitAgent
        property bool noOp: false
        onAuthenticationRequestStarted: {
            if (noOp) {
                polkitAgent.flow.submit("")
                return
            }
            root.interactionAvailable = true;
        }
    }
}
