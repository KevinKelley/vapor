//
//  StructuredData.swift
//  Vapor
//
//  Created by Tanner Nelson on 5/24/16.
//
//

import Foundation

extension StructuredData {
    public subscript(index: Int) -> StructuredData? {
        switch self {
        case .array(let array):
            if array.count <= index {
                return nil
            }
            return array[index]
        case .dictionary(let dictionary):
            return dictionary["\(index)"]
        default:
            return nil
        }
    }

    public subscript(key: String) -> StructuredData? {
        switch self {
        case .array(let array):
            guard let index = Int(key) else {
                return nil
            }

            if array.count <= index {
                return nil
            }
            return array[index]
        case .dictionary(let dictionary):
            return dictionary[key]
        default:
            return nil
        }
    }
}

extension StructuredData: PathIndexable {
    public var pathIndexableArray: [StructuredData]? {
        if case .array(let array) = self {
            return array
        } else {
            return nil
        }
    }

    public var pathIndexableObject: [String: StructuredData]? {
        if case .dictionary(let dict) = self {
            return dict
        } else {
            return nil
        }
    }

    public init(_ array: [StructuredData]) {
        self = .array(array)
    }

    public init(_ object: [String: StructuredData]) {
        self = .dictionary(object)
    }
}
