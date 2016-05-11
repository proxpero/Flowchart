//
//  Decision.swift
//  FlowchartLogic
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import Swift

public enum Decision {

    case IsEven
    case IsEqualTo(Int)
    case IsLessThan(Int)
    case IsGreaterThan(Int)

    public func evaluate(input: Int) -> Bool {
        switch self {
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
        case .IsEven:
            return "Is Even?"
        case .IsEqualTo(_):
            return "Is Equal To?"
        case .IsLessThan(_):
            return "Is Less Than?"
        case .IsGreaterThan(_):
            return "Is Greater Than?"
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
            fatalError()
        }
    }

    mutating public func setValueInPlace(n: Int) {
        switch self {
        case .IsEqualTo:
            self = Decision.IsEqualTo(n)
        case .IsLessThan:
            self = Decision.IsLessThan(n)
        case .IsGreaterThan:
            self = Decision.IsGreaterThan(n)
        default:
            ()
        }
    }
    
}

public struct Decision_ {

    public let title: String

    private let operation: (Int -> Bool)

    public init(operation: Int -> Bool, title: String = "Decision") {
        self.title = title
        self.operation = operation
    }

    public func evaluate(input: Int) -> Bool {
        return operation(input)
    }

}


//public protocol DecisionType {
//
//    associatedtype T
//
//    var value: T { get }
//    var op: (T) -> Bool { get }
//
//    func evaluation() -> Bool
//
//}
//
//extension DecisionType {
//
//    public func evaluation() -> Bool {
//        return op(value)
//    }
//
//}
//
//
//
//
//public struct Decision<A>: DecisionType {
//    public let value: A
//    public let op: (A) -> Bool
//
//    public init(value: A, op: (A) -> Bool) {
//        self.value = value
//        self.op = op
//    }
//}
//
//extension DecisionType where T == Int {
//
//    func and(other: Self) -> Bool {
//        return self.evaluation() && other.evaluation()
//    }
//
//}
//
//public protocol OperatorType {
//    associatedtype T
//    var operation: (T) -> Bool { get }
//}
//
//extension OperatorType where T == Decision<Int> {
//
//    func and(lhs: T, rhs: T) -> Bool {
//        return lhs.evaluation() && rhs.evaluation()
//    }
//
//}
//
//extension OperatorType where T: DecisionType {
//
//    func and(lhs: T, rhs: T) -> Bool {
//        return lhs.evaluation() && rhs.evaluation()
//    }
//
//    func or(lhs: T, rhs: T) -> Bool {
//        return lhs.evaluation() || rhs.evaluation()
//    }
//
//    
//}
//
//
//
//public enum PrimitiveOperator: OperatorType {
//
//    case isEqualToZero
//    case isEven
//
//    public var operation: (Int) -> Bool {
//        switch self {
//        case .isEqualToZero: return { x in x == 0 }
//        case .isEven: return { x in x % 2 == 0 }
//        }
//    }
//
//}
//
//public enum CompositeOperator<A where A: DecisionType> {
//
//    case Not
//
//    public var operation: (A) -> Bool {
//        switch self {
//        case .Not: return { x in !x.evaluation() }
//        }
//    }
//
//}