//
//  Alertify
//
//  Created by karthik on 01/09/2018.
//  Copyright (c) 2018 karthikAdaptavant. All rights reserved.
//

import Foundation

extension Alertify {
    
    /// Action type for **Alert**, **ActionSheet**
    public enum ActionType {
        
        typealias Handler = (UIAlertAction) -> Void
        
        case `default`(String?)
        case destructive(String?)
        case cancel(String?)
        
        init(title: String?) {
            self = .default(title)
        }
        
        /// **UIAlertAction**'s title
        private var title: String? {
            switch self {
            case .default(let title):
                return title
            case .destructive(let title):
                return title
            case .cancel(let title):
                return title
            }
        }
        
        /// **UIAlertAction**'s style
        private var style: UIAlertActionStyle {
            switch self {
            case .default( _):
                return .default
            case .destructive( _):
                return .destructive
            case .cancel( _):
                return .cancel
            }
        }
        
        /// **Build UIAlertAction**
        /// - Returns: Instance of **UIAlertAction**
        func build(handler actionHandler: ActionType.Handler?) -> UIAlertAction {
            return UIAlertAction(title: title, style: style, handler: actionHandler)
        }
    }
}
