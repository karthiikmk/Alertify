//
//  Alertify
//
//  Created by karthik on 01/09/2018.
//  Copyright (c) 2018 karthikAdaptavant. All rights reserved.
//

import Foundation

/// Internal AlertType protocol
internal protocol InternalAlertProtocol: class {
    
    /// inner alertController (getter, setter)
    var innerController: InnerAlertController! { get set }
    func finalHandler(_ handler: Any) -> InnerAlertController.FinallyHandler
}

extension InternalAlertProtocol where Self: AlertProtocol {
    
    // MARK: > Building Internal AlertController (Base)
    func buildInnerController(title: String? = nil, message: String? = nil, style: UIAlertControllerStyle) {
        innerController = InnerAlertController(title: title, message: message, preferredStyle: style)
        innerController.alertBackgroundColor = type(of: self).backgroundColor
        innerController.view.tintColor = type(of: self).buttonTextColor
        innerController.titleTextColor = type(of: self).titleTextColor
        innerController.messageTextColor = type(of: self).messageTextColor
    }
}

/// AlertType protocol
public protocol AlertProtocol: class {
    
    associatedtype Handler
    
    func action(_ action: Alertify.ActionType, handler: Handler?) -> Self
    
    var alertController: UIAlertController { get }    
    static var backgroundColor: UIColor? { get set }
    static var buttonTextColor: UIColor? { get set }
    static var titleTextColor: UIColor? { get set }
    static var messageTextColor: UIColor? { get set }
}

extension AlertProtocol {
    
    private var inner: InternalAlertProtocol {
        return self as! InternalAlertProtocol
    }
    
    /// Add actions to Alert
    public func actions(_ actions: [Alertify.ActionType], handler: Handler? = nil) -> Self {
        actions.forEach { _ = action($0, handler: handler) }
        return self
    }
    
    public func actions(_ actions: [String?], handler: Handler? = nil) -> Self {
        return self.actions(actions.map(Alertify.ActionType.init(title:)), handler: handler)
    }

    public func finally(_ handler: Handler) -> Self {
        inner.innerController.finallyHandler = inner.finalHandler(handler)
        return self
    }
    
    // MARK: > UIUtils
    public func backgroundColor(_ color: UIColor?) -> Self {
        inner.innerController.alertBackgroundColor = color
        return self
    }
    
    public func buttonTextColor(_ color: UIColor?) -> Self {
        inner.innerController.view.tintColor = color
        return self
    }
    
    public func titleTextColor(_ color: UIColor?) -> Self {
        inner.innerController.titleTextColor = color
        return self
    }

    public func messageTextColor(_ color: UIColor?) -> Self {
        inner.innerController.messageTextColor = color
        return self
    }

    public func titleTextAlignment(_ alignment: NSTextAlignment) -> Self {
        inner.innerController.titleTextAlignment = alignment
        return self
    }
    
    public func messageTextAlignment(_ alignment: NSTextAlignment) -> Self {
        inner.innerController.messageTextAlignment = alignment
        return self
    }
    
    /// Show alert (or action sheet)
    public func show(on viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController, completion: (() -> Void)? = nil) {
        if inner.innerController.preferredStyle == .actionSheet && UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            if inner.innerController.popoverPresentationController?.sourceView == nil {
                inner.innerController.popoverPresentationController?.sourceView = viewController?.view
            }
        }
        viewController?.present(inner.innerController, animated: true, completion: completion)
    }
    
    /// Build **UIAlertAction** using Alertify.Action and handler.
    func buildAction(_ action: Alertify.ActionType, handler: Alertify.ActionType.Handler?) -> UIAlertAction {
        return action.build(handler: handler.map { ActionBuilder.buildHandler($0, inner.innerController.finallyExecutor) })
    }
}
