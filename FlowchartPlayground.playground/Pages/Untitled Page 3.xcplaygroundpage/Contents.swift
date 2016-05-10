import FlowchartLogic

//let input = 5

let isEven = Decision(operation: { x in x % 2 == 0 })
//let increment = Process(transformation: { x in x + 1 })
//let decrement = Process(transformation: { x in x - 1 })

//let chart1 = Flowchart(decision: isEven, yes: increment, no: decrement)

//let result = chart1.transform(input)

//let is4 = Decision(operation: { x in x == 4 })
//let double = Process(transformation: { x in x * 2 })

//let chart2 = Flowchart(decision: is4, yes: double, no: chart1)

//let result2 = chart2.transform(3)
//let result3 = chart2.transform(-1)

let is1 = Decision(operation: { x in x == 1})
//
let triplePlusOne = Process(transformation: { x in 3 * x + 1 })
let halve = Process(transformation: { x in x / 2 })
let _collatz = Flowchart(decision: isEven, yes: halve, no: triplePlusOne)
//
let returnIt = Process(transformation: { x in x })
//
let collatz = Flowchart(decision: is1, yes: returnIt, no: _collatz)
//
collatz.transform(5)

var input = 42
while input != 1 {
    input = _collatz.transform(input)
}
input