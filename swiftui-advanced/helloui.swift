import SwiftUI

// Inspired by https://gist.github.com/chriseidhof/26768f0b63fa3cdf8b46821e099df5ff

struct HelloView: View {
    @State var name: String = "World"
    @State var bt1: Bool = true
    @State var bt2: Bool = true
    @State var bt3: Bool = true
    var body: some View {
        VStack {
            Text("Hello \(name)!")
                .padding()
                .background(Capsule().fill(Color.blue))
                .padding()
            HStack {
                TextField("Your name", text: $name)
            }
            HStack {
                VStack {
                    Button(bt1 ? "Hide" : "Show") {
                        bt1.toggle()
                    }
                    Text("1")
                        .foregroundColor(bt1 ? .white : .gray)
                        .padding()
                        .background(Circle().fill(bt1 ? Color.red : .gray))
                        .padding()
                }
                VStack {
                    Button(bt2 ? "Hide" : "Show") {
                        bt2.toggle()
                    }
                    Text("2")
                        .foregroundColor(bt2 ? .white : .gray)
                        .padding()
                        .background(Circle().fill(bt2 ? Color.green : .gray))
                        .padding()
                }
                VStack {
                    Button(bt3 ? "Hide" : "Show") {
                        bt3.toggle()
                    }
                    Text("3")
                        .foregroundColor(bt3 ? .white : .gray)
                        .padding()
                        .background(Circle().fill(bt3 ? Color.blue : .gray))
                        .padding()
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 25).fill(Color.gray))
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
            styleMask: [.titled, .closable, .resizable, .fullSizeContentView],
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
