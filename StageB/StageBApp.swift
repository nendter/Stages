//
//  StageBApp.swift
//  StageB
//
//  Created by Niklas Endter on 01.06.25.
//

import SwiftUI
import SwiftData

@main
struct StageBApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate;
    
    var body: some Scene {
        Settings {}
    }
}

/* Delegate */

class AlwaysOnTopPanel: NSPanel {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}

class AlwaysOnTopWindow: NSWindow {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var panel: NSPanel!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()

        panel = AlwaysOnTopPanel(
            contentRect: NSMakeRect(200, 200, 1200, 800),
            styleMask: [.titled, .closable, .resizable, .fullSizeContentView, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        panel.isFloatingPanel = true
        panel.hidesOnDeactivate = false
        panel.level = .mainMenu
        panel.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary,
            .stationary,
            .ignoresCycle
        ]
        panel.isOpaque = false
        panel.contentView = NSHostingView(rootView: contentView)

        panel.makeKeyAndOrderFront(nil)
    }
}
