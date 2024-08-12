//
//  Alert.swift
//  CoinTracker
//
//  Created by Vladislav on 16.07.2024.
//

import SwiftUI
import Combine

class AlertManager: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func show(message: String) {
        alertMessage = message
        withAnimation(.easeInOut(duration: 0.5)) {
            showAlert = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.showAlert = false
            }
        }
    }
}

struct AlertView: View {
    @ObservedObject var alertManager: AlertManager
    let ticker: Ticker
    
    var body: some View {
        VStack {
            if alertManager.showAlert {
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color("alertColor"))
                    .frame(height: 40)
                    .padding()
                    .overlay {
                        Text(alertManager.alertMessage)
                            .foregroundStyle(.black)
                            .font(.subheadline).bold()
                            .padding()
                    }
                    .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}
