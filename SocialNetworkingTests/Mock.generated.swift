// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 3.3.4

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import RxSwift
@testable import SocialNetworking


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





    open func execute(username: String, password: String, givenName: String, familyName: String) -> Single<User> {
        addInvocation(.m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(Parameter<String>.value(`username`), Parameter<String>.value(`password`), Parameter<String>.value(`givenName`), Parameter<String>.value(`familyName`)))
		let perform = methodPerformValue(.m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(Parameter<String>.value(`username`), Parameter<String>.value(`password`), Parameter<String>.value(`givenName`), Parameter<String>.value(`familyName`))) as? (String, String, String, String) -> Void
		perform?(`username`, `password`, `givenName`, `familyName`)
		var __value: Single<User>
		do {
		    __value = try methodReturnValue(.m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(Parameter<String>.value(`username`), Parameter<String>.value(`password`), Parameter<String>.value(`givenName`), Parameter<String>.value(`familyName`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(username: String, password: String, givenName: String, familyName: String). Use given")
			Failure("Stub return value not specified for execute(username: String, password: String, givenName: String, familyName: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(Parameter<String>, Parameter<String>, Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(let lhsUsername, let lhsPassword, let lhsGivenname, let lhsFamilyname), .m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(let rhsUsername, let rhsPassword, let rhsGivenname, let rhsFamilyname)):
                guard Parameter.compare(lhs: lhsUsername, rhs: rhsUsername, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsGivenname, rhs: rhsGivenname, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsFamilyname, rhs: rhsFamilyname, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(username: Parameter<String>, password: Parameter<String>, givenName: Parameter<String>, familyName: Parameter<String>, willReturn: Single<User>...) -> MethodStub {
            return Given(method: .m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(`username`, `password`, `givenName`, `familyName`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(username: Parameter<String>, password: Parameter<String>, givenName: Parameter<String>, familyName: Parameter<String>, willProduce: (Stubber<Single<User>>) -> Void) -> MethodStub {
            let willReturn: [Single<User>] = []
			let given: Given = { return Given(method: .m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(`username`, `password`, `givenName`, `familyName`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<User>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(username: Parameter<String>, password: Parameter<String>, givenName: Parameter<String>, familyName: Parameter<String>) -> Verify { return Verify(method: .m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(`username`, `password`, `givenName`, `familyName`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(username: Parameter<String>, password: Parameter<String>, givenName: Parameter<String>, familyName: Parameter<String>, perform: @escaping (String, String, String, String) -> Void) -> Perform {
            return Perform(method: .m_execute__username_usernamepassword_passwordgivenName_givenNamefamilyName_familyName(`username`, `password`, `givenName`, `familyName`), performs: perform)
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

