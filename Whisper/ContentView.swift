//
//  ContentView.swift
//  Whisper
//
//  Created by Praveen Singh on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var mc: MCManager = {
        let manager = MCManager()
        manager.isBrowsing = true
        return manager
    }()
    @State private var selection: Tab = .discover
    
    enum Tab {
        case chat
        case discover
        case settings 
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ChatView()
                .environmentObject(mc)
                .tabItem {
                    Label("Chat", systemImage: "message.circle")
                }
                .tag(Tab.chat)
            
            DiscoverView()
                .environmentObject(mc)
                .tabItem {
                    Label("Discover", systemImage: "point.3.connected.trianglepath.dotted")
                }
                .tag(Tab.discover)
            
            SettingsView() 
                .environmentObject(mc)
                .tabItem {
                    Label("Settings", systemImage: "gear") 
                }
                .tag(Tab.settings)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .quaternarySystemFill
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
