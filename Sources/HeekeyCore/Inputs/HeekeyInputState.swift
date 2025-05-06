public protocol HeekeyInputState {
    var string: String { get }
    var isEmpty: Bool { get }

    associatedtype Action
    func dispatch(action: Action) -> (String, Self)
}
