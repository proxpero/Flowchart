//
//  Decision.swift
//  FlowchartLogic
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

public protocol DecisionType {

    associatedtype T

    var lhs: T { get }
    var rhs: T { get }
    var op: (T, T) -> Bool { get }

    func evaluation() -> Bool

}

extension DecisionType {

    public func evaluation() -> Bool {
        return op(lhs, rhs)
    }

}


public struct PrimitiveDecision: DecisionType {

    public let lhs: Int
    public let rhs: Int
    public let op: (Int, Int) -> Bool

    // Why isn't the memberwise initializer getting synthesized for me?
    public init(lhs: Int, rhs: Int, op: (Int, Int) -> Bool) {
        self.lhs = lhs
        self.rhs = rhs
        self.op  = op
    }


}

public struct CompositeDecision: DecisionType {

    public let lhs: PrimitiveDecision
    public let rhs: PrimitiveDecision
    public let op: (PrimitiveDecision, PrimitiveDecision) -> Bool

    // Why isn't the memberwise initializer getting synthesized for me?
    public init(lhs: PrimitiveDecision, rhs: PrimitiveDecision, op: (PrimitiveDecision, PrimitiveDecision) -> Bool) {
        self.lhs = lhs
        self.rhs = rhs
        self.op  = op
    }

}