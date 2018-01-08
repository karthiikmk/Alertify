//
//  Alertify
//
//  Created by karthik on 01/09/2018.
//  Copyright (c) 2018 karthikAdaptavant. All rights reserved.
//

import Foundation

/// Logger for debug
final class Debug {
    static var isEnabled = false
    static func log(_ msg: @autoclosure () -> String = "", _ file: @autoclosure () -> String = #file, _ line: @autoclosure () -> Int = #line, _ function: @autoclosure () -> String = #function) {
        if isEnabled {
            let fileName = file().components(separatedBy: "/").last ?? ""
            print("[Debug] [\(fileName):\(line())]#\(function()) \(msg())")
        }
    }
}
