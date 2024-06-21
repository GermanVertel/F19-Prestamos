//
//  ContentView.swift
//  F19-Prestamos
//
//  Created by German David Vertel Narvaez on 17/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var loanFactory = LoanFactory()
    
    @State private var showFilter = true
    @State private var maxAmount = 1000.0
    
    var body: some View {
        NavigationStack{
            
            VStack{
                if showFilter {
                    FilterView(maxLoan: self.$maxAmount)
                        .transition(.opacity)
                    
                }
            }
            
            List(self.loanFactory.loans){ loan in
                CellView(loan: loan)
                    .padding(.vertical, 8)
                               
            }
            .navigationTitle("Prestamos de Kiva")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        withAnimation(.linear){
                            self.showFilter.toggle()
                            self.loanFactory
                                .filterLoans(maxAmount: Int(self.maxAmount))
                        }
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title)
                            .padding(15)
                    }
                }
            }
        }
        .task {
            self.loanFactory.fetchFromApi()
        }
    }
}

#Preview {
    ContentView()
}
