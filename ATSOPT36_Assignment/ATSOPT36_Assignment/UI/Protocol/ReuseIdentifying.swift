//
//  ReuseIdentifying.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/7/25.
//

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
