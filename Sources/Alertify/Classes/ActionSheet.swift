//
//  Alertify
//
//  Created by karthik on 01/09/2018.
//  Copyright (c) 2018 karthikAdaptavant. All rights reserved.
//

import UIKit

extension Alertify {

    final public class ActionSheet: AlertProtocol, InternalAlertProtocol {

        //InternalAlertProtocol
        var innerController: InnerAlertController!
        
        func finalHandler(_ handler: Any) -> InnerAlertController.FinallyHandler {
            return { (action, index, _) in (handler as? Handler)? (action, index) }
        }
        
        //AlertProtocol
        public typealias Handler = (UIAlertAction, Int) -> Void
        
        public var alertController: UIAlertController {
            return innerController as UIAlertController
        }
        
        public static var backgroundColor: UIColor?
        public static var buttonTextColor: UIColor?
        public static var titleTextColor: UIColor?
        public static var messageTextColor: UIColor?

        /// Make action sheet
        /// Convininece Action
        public init(title: String? = nil, message: String? = nil) {
            buildInnerController(title: title, message: message, style: .actionSheet)
        }
        
        public func action(_ action: Alertify.ActionType, handler: Handler? = nil) -> Self {
            return self.action(action, image: nil, handler: handler)
        }
        
        /// Base Action
        public func action(_ action: Alertify.ActionType, image: UIImage?, renderingMode: UIImage.RenderingMode = .automatic, handler: Handler? = nil) -> Self {
            
            let megedHandler = mergeHandler(innerController.actionHandler, handler ?? { (_, _) in })
            let alertAction = buildAction(action, handler: megedHandler)
            
            if let image = image {
                alertAction.setValue(image.withRenderingMode(renderingMode), forKey: "image")
            }

            innerController.addAction(alertAction)
            return self
        }
        
        // MARK: > Ipad
        public func popover(sourceView view: UIView?, sourceRect rect: CGRect) -> Self {
            innerController.popoverPresentationController?.sourceView = view
            innerController.popoverPresentationController?.sourceRect = rect
            return self
        }

        public func popover(anchorView: UIView) -> Self {
            innerController.popoverPresentationController?.sourceView = anchorView.superview
            innerController.popoverPresentationController?.sourceRect = anchorView.frame
            return self
        }
		
		public func addDefaultIpadSupportable(_ ipadSuppportView: UIView) -> Self {
			guard UIDevice.current.userInterfaceIdiom == .pad, let popoverController = innerController.popoverPresentationController else { return self }
			popoverController.sourceView = view
			popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
			popoverController.permittedArrowDirections = []
			return self
		}
        
        public func popover(barButtonItem: UIBarButtonItem?) -> Self {
            innerController.popoverPresentationController?.barButtonItem = barButtonItem
            return self
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
