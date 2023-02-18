//
//  SwiftAppDefaults.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/18/23.
//

import Foundation

protocol SwiftAppDefaultsProtocol {
    var customBuilds: [String : Build] { get set }
}

public class SwiftAppDefaults: SwiftAppDefaultsProtocol {
    
    public static let shared: SwiftAppDefaults = {
        return SwiftAppDefaults()
    }()
    
    private var defaults: UserDefaults
    
    public init() {
        self.defaults = UserDefaults.standard
    }
    private struct Keys {
        public static let customBuilds = "AppDefaults.Keys.customBuilds"
    }
    
    public var customBuilds: [String : Build] {
        get {
            if let customBuilds = (defaults.dictionary(forKey: Keys.customBuilds) as? [String : Build]) {
                return customBuilds
            }
            
            return [String : Build]()
        }
        set {
            defaults.set(newValue, forKey: Keys.customBuilds)
        }
    }
}

fileprivate extension UserDefaults {
    
    // String
    func safe(set value: String?, forKey: String) {
        
        guard let value = value else {
            self.removeObject(forKey: forKey)
            return
        }
        
        self.set(value, forKey: forKey)
    }
    
}
