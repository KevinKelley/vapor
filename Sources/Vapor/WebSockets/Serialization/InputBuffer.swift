public protocol InputBuffer {
    associatedtype Element
    mutating func next() throws -> Element?
}

public enum InputBufferError: ErrorProtocol {
    case missingByte
}

extension InputBuffer {
    public mutating func chunk(length: Int) throws -> [Element] {
        var elements: [Element] = []
        for _ in 1...length {
            guard let next = try next() else {
                throw InputBufferError.missingByte
            }
            elements.append(next)
        }
        return elements
    }
}

extension IndexingIterator: InputBuffer {}
extension AnyIterator: InputBuffer {}
extension StreamBuffer: InputBuffer {}
extension Array: InputBuffer {
    public mutating func next() -> Element? {
        guard !isEmpty else { return nil }
        return removeFirst()
    }
}
