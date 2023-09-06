//
//  ViewActionHandling.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 06.09.2023.
//

protocol ViewActionHandling {
    associatedtype ViewActionType
    
    func handle(action: ViewActionType)
}
