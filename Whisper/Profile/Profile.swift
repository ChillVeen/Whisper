//
//  ProfileView.swift
//  Whisper
//
//  Created by Praveen Singh on 15/12/24.
//

import Foundation
import SwiftUI

struct Profile: Codable, Equatable {
    var name = "Santa"
    var avatar = UIImage(named: "Test")!.pngData()!
    var bio = "I'm Santa Clause"
    var isAdvertising = false
    
    static let `default` = Profile()
    
    func data() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func equals(profile: Profile) -> Bool {
        if self.name != profile.name { return false }
        if self.avatar != profile.avatar { return false }
        if self.bio != profile.bio { return false }
        if self.isAdvertising != profile.isAdvertising { return false }
        return true
    }
}
