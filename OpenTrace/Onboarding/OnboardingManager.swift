//
//  OnboardingManager.swift
//  OpenTrace

import Foundation
import FirebaseAuth

class OnboardingManager {

    static let shared = OnboardingManager()

    func returnCurrentLaunchPage() -> String {
        if !completedIWantToHelp {
            return "intro"
        } else if !hasConsented {
            return "howItWorks"
        } else if !allowedPermissions {
            return "howItWorks"
        } else if !completedBluetoothOnboarding {
            return "howItWorks"
        } else {
            return "main"
        }
    }
}

extension OnboardingManager {

    var completedIWantToHelp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "completedIWantToHelp")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "completedIWantToHelp")
        }
    }

    var completedBluetoothOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "completedBluetoothOnboarding")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "completedBluetoothOnboarding")
        }
    }

    var hasConsented: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "hasConsented")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasConsented")
        }
    }

    var allowedPermissions: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "allowedPermissions")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "allowedPermissions")
        }
    }
}
