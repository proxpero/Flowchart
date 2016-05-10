//
//  Decision.swift
//  FlowchartLogic
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import Swift

public protocol DecisionType {

    associatedtype T

    var value: T { get }
    var op: (T) -> Bool { get }

    func evaluation() -> Bool

}

extension DecisionType {

    public func evaluation() -> Bool {
        return op(value)
    }

}


public struct PrimitiveDecision: DecisionType {

    public let value: Int
    public let op: (Int) -> Bool

    // Why isn't the memberwise initializer getting synthesized for me?
    public init(value: Int, op: (Int) -> Bool) {
        self.value = value
        self.op  = op
    }


}

public struct CompositeDecision: DecisionType {

    public let value: PrimitiveDecision
    public let op: (PrimitiveDecision) -> Bool

    // Why isn't the memberwise initializer getting synthesized for me?
    public init(value: PrimitiveDecision, op: (PrimitiveDecision) -> Bool) {
        self.value = value
        self.op  = op
    }

}

public protocol OperatorType {
    associatedtype T
    var operation: (T) -> Bool { get }
}

public enum PrimitiveOperator: OperatorType {

    case isEqualToZero
    case isEven

    public var operation: (Int) -> Bool {
        switch self {
        case .isEqualToZero: return { x in x == 0 }
        case .isEven: return { x in x % 2 == 0 }
        }
    }

}

public enum CompositeOperator: OperatorType {

    case Not

    public var operation: (PrimitiveDecision) -> Bool {
        switch self {
        case .Not: return { x in !x.evaluation() }
        }
    }

}