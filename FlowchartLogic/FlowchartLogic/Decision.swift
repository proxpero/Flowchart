//
//  Decision.swift
//  FlowchartLogic
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

protocol DecisionType {

    associatedtype T

    var lhs: T { get }
    var rhs: T { get }
    var op: (T, T) -> Bool { get }

    func evaluation() -> Bool

}

extension DecisionType {

    func evaluation() -> Bool {
        return op(lhs, rhs)
    }

}


struct PrimitiveDecision: DecisionType {

    let lhs: Bool
    let rhs: Bool
    let op: (Bool, Bool) -> Bool

}

struct CompositeDecision: DecisionType {

    let lhs: PrimitiveDecision
    let rhs: PrimitiveDecision
    let op: (PrimitiveDecision, PrimitiveDecision) -> Bool

}