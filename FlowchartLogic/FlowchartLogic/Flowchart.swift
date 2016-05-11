//
//  Flowchart.swift
//  FlowchartLogic
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

public protocol Block {
    var title: String { get }
    func transform(input: Int) -> Int
}

public struct Flowchart : Block {

    public let title: String

    private let decision: Decision
    private let yes: Block
    private let no: Block

    public init(decision: Decision, yes: Block, no: Block, title: String = "Flowchart") {
        self.title = title
        self.decision = decision
        self.yes = yes
        self.no = no
    }

    public func transform(input: Int) -> Int {
        return decision.evaluatate(input) ? yes.transform(input) : no.transform(input)
    }

}

public struct Process: Block {

    public let title: String

    private let transformation: (Int) -> Int
    public init(transformation: Int -> Int, title: String = "Process") {
        self.title = title
        self.transformation = transformation
    }

    public func transform(input: Int) -> Int {
        return transformation(input)
    }

}