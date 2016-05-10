


public struct Decision<A> {
    private let value: A
    private let op: (A) -> Bool

    public init(value: A, op: (A) -> Bool) {
        self.value = value
        self.op = op
    }

}


//var evaluate: (Int->Bool) -> Int -> Bool

func isEven(x: Int) -> Bool {
    return x % 2 == 0
}

func isEqual(x: Int) -> (Int -> Bool) {
    return { y in x == y }
}

let evaluate = isEven

let isEqual5 = isEqual(5)
isEqual5(7)

evaluate(4)

isEven(4)


