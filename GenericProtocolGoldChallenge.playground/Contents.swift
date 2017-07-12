//: Playground - noun: a place where people can play

import Cocoa

struct StackIterator<T>: IteratorProtocol {
    
    var stack: Stack<T>
    
    mutating func next() -> T?{
        
        return stack.pop()
    }
    
}




struct Stack<Element>: Sequence {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    
    func map<U>(_ f: (Element) -> U) -> Stack<U> {
        
        var mappedItems = [U]()
        for item in items {
            mappedItems.append(f(item))
        }
        return Stack<U>(items: mappedItems)
        
    }
    
    func filter(_ f: (Element) -> Bool ) -> Stack<Element>{
        
        
        var filteredItems = Stack<Element>()
        for item in items{
            
            if f(item) == true{
                
                filteredItems.push(item)
            }
            
        }
        
        
        return filteredItems
        
    }
    
    func CheckAnyCollection<C: Collection>(in collection: C, for element: C.Iterator.Element) -> [C.Index] where C.Iterator.Element: Equatable, C.Indices.Iterator.Element == C.Index
        
    {
        
        return zip(c.indices, c).lazy.filter{ $0.1 == element }.map{ $0.0 }
        
    }
    
    
    func findAll<T: Equatable>(_ collection: [T], _ searchFor: T) -> [Int]{
        
        var itemArray = [Int]()
        
        
        for(index, item) in collection.enumerated() {
            
            if item == searchFor {
                
                itemArray.append(index)
            }
        }
        
        return itemArray
        
    }
    
    
    
    func makeIterator() -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
    
    mutating func pushAll<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        
        for item in sequence {
            
            self.push(item)
        }
    }
    
}

var myStack = Stack<Int>()
myStack.push(10)
myStack.push(20)
myStack.push(30)

print("......\n")

var myStackIterator = StackIterator(stack: myStack)
while let value = myStackIterator.next() {
    print(" got \(value) ")
}

print("......\n")


for value in myStack {
    
    print("for-in loop: got \(value)")
}

print("......\n")

myStack.pushAll([1, 2, 3])
for value in myStack{
    print("after pushing got: \(value)")
}

print("......\n")

var myOtherStack = Stack<Int>()
myOtherStack.pushAll([1, 2, 3])
myStack.pushAll(myOtherStack)
for value in myStack {
    
    print("after pushing items onto stack, got \(value)")
    
}

var filteredStack = myStack.filter {$0 == 1}
for value in filteredStack {
    print("filtered values: \(value)")
}

var find = myStack.findAll([5,3,7,3,9], 3)
var find1 = myStack.findAll(["Hello", "Bonjour", "Whats Up"], "Bonjour")


print("Position: [\(find)]")

var myCollection = Stack<Int>()
var collection = [1:"Yankees", 2:"HomeRuns", 3:"AaronJudge"]
myCollection.CheckAnyCollection(in: collection, for: 3)
