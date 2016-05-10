

import FlowchartLogic

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


