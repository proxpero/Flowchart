

import FlowchartLogic

/*
let input1 = 7
let input2 = 6
let op1 = PrimitiveOperator.isEqual
let op2 = PrimitiveOperator.isGreaterThan

let d1 = PrimitiveDecision(lhs: input1, rhs: input2, op: op1.operation)
let d2 = PrimitiveDecision(lhs: input1, rhs: input2, op: op2.operation)

d1.evaluation()
d2.evaluation()


let op3 = CompositeOperator.Or
let d3 = CompositeDecision(lhs: d1, rhs: d2, op: op3.operation)
d3.evaluation()

*/


let input3 = 6
let op4 = PrimitiveOperator.isEqualToZero
let op5 = PrimitiveOperator.isEven
let d4  = Decision(value: input3, op: op4.operation)
let d5 = Decision(value: 8, op: op5.operation)

d4.evaluation()
//d4.and(d5)


let increment = Flowchart(transform: { x in x + 1 })
increment.evaluate(input3)


