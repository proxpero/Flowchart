//
//  Flowchart.swift
//  FlowchartLogic
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

public protocol Block {
    func transform(input: Int) -> Int
}

public struct Flowchart : Block {

    private let decision: Decision
    private let yes: Block
    private let no: Block

    public init(decision: Decision, yes: Block, no: Block) {
        self.decision = decision
        self.yes = yes
        self.no = no
    }

    public func transform(input: Int) -> Int {
        return decision.evaluatate(input) ? yes.transform(input) : no.transform(input)
    }

}

public struct Process: Block {

    private let transformation: (Int) -> Int
    public init(transformation: Int -> Int) {
        self.transformation = transformation
    }

    public func transform(input: Int) -> Int {
        return transformation(input)
    }

}