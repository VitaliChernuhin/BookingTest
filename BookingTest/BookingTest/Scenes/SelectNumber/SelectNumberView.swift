//
//  SelectNumberView.swift
//  BookingTest
//
//  Created by Vit Chernuhin on 11.09.2023.
//

import SwiftUI

// MARK: SelectNumberViewAction
enum SelectNumberViewAction {
    case back
}

// MARK: - SelectNumberView
struct SelectNumberView<TViewModel: SelectNumberViewModelProtocol>: View where TViewModel.ViewActionType == SelectNumberViewAction {
    
    @ObservedObject private var viewModel: TViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    
    init(viewModel: TViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            NavigationTitledView(title: viewModel.hotelName) {
                viewModel.handle(action: .back)
                presentationMode.wrappedValue.dismiss()
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

// MARK: Preview
struct SelectNumberView_Previews: PreviewProvider {
    
    @State static var hotelName = "Название отеля"
    
    static var previews: some View {
        let viewModel = SelectNumberViewModel(hotelName: hotelName, roomsProvider: ServicesFactory.shared.service(type: RoomsProviding.self), imagesProvider: ServicesFactory.shared.service(type: ImagesProviding.self))
        SelectNumberView(viewModel: viewModel)
    }
}
