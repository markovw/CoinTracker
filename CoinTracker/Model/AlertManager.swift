//
//  Alert.swift
//  CoinTracker
//
//  Created by Vladislav on 16.07.2024.
//

import SwiftUI

class AlertManager: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func show(message: String) {
        alertMessage = message
        withAnimation {
            showAlert = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            withAnimation(.easeOut) {
                self.showAlert = false
            }
            
        }
    }
}

struct AlertView: View {
    @ObservedObject var alertManager: AlertManager
    
    var body: some View {
        if alertManager.showAlert {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray).opacity(0.2)
                    .frame(height: 40)
                    .padding()
                    .overlay {
                        Text(alertManager.alertMessage).font(.headline)
                    }
            }
            .animation(.spring, value: alertManager.showAlert)
            .transition(.move(edge: .bottom))
        }
    }
}
