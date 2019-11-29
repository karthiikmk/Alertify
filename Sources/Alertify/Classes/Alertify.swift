//
//  Alertify
//
//  Created by karthik on 01/09/2018.
//  Copyright (c) 2018 karthikAdaptavant. All rights reserved.
//

import Foundation

public final class Alertify {    
    
    /// private initializer
    private init() {}
    
    /// Make alert
    /// - Returns: Instance of **Alert**
    public static func alert(title: String? = nil, message: String? = nil) -> Alert {
        return Alert(title: title, message: message)
    }

    /// Make action sheet
    /// - Returns: Instance of **ActionSheet**
    public static func actionSheet(title: String? = nil, message: String? = nil) -> ActionSheet {
        return ActionSheet(title: title, message: message)
    }

    /// Make action sheet
    /// - anchorView: will be anchor of popoverPresentationController.
    /// - Returns: Instance of **ActionSheet**
    public static func actionSheet(title: String? = nil, message: String? = nil, anchorView: UIView) -> ActionSheet {
        return actionSheet(title: title, message: message).popover(anchorView: anchorView)
    }
}
