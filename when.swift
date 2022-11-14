// MARK: - Implementation

let otherwise = Int()

precedencegroup WhenPrecedenceGroup {
    lowerThan: ComparisonPrecedence, LogicalConjunctionPrecedence, LogicalDisjunctionPrecedence
    associativity: left
}

infix operator >> : WhenPrecedenceGroup

func >> <T> (left: Bool, right: T) -> T? {
    if left { return right } else { return nil }
}

func >> <T> (left: Int, right: T) -> T? { right }

@resultBuilder
struct WhenBuilder {
    static func buildBlock<T>(_ components: T?...) -> T {
        for component in components {
            if let unwrappedComponent = component {
                return unwrappedComponent
            }
        }
        fatalError("When statement must not fall through, add otherwise")
    }
}

func when<T>(@WhenBuilder _ content: () -> T) -> T {
    content()
}


// MARK: - Test

enum Color {
    case red
    case blue
    case green
}

let isDark = false
let isDynamic = false

let color = when {
    isDark && isDynamic >> Color.red
    isDark >> Color.blue
    otherwise >> Color.green
}

print(color)
