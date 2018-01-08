//
//  Alert.swift
//  Alertift
//
//  Created by Suguru Kishimoto on 4/26/17.
//  Copyright © 2017 Suguru Kishimoto. All rights reserved.
//

import Foundation

extension Alertify {
    
    public enum AlertImagePosition {
        case top // Above title and message
        case center // Between title and message
        case bottom // Below title and message
    }
    
    /// Alert
    final public class Alert: AlertProtocol, InternalAlertProtocol {
        
        // MARK: > InternalAlertProtocol
        var innerController: InnerAlertController!
        
        func finalHandler(_ handler: Any) -> InnerAlertController.FinallyHandler {
            return { (handler as? Handler)?($0, $1, $2) }
        }
        
        // MARK: > AlertProtocol
        public typealias Handler = (UIAlertAction, Int, [UITextField]?) -> Void
        public typealias TextFieldHandler = ((UITextField, Int) -> Void)
        public typealias ActionWithTextFieldsHandler = ([UITextField]?) -> Void
        
        public static var backgroundColor: UIColor?
        public static var buttonTextColor: UIColor?
        public static var titleTextColor: UIColor?
        public static var messageTextColor: UIColor?
        
        public var alertController: UIAlertController {
            return innerController as UIAlertController
        }
        
        /// Make alert
        /// - Returns: Instance of **Alert**
        public init(title: String? = nil, message: String? = nil) {
            buildInnerController(title: title, message: message, style: .alert)
        }
        
        /// Add action to Alert
        public func action(_ action: Alertify.ActionType,
                           handler: Handler? = nil) -> Self {
            return self.action(action, isPreferred: false, handler: handler)
        }
        
        public func action(_ action: Alertify.ActionType,
                           isPreferred: Bool,
                           handler: Handler? = nil) -> Self {
            return self.action(action, image: nil, isPreferred: isPreferred, handler: handler)
        }
        
        public func action(_ action: Alertify.ActionType,
                           image: UIImage?,
                           renderingMode: UIImageRenderingMode = .automatic,
                           handler: Handler? = nil) -> Self {
            return self.action(action, image: image, renderingMode: renderingMode, isPreferred: false, handler: handler)
        }

        public func action(_ action: Alertify.ActionType,
                           image: UIImage?,
                           renderingMode: UIImageRenderingMode = .automatic,
                           isPreferred: Bool,
                           handler: Handler? = nil) -> Self {
            
            let mergedHandler = mergeHandler(innerController.actionWithTextFieldsHandler, handler ?? { (_, _, _)in })
            let alertAction = buildAction(action, handler: mergedHandler)

            if let image = image {
                alertAction.setValue(image.withRenderingMode(renderingMode), forKey: "image")
            }
            
            addActionToAlertController(alertAction, isPreferred: isPreferred)
            
            return self
        }

        /// Add text field to alertController
        /// - Parameter handler: Define handler if you want to customize UITextField. Default is nil.
        /// - Returns: Myself
        public func textField(configurationHandler handler: ((UITextField) -> Void)? = nil) -> Self {
            innerController.addTextField { [weak self] textField in
                handler?(textField)
                self?.innerController.registerTextFieldObserver(textField)
            }            
            return self
        }
        
        /// Add textFieldHandler to alertController.
        ///
        /// If text field's text is changed, execute textFieldHandler with text field and index.
        ///
        /// - Parameter textFieldTextDidChangeHandler: TextFieldHandler (UITextField, Int) -> Void
        /// - Returns: Myself
        public func handleTextFieldTextDidChange(textFieldTextDidChangeHandler: TextFieldHandler?) -> Self {
            innerController.textFieldTextDidChangeHandler = textFieldTextDidChangeHandler
            return self
        }
        
        /// Add alertAction to alertController
        private func addActionToAlertController(_ alertAction: UIAlertAction, isPreferred: Bool) {
            innerController.addAction(alertAction)
            if isPreferred {
                innerController.preferredAction = alertAction
            }
        }
        
        public func image(_ image: UIImage?, imageTopMargin: Alertify.ImageTopMargin = .none) -> Self {
            innerController.setImage(image, imageTopMargin: imageTopMargin)
            return self
        }
        
        deinit {
            Debug.log()
        }
    }
}
