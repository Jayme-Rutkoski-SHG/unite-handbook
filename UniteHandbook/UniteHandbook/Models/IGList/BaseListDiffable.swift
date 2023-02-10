//
//  BaseListDiffable.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation
import IGListKit

open class BaseListDiffable: NSObject, ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.diffIdentifier().isEqual(object?.diffIdentifier())
    }
}
