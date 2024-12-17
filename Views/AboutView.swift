//
//  AboutView.swift
//  Whisper
//
//  Created by Praveen Singh on 17/12/24.
//

import SwiftUI

// Main AboutView
struct AboutView: View {
    // Animation properties
    @State private var isAnimating = false
    @State private var showFeatures = false
    
    // App version from bundle
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // App Logo
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding()
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                
                // App Title and Version
                VStack(spacing: 8) {
                    Text("Whisper")
                        .font(.system(size: 32, weight: .bold))
                    Text("Version \(appVersion)")
                        .foregroundColor(.secondary)
                }
                
                // Description
                Text("Secure, Peer-to-Peer Chat")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.green)
                
                // Features Section
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(AppFeature.allFeatures) { feature in
                        FeatureRow(feature: feature)
                            .opacity(showFeatures ? 1 : 0)
                            .offset(x: showFeatures ? 0 : -50)
                            .animation(
                                .spring(response: 0.3, dampingFraction: 0.7)
                                .delay(Double(feature.id) * 0.1),
                                value: showFeatures
                            )
                    }
                }
                .padding()
                
                // Developer Info
                VStack(spacing: 20) {
                    Text("Developed by")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Praveen Singh")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    // Social Links
                    HStack(spacing: 20) {
                        SocialLinkButton(type: .github)
                        SocialLinkButton(type: .twitter)
                        SocialLinkButton(type: .linkedin)
                    }
                }
                .padding()
            }
            .padding(.vertical)
        }
        .onAppear {
            isAnimating = true
            withAnimation(.easeOut(duration: 0.5)) {
                showFeatures = true
            }
        }
    }
}

// Feature Model
struct AppFeature: Identifiable {
    let id: Int
    let icon: String
    let title: String
    let description: String
    
    static let allFeatures = [
        AppFeature(id: 0, icon: "lock.shield", title: "End-to-End Encryption", description: "Your messages are secure and private"),
        AppFeature(id: 1, icon: "antenna.radiowaves.left.and.right", title: "Peer-to-Peer", description: "Direct connection without servers"),
        AppFeature(id: 2, icon: "wifi.slash", title: "Offline Chat", description: "No internet connection needed"),
        AppFeature(id: 3, icon: "photo", title: "Media Sharing", description: "Share images and files securely")
    ]
}

// Feature Row View
struct FeatureRow: View {
    let feature: AppFeature
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: feature.icon)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.headline)
                Text(feature.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

// Social Link Type and Button
enum SocialLinkType {
    case github, twitter, linkedin
    
    var icon: String {
        switch self {
        case .github: return "link.circle.fill"
        case .twitter: return "bubble.left.fill"
        case .linkedin: return "network"
        }
    }
    
    var url: URL {
        switch self {
        case .github: return URL(string: "https://github.com/your-username")!
        case .twitter: return URL(string: "https://twitter.com/your-username")!
        case .linkedin: return URL(string: "https://linkedin.com/in/your-username")!
        }
    }
}

struct SocialLinkButton: View {
    let type: SocialLinkType
    
    var body: some View {
        Link(destination: type.url) {
            Image(systemName: type.icon)
                .font(.title)
                .foregroundColor(.accentColor)
        }
    }
}

// End of file
