
import RxSwift
import RxCocoa

extension PublishSubject where Element == Void {
    
    func asDriver() -> Driver<Void> {
        return asDriver(onErrorJustReturn: Void())
    }
    
    func onNext() {
        onNext(Void())
    }
}
