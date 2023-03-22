//
//  PopUpAdViewModel.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 3/22/23.
//

import Foundation
import UIKit

public struct PopUpAdViewModel {
    
    public var title: String
    public var message: String
    public var headerBackgroundColor: UIColor?
    public var headerTextColor: UIColor?
    public var willWatch: (() -> ())
    
    public init(title: String, message: String, headerBackgroundColor: UIColor?, headerTextColor: UIColor?, willWatch: @escaping (() -> ())) {
        self.title = title
        self.message = message
        self.headerBackgroundColor = headerBackgroundColor
        self.headerTextColor = headerTextColor
        self.willWatch = willWatch
    }
}
