//
//  SwiftAppDefaults.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/18/23.
//

import Foundation

protocol SwiftAppDefaultsProtocol {
    var customBuilds: [String : [Build]] { get set }
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
    
    public var customBuilds: [String : [Build]] {
        get {
            var decodedDict = [String : [Build]]()
            
            if let storedDict = defaults.object(forKey: Keys.customBuilds) as? [String : Data] {
                for key in storedDict.keys {
                    if let decoded = try? JSONDecoder().decode([Build].self, from: storedDict[key]!) {
                        decodedDict[key] = decoded
                    }
                }
            }
            
            return decodedDict
        }
        set {
            var storedDict = [String : Data]()
            for key in newValue.keys {
                if let encoded = try? JSONEncoder().encode(newValue[key]) {
                    storedDict[key] = encoded
                }
            }
            defaults.set(storedDict, forKey: Keys.customBuilds)
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
