//
//  Logging.swift
//  JLImageDownloader
//
//  Created by James Lane on 8/15/24.
//

import Foundation

func log(methodName: String? = nil, message: String) {
    if let methodName {
        print("JLImageDownloader.\(methodName) \(message)")
    } else {
        print("JLImageDownloader - \(message)")
    }
}
