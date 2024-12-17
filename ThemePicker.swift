//
//  ThemePicker.swift
//  Whisper
//
//  Created by Praveen Singh on 13/12/24.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"

    var id: String { self.rawValue }
}

struct ThemePicker: View {
    @AppStorage("SelectedTheme") private var selectedTheme: AppTheme = .system
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading) {
            Picker("Theme", selection: $selectedTheme) {
                ForEach(AppTheme.allCases) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedTheme) { _ in
                applyTheme()
            }
            .onAppear {
                applyTheme()
            }

            Text("Current Theme: \(currentThemeDescription())")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    private func applyTheme() {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let windows = scene?.windows ?? []
        
        switch selectedTheme {
        case .light:
            windows.forEach { $0.overrideUserInterfaceStyle = .light }
        case .dark:
            windows.forEach { $0.overrideUserInterfaceStyle = .dark }
        case .system:
            windows.forEach { $0.overrideUserInterfaceStyle = .unspecified }
        }
    }

    private func currentThemeDescription() -> String {
        switch selectedTheme {
        case .light: return "Light Mode"
        case .dark: return "Dark Mode"
        case .system:
            return colorScheme == .dark ? "System (Dark Mode)" : "System (Light Mode)"
        }
    }
}

