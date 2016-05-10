//
//  Flowchart.swift
//  FlowchartLogic
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

public struct Flowchart<A> {

    private let transform: (A) -> A

    public init(transform: A -> A) {
        self.transform = transform
    }

    public func evaluate(n: A) -> A {
        return transform(n)
    }

}


