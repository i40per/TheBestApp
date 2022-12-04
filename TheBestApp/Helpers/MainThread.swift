//
//  MainThread.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 03.12.2022.
//

import Foundation

public func mainThread(closure: @escaping ()->()) {
    
    DispatchQueue.main.async {
        closure()
    }
}
