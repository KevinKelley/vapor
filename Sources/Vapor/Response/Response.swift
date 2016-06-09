extension Response {
    /**
        Create a response with `Data`.
    */
    public init(
        status: Status,
        headers: Headers = [:],
        cookies: Cookies = [],
        data: Data = []
    ) {
        var headers = headers
        headers["Content-Length"] = "\(data.bytes.count)"
        self.init(status: status, headers: headers, body: data)
    }

    /**
        Returns a 500 error.
     */
    public init(
        headers: Headers = [:],
        cookies: Cookies = [],
        error: String
    ) {
        self.init(
            status: .internalServerError,
            headers: headers,
            cookies: cookies,
            data: error.data
        )
    }

    /**
        Returns plain text.
     */
    public init(
        status: Status,
        headers: Headers = [:],
        cookies: Cookies = [],
        text: String
    ) {
        var headers = headers
        headers["Content-Type"] = "text/plain"
        self.init(
            status: status,
            headers: headers,
            cookies: cookies,
            data: text.data
        )
    }

    /**
        Creates a redirect response with
        the 301 Status an `Location` header.
    */
    public init(
        headers: Headers = [:],
        cookies: Cookies = [],
        redirect location: String
    ) {
        let headers: Headers = [
            "Location": location
        ]
        self.init(
            status: .movedPermanently,
            headers: headers,
            cookies: cookies,
            data: []
        )
    }
}

extension Response {
    public typealias OnUpgrade = ((Stream) throws -> Void)

    public var onUpgrade: OnUpgrade? {
        get {
            return storage["on-upgrade"] as? OnUpgrade
        }
        set {
            storage["on-upgrade"] = newValue
        }
    }
}
