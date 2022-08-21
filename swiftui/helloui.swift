import Cocoa



let quitMenuItem = NSMenuItem.init(
    title: "Quit hello",
    action: #selector(NSApplication.terminate),
    keyEquivalent: "q"
)

let appMenu = NSMenu()
appMenu.addItem(quitMenuItem)

let appMenuItem = NSMenuItem()
appMenuItem.submenu = appMenu

let menubar = NSMenu()
menubar.addItem(appMenuItem)

let nsapp = NSApplication.shared
nsapp.setActivationPolicy(NSApplication.ActivationPolicy.regular)
nsapp.mainMenu = menubar

let window = NSWindow.init(
    contentRect: NSMakeRect(100, 100, 320, 200),
    styleMask: [.titled, .fullSizeContentView],
    backing: .buffered,
    defer: false
)
window.cascadeTopLeft(from: NSMakePoint(20, 20))
window.title = "Hello World UI Application"
window.makeKeyAndOrderFront(nil)

nsapp.activate(ignoringOtherApps: true)
nsapp.run()
