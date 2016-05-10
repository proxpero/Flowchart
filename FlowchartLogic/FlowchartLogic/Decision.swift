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

    public let
    lhs: Bool
    public let rhs: Bool
    public let op: (Bool, Bool) -> Bool

}

public struct CompositeDecision: DecisionType {

    public let lhs: PrimitiveDecision
    public let rhs: PrimitiveDecision
    public let op: (PrimitiveDecision, PrimitiveDecision) -> Bool

}