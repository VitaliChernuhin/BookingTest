//
//  ViewModelBaseBindable.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

import Combine

protocol ViewModelBaseBinding: AnyObject, ViewEventHandling, ViewActionHandling, Bindable, CancelableOwner {
    
    var onAppearSubject: PassthroughSubject<Void, Never> { get }
}

extension ViewModelBaseBinding {
    
    func handle(event: ViewEvent) {
        switch event {
        case .onAppear:
            
            bindInput()
            bindOutput()
            
            onAppearSubject.send(())
        }
    }
    
    func bindInput() {}
    func bindOutput() {}
}
