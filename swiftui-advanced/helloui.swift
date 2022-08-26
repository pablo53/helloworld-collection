import SwiftUI

// Inspired by https://gist.github.com/chriseidhof/26768f0b63fa3cdf8b46821e099df5ff

struct RightArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.25, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.25, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.25, y: rect.midY))
        return path
    }
}

struct HelloView: View {
    @State private var name: String = "World"
    @State private var bt1: Bool = true
    @State private var bt2: Bool = true
    @State private var bt3: Bool = true
    @State private var expandBallsGroup: Bool = false
    @State private var expandBgColor = Color.black
    var body: some View {
        VStack {
            Text("Hello \(name)!")
                .padding()
                .shadow(color: .white, radius: 1, x: 25, y: 25)
                .background(Capsule().fill(Color.blue))
                .padding()
            HStack {
                Spacer()
                TextField("Your name", text: $name)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.pink, lineWidth: 2))
                Spacer()
                GeometryReader { geometry in
                    Path { path in
                        path.move(to: CGPoint(x: 10, y: 10))
                        path.addLine(to: CGPoint(x: 40, y: 10))
                        path.addLine(to: CGPoint(x: 50, y: 25))
                        path.addLine(to: CGPoint(x: 40, y: 40))
                        path.addLine(to: CGPoint(x: 10, y: 40))
                        path.addLine(to: CGPoint(x: 20, y: 25))
                    }
                        .fill(Color.blue)
                        .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.95)
                        .background(Color.gray)
                    RightArrow()
                        .fill(Color.red)
                        .offset(x: 60, y: 10)
                        .frame(width: 40, height: 30)
                        .shadow(color: .red, radius: 3, x: 5, y: 5)
                    RightArrow()
                        .fill(Color.green)
                        .offset(x: 100, y: 10)
                        .frame(width: 40, height: 30)
                    RightArrow()
                        .fill(Color.yellow)
                        .offset(x: 80, y: 30)
                        .frame(width: 40, height: 30)
                        .shadow(color: .yellow, radius: 3, x: 5, y: 5)
                    RightArrow()
                        .fill(Color.purple)
                        .offset(x: 40, y: 30)
                        .frame(width: 40, height: 30)
                    RightArrow()
                        .fill(Color.white.opacity(0.6))
                        .offset(x: 20, y: 20)
                        .frame(width: 120, height: 30)
                }
                Spacer()
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .topLeading)
            HStack {
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
                        Spacer()
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
                        Spacer()
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
                        Spacer()
                    }
                }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.gray))
                    .padding()
                VStack {
                    ColorPicker("Background color", selection: $expandBgColor)
                    DisclosureGroup("Balls", isExpanded: $expandBallsGroup) {
                        Toggle("ball 1", isOn: $bt1)
                        Toggle("ball 2", isOn: $bt2)
                        Toggle("ball 3", isOn: $bt3)
                    }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).fill(expandBgColor))
                        .padding()
                    Spacer()
                    ScrollView{
                        LazyVGrid(
                            columns: [ GridItem(.fixed(70), spacing: 1), GridItem(.fixed(70), spacing: 1),  GridItem(.fixed(70), spacing: 1) ],
                            alignment: .center,
                            spacing: 0
                        ) {
                            ForEach(0..<120) { idx in
                                Text("\(idx).")
                                    .foregroundColor((idx % 2 == 0) ? Color.blue : .white)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill((idx % 2 == 0) ? Color.white : .blue)
                                            .frame(width: 60, height: 40)
                                    .padding()
                                    )
                            }
                        }
                    }
                }
            }
                .padding()
                .background(RoundedRectangle(cornerRadius: 25).fill(Color.black))
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)        
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 10, y: 100, width: 800, height: 480),
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
