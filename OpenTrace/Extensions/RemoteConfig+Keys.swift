//
//  RemoteConfig+Keys.swift
//  OpenTrace
//
//  Created by Neil Horton on 17/04/2020.
//  Copyright © 2020 OpenTrace. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

extension RemoteConfig {
    enum ConfigKeys: String {
        case helpContent
        case symptomQuestions
        case advice1Content
        case advice2Content
    }
}
