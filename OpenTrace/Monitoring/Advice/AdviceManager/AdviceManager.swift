//
//  AdviceManager.swift
//  OpenTrace
//
//  Created by Sam Dods on 16/04/2020.
//  Copyright © 2020 OpenTrace. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

class AdviceManager {
    
    static let shared = AdviceManager()
    
    let advices1: [Advice]
    let advices2: [Advice]
    
    init() {
        advices1 = Self.loadAdvices(suffix: "1")
        advices2 = Self.loadAdvices(suffix: "2")
    }
    
    private static func loadAdvices(suffix: String) -> [Advice] {
        let configKey: RemoteConfig.ConfigKeys = suffix == "1" ? .advice1Content : .advice2Content
        let data = RemoteConfig.remoteConfig().configValue(forKey: configKey.rawValue).dataValue
        do {
            return try JSONDecoder().decode([Advice].self, from: data)
        } catch {
            return revertToFallBackJSON(suffix: suffix)
        }
    }
    
    private static func revertToFallBackJSON(suffix: String) -> [Advice] {
        let path = Bundle(for: Self.self).path(forResource: "Advice\(suffix)", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        return try! JSONDecoder().decode([Advice].self, from: data as Data)
    }
}
