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



public protocol CustomTitleConvertible {
    var title: String { get }
}

public struct Flowchart: Block, CustomTitleConvertible {

    public let title: String

    let decision: Decision
    let yes: Block
    let no: Block

    public init(decision: Decision, yes: Block, no: Block, title: String = "Flowchart") {
        self.title = title
        self.decision = decision
        self.yes = yes
        self.no = no
    }

    public func transform(input: Int) -> Int {
        return decision.evaluate(input) ? yes.transform(input) : no.transform(input)
    }

    public static var store = Array<Flowchart>()

}

public struct Process: Block, CustomTitleConvertible {

    public let title: String

    private let transformation: (Int) -> Int
    public init(transformation: Int -> Int, title: String = "Process") {
        self.title = title
        self.transformation = transformation
    }

    public func transform(input: Int) -> Int {
        return transformation(input)
    }

    public static var store: [Process] = [
        Process(transformation: { x in x },     title: "Identity"),
        Process(transformation: { x in x + 1 }, title: "Increment"),
        Process(transformation: { x in x - 1 }, title: "Decrement"),
        Process(transformation: { x in x * 2 }, title: "Double"),
        Process(transformation: { x in x * 3 }, title: "Triple"),
        Process(transformation: { x in x * x }, title: "Square")
    ]

}