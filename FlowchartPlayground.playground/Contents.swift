

import FlowchartLogic

let input1 = 7
let input2 = 6

let d1 = PrimitiveDecision(lhs: input1, rhs: input2, op: { x, y in x == y})

d1.evaluation()
