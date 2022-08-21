//
//  File.swift
//  
//
//  Created by Jammi, Harikant on 21/08/22.
//

import Foundation
import NIOCore

protocol Module {
    associatedtype T: Codable
    
    func getAsync() async throws -> T
    func get() -> EventLoopFuture<T>
}


