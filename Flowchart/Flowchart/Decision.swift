//
//  Decision.swift
//  FlowchartLogic
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import Swift

public enum Decision: CustomTitleConvertible {

    case True
    case IsEven
    case IsEqualTo(Int)
    case IsLessThan(Int)
    case IsGreaterThan(Int)

    public func evaluate(input: Int) -> Bool {
        switch self {
        case True:
            return true
        case .IsEven:
            return input % 2 == 0
        case .IsEqualTo(let x):
            return input == x
        case .IsLessThan(let x):
            return input < x
        case .IsGreaterThan(let x):
            return input > x
        }
    }

    public var title: String {
        
        switch self {
        case True:
            return "True"
        case .IsEven:
            return "Is it even?"
        case .IsEqualTo(_):
            return "Is it equal to..."
        case .IsLessThan(_):
            return "Is it less than..."
        case .IsGreaterThan(_):
            return "Is it greater than..."
        }

    }


    public func decisionWithValue(n: Int) -> Decision {
        switch self {
        case .IsEqualTo:
            return Decision.IsEqualTo(n)
        case .IsLessThan:
            return Decision.IsLessThan(n)
        case .IsGreaterThan:
            return Decision.IsGreaterThan(n)
        default:
            print("Warning! Possibly unexpected result")
            return self
        }
    }

    static var store = [
        Decision.True,
        Decision.IsEven,
        Decision.IsEqualTo(0),
        Decision.IsLessThan(0),
        Decision.IsGreaterThan(0)
    ]
    
}
