// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 3.3.4

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import RxSwift
@testable import SocialNetworking


// MARK: - Clock
open class ClockMock: Clock, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func now() -> Date {
        addInvocation(.m_now)
		let perform = methodPerformValue(.m_now) as? () -> Void
		perform?()
		var __value: Date
		do {
		    __value = try methodReturnValue(.m_now).casted()
		} catch {
			onFatalFailure("Stub return value not specified for now(). Use given")
			Failure("Stub return value not specified for now(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_now

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_now, .m_now):
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_now: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func now(willReturn: Date...) -> MethodStub {
            return Given(method: .m_now, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func now(willProduce: (Stubber<Date>) -> Void) -> MethodStub {
            let willReturn: [Date] = []
			let given: Given = { return Given(method: .m_now, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Date).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func now() -> Verify { return Verify(method: .m_now)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func now(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_now, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - CreatePost
open class CreatePostMock: CreatePost, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func execute(userId: UUID, text: String) -> Single<Post> {
        addInvocation(.m_execute__userId_userIdtext_text(Parameter<UUID>.value(`userId`), Parameter<String>.value(`text`)))
		let perform = methodPerformValue(.m_execute__userId_userIdtext_text(Parameter<UUID>.value(`userId`), Parameter<String>.value(`text`))) as? (UUID, String) -> Void
		perform?(`userId`, `text`)
		var __value: Single<Post>
		do {
		    __value = try methodReturnValue(.m_execute__userId_userIdtext_text(Parameter<UUID>.value(`userId`), Parameter<String>.value(`text`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(userId: UUID, text: String). Use given")
			Failure("Stub return value not specified for execute(userId: UUID, text: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__userId_userIdtext_text(Parameter<UUID>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_execute__userId_userIdtext_text(let lhsUserid, let lhsText), .m_execute__userId_userIdtext_text(let rhsUserid, let rhsText)):
                guard Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__userId_userIdtext_text(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(userId: Parameter<UUID>, text: Parameter<String>, willReturn: Single<Post>...) -> MethodStub {
            return Given(method: .m_execute__userId_userIdtext_text(`userId`, `text`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(userId: Parameter<UUID>, text: Parameter<String>, willProduce: (Stubber<Single<Post>>) -> Void) -> MethodStub {
            let willReturn: [Single<Post>] = []
			let given: Given = { return Given(method: .m_execute__userId_userIdtext_text(`userId`, `text`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<Post>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(userId: Parameter<UUID>, text: Parameter<String>) -> Verify { return Verify(method: .m_execute__userId_userIdtext_text(`userId`, `text`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(userId: Parameter<UUID>, text: Parameter<String>, perform: @escaping (UUID, String) -> Void) -> Perform {
            return Perform(method: .m_execute__userId_userIdtext_text(`userId`, `text`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - IdGenerator
open class IdGeneratorMock: IdGenerator, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func next() -> UUID {
        addInvocation(.m_next)
		let perform = methodPerformValue(.m_next) as? () -> Void
		perform?()
		var __value: UUID
		do {
		    __value = try methodReturnValue(.m_next).casted()
		} catch {
			onFatalFailure("Stub return value not specified for next(). Use given")
			Failure("Stub return value not specified for next(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_next

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_next, .m_next):
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_next: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func next(willReturn: UUID...) -> MethodStub {
            return Given(method: .m_next, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func next(willProduce: (Stubber<UUID>) -> Void) -> MethodStub {
            let willReturn: [UUID] = []
			let given: Given = { return Given(method: .m_next, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UUID).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func next() -> Verify { return Verify(method: .m_next)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func next(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_next, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - LanguageService
open class LanguageServiceMock: LanguageService, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func isInappropriate(_ text: String) -> Bool {
        addInvocation(.m_isInappropriate__text(Parameter<String>.value(`text`)))
		let perform = methodPerformValue(.m_isInappropriate__text(Parameter<String>.value(`text`))) as? (String) -> Void
		perform?(`text`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_isInappropriate__text(Parameter<String>.value(`text`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for isInappropriate(_ text: String). Use given")
			Failure("Stub return value not specified for isInappropriate(_ text: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_isInappropriate__text(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_isInappropriate__text(let lhsText), .m_isInappropriate__text(let rhsText)):
                guard Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_isInappropriate__text(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func isInappropriate(_ text: Parameter<String>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_isInappropriate__text(`text`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func isInappropriate(_ text: Parameter<String>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_isInappropriate__text(`text`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func isInappropriate(_ text: Parameter<String>) -> Verify { return Verify(method: .m_isInappropriate__text(`text`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func isInappropriate(_ text: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_isInappropriate__text(`text`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - LoginUser
open class LoginUserMock: LoginUser, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func execute(credentials: UserCredentials) -> Single<User> {
        addInvocation(.m_execute__credentials_credentials(Parameter<UserCredentials>.value(`credentials`)))
		let perform = methodPerformValue(.m_execute__credentials_credentials(Parameter<UserCredentials>.value(`credentials`))) as? (UserCredentials) -> Void
		perform?(`credentials`)
		var __value: Single<User>
		do {
		    __value = try methodReturnValue(.m_execute__credentials_credentials(Parameter<UserCredentials>.value(`credentials`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(credentials: UserCredentials). Use given")
			Failure("Stub return value not specified for execute(credentials: UserCredentials). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__credentials_credentials(Parameter<UserCredentials>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_execute__credentials_credentials(let lhsCredentials), .m_execute__credentials_credentials(let rhsCredentials)):
                guard Parameter.compare(lhs: lhsCredentials, rhs: rhsCredentials, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__credentials_credentials(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(credentials: Parameter<UserCredentials>, willReturn: Single<User>...) -> MethodStub {
            return Given(method: .m_execute__credentials_credentials(`credentials`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(credentials: Parameter<UserCredentials>, willProduce: (Stubber<Single<User>>) -> Void) -> MethodStub {
            let willReturn: [Single<User>] = []
			let given: Given = { return Given(method: .m_execute__credentials_credentials(`credentials`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<User>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(credentials: Parameter<UserCredentials>) -> Verify { return Verify(method: .m_execute__credentials_credentials(`credentials`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(credentials: Parameter<UserCredentials>, perform: @escaping (UserCredentials) -> Void) -> Perform {
            return Perform(method: .m_execute__credentials_credentials(`credentials`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - PostRepository
open class PostRepositoryMock: PostRepository, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func add(_ post: Post) -> Completable {
        addInvocation(.m_add__post(Parameter<Post>.value(`post`)))
		let perform = methodPerformValue(.m_add__post(Parameter<Post>.value(`post`))) as? (Post) -> Void
		perform?(`post`)
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_add__post(Parameter<Post>.value(`post`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for add(_ post: Post). Use given")
			Failure("Stub return value not specified for add(_ post: Post). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_add__post(Parameter<Post>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_add__post(let lhsPost), .m_add__post(let rhsPost)):
                guard Parameter.compare(lhs: lhsPost, rhs: rhsPost, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_add__post(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func add(_ post: Parameter<Post>, willReturn: Completable...) -> MethodStub {
            return Given(method: .m_add__post(`post`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func add(_ post: Parameter<Post>, willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_add__post(`post`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func add(_ post: Parameter<Post>) -> Verify { return Verify(method: .m_add__post(`post`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func add(_ post: Parameter<Post>, perform: @escaping (Post) -> Void) -> Perform {
            return Perform(method: .m_add__post(`post`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - PostService
open class PostServiceMock: PostService, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func createPost(userId: UUID, text: String) -> Single<Post> {
        addInvocation(.m_createPost__userId_userIdtext_text(Parameter<UUID>.value(`userId`), Parameter<String>.value(`text`)))
		let perform = methodPerformValue(.m_createPost__userId_userIdtext_text(Parameter<UUID>.value(`userId`), Parameter<String>.value(`text`))) as? (UUID, String) -> Void
		perform?(`userId`, `text`)
		var __value: Single<Post>
		do {
		    __value = try methodReturnValue(.m_createPost__userId_userIdtext_text(Parameter<UUID>.value(`userId`), Parameter<String>.value(`text`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createPost(userId: UUID, text: String). Use given")
			Failure("Stub return value not specified for createPost(userId: UUID, text: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_createPost__userId_userIdtext_text(Parameter<UUID>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_createPost__userId_userIdtext_text(let lhsUserid, let lhsText), .m_createPost__userId_userIdtext_text(let rhsUserid, let rhsText)):
                guard Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_createPost__userId_userIdtext_text(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func createPost(userId: Parameter<UUID>, text: Parameter<String>, willReturn: Single<Post>...) -> MethodStub {
            return Given(method: .m_createPost__userId_userIdtext_text(`userId`, `text`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createPost(userId: Parameter<UUID>, text: Parameter<String>, willProduce: (Stubber<Single<Post>>) -> Void) -> MethodStub {
            let willReturn: [Single<Post>] = []
			let given: Given = { return Given(method: .m_createPost__userId_userIdtext_text(`userId`, `text`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<Post>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createPost(userId: Parameter<UUID>, text: Parameter<String>) -> Verify { return Verify(method: .m_createPost__userId_userIdtext_text(`userId`, `text`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createPost(userId: Parameter<UUID>, text: Parameter<String>, perform: @escaping (UUID, String) -> Void) -> Perform {
            return Perform(method: .m_createPost__userId_userIdtext_text(`userId`, `text`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - RegisterUser
open class RegisterUserMock: RegisterUser, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func execute(data: RegistrationData) -> Single<User> {
        addInvocation(.m_execute__data_data(Parameter<RegistrationData>.value(`data`)))
		let perform = methodPerformValue(.m_execute__data_data(Parameter<RegistrationData>.value(`data`))) as? (RegistrationData) -> Void
		perform?(`data`)
		var __value: Single<User>
		do {
		    __value = try methodReturnValue(.m_execute__data_data(Parameter<RegistrationData>.value(`data`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(data: RegistrationData). Use given")
			Failure("Stub return value not specified for execute(data: RegistrationData). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__data_data(Parameter<RegistrationData>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_execute__data_data(let lhsData), .m_execute__data_data(let rhsData)):
                guard Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__data_data(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(data: Parameter<RegistrationData>, willReturn: Single<User>...) -> MethodStub {
            return Given(method: .m_execute__data_data(`data`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(data: Parameter<RegistrationData>, willProduce: (Stubber<Single<User>>) -> Void) -> MethodStub {
            let willReturn: [Single<User>] = []
			let given: Given = { return Given(method: .m_execute__data_data(`data`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<User>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(data: Parameter<RegistrationData>) -> Verify { return Verify(method: .m_execute__data_data(`data`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(data: Parameter<RegistrationData>, perform: @escaping (RegistrationData) -> Void) -> Perform {
            return Perform(method: .m_execute__data_data(`data`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - UserRepository
open class UserRepositoryMock: UserRepository, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func add(_ user: User) -> Completable {
        addInvocation(.m_add__user(Parameter<User>.value(`user`)))
		let perform = methodPerformValue(.m_add__user(Parameter<User>.value(`user`))) as? (User) -> Void
		perform?(`user`)
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_add__user(Parameter<User>.value(`user`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for add(_ user: User). Use given")
			Failure("Stub return value not specified for add(_ user: User). Use given")
		}
		return __value
    }

    open func isUsernameTaken(_ username: String) -> Single<Bool> {
        addInvocation(.m_isUsernameTaken__username(Parameter<String>.value(`username`)))
		let perform = methodPerformValue(.m_isUsernameTaken__username(Parameter<String>.value(`username`))) as? (String) -> Void
		perform?(`username`)
		var __value: Single<Bool>
		do {
		    __value = try methodReturnValue(.m_isUsernameTaken__username(Parameter<String>.value(`username`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for isUsernameTaken(_ username: String). Use given")
			Failure("Stub return value not specified for isUsernameTaken(_ username: String). Use given")
		}
		return __value
    }

    open func user(for credentials: UserCredentials) -> Single<User?> {
        addInvocation(.m_user__for_credentials(Parameter<UserCredentials>.value(`credentials`)))
		let perform = methodPerformValue(.m_user__for_credentials(Parameter<UserCredentials>.value(`credentials`))) as? (UserCredentials) -> Void
		perform?(`credentials`)
		var __value: Single<User?>
		do {
		    __value = try methodReturnValue(.m_user__for_credentials(Parameter<UserCredentials>.value(`credentials`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for user(for credentials: UserCredentials). Use given")
			Failure("Stub return value not specified for user(for credentials: UserCredentials). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_add__user(Parameter<User>)
        case m_isUsernameTaken__username(Parameter<String>)
        case m_user__for_credentials(Parameter<UserCredentials>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_add__user(let lhsUser), .m_add__user(let rhsUser)):
                guard Parameter.compare(lhs: lhsUser, rhs: rhsUser, with: matcher) else { return false } 
                return true 
            case (.m_isUsernameTaken__username(let lhsUsername), .m_isUsernameTaken__username(let rhsUsername)):
                guard Parameter.compare(lhs: lhsUsername, rhs: rhsUsername, with: matcher) else { return false } 
                return true 
            case (.m_user__for_credentials(let lhsCredentials), .m_user__for_credentials(let rhsCredentials)):
                guard Parameter.compare(lhs: lhsCredentials, rhs: rhsCredentials, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_add__user(p0): return p0.intValue
            case let .m_isUsernameTaken__username(p0): return p0.intValue
            case let .m_user__for_credentials(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func add(_ user: Parameter<User>, willReturn: Completable...) -> MethodStub {
            return Given(method: .m_add__user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func isUsernameTaken(_ username: Parameter<String>, willReturn: Single<Bool>...) -> MethodStub {
            return Given(method: .m_isUsernameTaken__username(`username`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func user(for credentials: Parameter<UserCredentials>, willReturn: Single<User?>...) -> MethodStub {
            return Given(method: .m_user__for_credentials(`credentials`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func add(_ user: Parameter<User>, willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_add__user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
        public static func isUsernameTaken(_ username: Parameter<String>, willProduce: (Stubber<Single<Bool>>) -> Void) -> MethodStub {
            let willReturn: [Single<Bool>] = []
			let given: Given = { return Given(method: .m_isUsernameTaken__username(`username`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<Bool>).self)
			willProduce(stubber)
			return given
        }
        public static func user(for credentials: Parameter<UserCredentials>, willProduce: (Stubber<Single<User?>>) -> Void) -> MethodStub {
            let willReturn: [Single<User?>] = []
			let given: Given = { return Given(method: .m_user__for_credentials(`credentials`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<User?>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func add(_ user: Parameter<User>) -> Verify { return Verify(method: .m_add__user(`user`))}
        public static func isUsernameTaken(_ username: Parameter<String>) -> Verify { return Verify(method: .m_isUsernameTaken__username(`username`))}
        public static func user(for credentials: Parameter<UserCredentials>) -> Verify { return Verify(method: .m_user__for_credentials(`credentials`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func add(_ user: Parameter<User>, perform: @escaping (User) -> Void) -> Perform {
            return Perform(method: .m_add__user(`user`), performs: perform)
        }
        public static func isUsernameTaken(_ username: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_isUsernameTaken__username(`username`), performs: perform)
        }
        public static func user(for credentials: Parameter<UserCredentials>, perform: @escaping (UserCredentials) -> Void) -> Perform {
            return Perform(method: .m_user__for_credentials(`credentials`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - UserService
open class UserServiceMock: UserService, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func registerUser(data: RegistrationData) -> Single<User> {
        addInvocation(.m_registerUser__data_data(Parameter<RegistrationData>.value(`data`)))
		let perform = methodPerformValue(.m_registerUser__data_data(Parameter<RegistrationData>.value(`data`))) as? (RegistrationData) -> Void
		perform?(`data`)
		var __value: Single<User>
		do {
		    __value = try methodReturnValue(.m_registerUser__data_data(Parameter<RegistrationData>.value(`data`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for registerUser(data: RegistrationData). Use given")
			Failure("Stub return value not specified for registerUser(data: RegistrationData). Use given")
		}
		return __value
    }

    open func loginUser(credentials: UserCredentials) -> Single<User> {
        addInvocation(.m_loginUser__credentials_credentials(Parameter<UserCredentials>.value(`credentials`)))
		let perform = methodPerformValue(.m_loginUser__credentials_credentials(Parameter<UserCredentials>.value(`credentials`))) as? (UserCredentials) -> Void
		perform?(`credentials`)
		var __value: Single<User>
		do {
		    __value = try methodReturnValue(.m_loginUser__credentials_credentials(Parameter<UserCredentials>.value(`credentials`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for loginUser(credentials: UserCredentials). Use given")
			Failure("Stub return value not specified for loginUser(credentials: UserCredentials). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_registerUser__data_data(Parameter<RegistrationData>)
        case m_loginUser__credentials_credentials(Parameter<UserCredentials>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_registerUser__data_data(let lhsData), .m_registerUser__data_data(let rhsData)):
                guard Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher) else { return false } 
                return true 
            case (.m_loginUser__credentials_credentials(let lhsCredentials), .m_loginUser__credentials_credentials(let rhsCredentials)):
                guard Parameter.compare(lhs: lhsCredentials, rhs: rhsCredentials, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_registerUser__data_data(p0): return p0.intValue
            case let .m_loginUser__credentials_credentials(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func registerUser(data: Parameter<RegistrationData>, willReturn: Single<User>...) -> MethodStub {
            return Given(method: .m_registerUser__data_data(`data`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func loginUser(credentials: Parameter<UserCredentials>, willReturn: Single<User>...) -> MethodStub {
            return Given(method: .m_loginUser__credentials_credentials(`credentials`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func registerUser(data: Parameter<RegistrationData>, willProduce: (Stubber<Single<User>>) -> Void) -> MethodStub {
            let willReturn: [Single<User>] = []
			let given: Given = { return Given(method: .m_registerUser__data_data(`data`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<User>).self)
			willProduce(stubber)
			return given
        }
        public static func loginUser(credentials: Parameter<UserCredentials>, willProduce: (Stubber<Single<User>>) -> Void) -> MethodStub {
            let willReturn: [Single<User>] = []
			let given: Given = { return Given(method: .m_loginUser__credentials_credentials(`credentials`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<User>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func registerUser(data: Parameter<RegistrationData>) -> Verify { return Verify(method: .m_registerUser__data_data(`data`))}
        public static func loginUser(credentials: Parameter<UserCredentials>) -> Verify { return Verify(method: .m_loginUser__credentials_credentials(`credentials`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func registerUser(data: Parameter<RegistrationData>, perform: @escaping (RegistrationData) -> Void) -> Perform {
            return Perform(method: .m_registerUser__data_data(`data`), performs: perform)
        }
        public static func loginUser(credentials: Parameter<UserCredentials>, perform: @escaping (UserCredentials) -> Void) -> Perform {
            return Perform(method: .m_loginUser__credentials_credentials(`credentials`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

