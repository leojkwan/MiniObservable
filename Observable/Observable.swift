import Foundation

// An Observable that can have more than 1 subscriber.
// Must have dispose bag mechanism to deallocate multiple subscribers.
public class Observable<T: Equatable>: CustomStringConvertible {
  
  // Lock getter and setter of _value
  private let lock = NSRecursiveLock()
  
  // A callback that passes a generic value
  public typealias Event = (T) -> Void
  
  // A callback that passes a generic changed value
  public typealias ChangeEvent = (_ oldValue: T, _ newValue: T) -> Void
  
  // Observers to all events and changes
  private(set) var observers = [UUID: Event]()
  
  // Observers to only changes
  private(set) var changeObservers = [UUID: ChangeEvent]()
  
  public init(_ v: T) {
    _value = v
  }
  
  /// Observe any change in '_value'
  ///
  /// - Parameters:
  ///   - getLatest: get an immediately published event on subscribe.
  ///   - observer: an observer that listens to all changes
  ///   - Returns: the observer which can be disposed of when dispose bag observer is in becomes deallocated
  public func observe(getLatest: Bool = false, _ observer: @escaping Event)-> Disposable {
    
    let uniqueKey = UUID()
    observers[uniqueKey] = observer
    
    // Notify current observer about current value on initial subscribe.
    if getLatest {
      observer(value)
    }
    
    return Observer(owner: self, key: uniqueKey)
  }
  
  
  
  /// Observe only Equatable changes in wrapped value
  ///
  /// - Parameters:
  ///   - getLatest: get an immediately published event on subscribe.
  ///   - observer: an observer that listens to changes only Equatable changes
  /// - Returns: the observer which can be disposed of when dispose bag observer is in becomes deallocated
  public func observeChanges(getLatest: Bool = false, _ observer: @escaping ChangeEvent)-> Disposable {
    
    let uniqueKey = UUID()
    changeObservers[uniqueKey] = observer
    
    // Notify current observer about current value on initial subscribe.
    if getLatest {
      observer(value, value)
    }
    
    return Observer(owner: self, key: uniqueKey)
  }
  
  // Notify all observers that the observed value has changed it's Equatable value
  private func updateChangeObservers(oldValue: T, newValue: T) {
    for (_, changeObserver) in changeObservers {
      // iterate over all observers,
      // and call closure with new value.
      changeObserver(oldValue, newValue)
    }
  }
  
  // Notify all observers that the observed value has been set
  private func updateObservers() {
    for (_, observer) in observers {
      // iterate over all observers,
      // and call closure with new value.
      observer(_value)
    }
  }
  
  // Store reference of wrapped value
  private var _value: T
  
  public var value: T {
    get {
      lock.lock()
      defer { lock.unlock() }
      return _value
    }
    set {
      lock.lock()
      defer { lock.unlock() }
      
      let oldValue = _value
      
      if oldValue != newValue {
        updateChangeObservers(oldValue: oldValue, newValue: newValue)
      }
      
      _value = newValue
      
      updateObservers()
    }
  }
  
  deinit {
    #if DEBUG
      print("Deallocating Observables")
    #endif
  }
  
  func removeObserver(with key: UUID) {
    if observers.keys.contains(key) {
      observers.removeValue(forKey: key)
    }
    
    if changeObservers.keys.contains(key) {
      observers.removeValue(forKey: key)
    }
  }
  
  public var description: String {
    return "Observable with current value: \(value)"
  }
}


