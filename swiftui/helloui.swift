import SwiftUI

// Inspired by https://gist.github.com/chriseidhof/26768f0b63fa3cdf8b46821e099df5ff

struct HelloView: View {
    var body: some View {
        VStack {
            Text("Hello World!")
                .padding()
                .background(Capsule().fill(Color.red))
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)        
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 10, y: 100, width: 320, height: 240),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.title = "Hello App"
        window.contentView = NSHostingView(rootView: HelloView())
        window.makeKeyAndOrderFront(nil)
        window.delegate = self
        NSApp.activate(ignoringOtherApps: true)
    }
}

let myapp = NSApplication.shared  // NSApp is the same as myapp, after this assignment

var customMenu: NSMenu {
    let appMenu = NSMenuItem()
    appMenu.submenu = NSMenu()
    appMenu.submenu?.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    
    let mainMenu = NSMenu(title: "HelloWorld menu")
    mainMenu.addItem(appMenu)
    return mainMenu
}

let appDelegate = AppDelegate()
myapp.setActivationPolicy(.regular)
myapp.mainMenu = customMenu
myapp.delegate = appDelegate
myapp.run()
