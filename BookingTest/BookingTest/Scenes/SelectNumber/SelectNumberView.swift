//
//  SelectNumberView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import SwiftUI

// MARK: SelectNumberViewAction
enum SelectNumberViewAction {
    
}

// MARK: - SelectNumberView
struct SelectNumberView<TViewModel: SelectNumberViewModelProtocol>: View where TViewModel.ViewActionType == SelectNumberViewAction {
    
    @ObservedObject private var viewModel: TViewModel
    
    @State private var imageIndex: Int = 0
    
    init(viewModel: TViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

// MARK: Preview
struct SelectNumberView_Previews: PreviewProvider {
    
    @State static var hotelName = "Название отеля"
    
    static var previews: some View {
        let viewModel = SelectNumberViewModel(hotelName: hotelName)
        SelectNumberView(viewModel: viewModel)
    }
}
