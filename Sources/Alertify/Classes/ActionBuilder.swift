//
//  Alertify
//
//  Created by karthik on 01/09/2018.
//  Copyright (c) 2018 karthikAdaptavant. All rights reserved.
//

import UIKit


/// merge two closure to one closure.
func mergeHandler<A, B, C>(_ h1: @escaping (A) -> B, _ h2: @escaping (B) -> C) -> (A) -> C {
    return { x in h2(h1(x)) }
}

final class ActionBuilder {
    
    private init() {}
    
    /// Build closure using two closure.
    static func buildHandler<T: UIAlertAction>(_ h1: @escaping (T) -> Void, _ h2: @escaping (T) -> Void) -> (T) -> Void {
        return {
            h1($0)
            h2($0)
        }
    }
}

