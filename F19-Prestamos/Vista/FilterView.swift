//
//  FilterView.swift
//  F19-Prestamos
//
//  Created by German David Vertel Narvaez on 19/06/24.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var maxLoan: Double
    
    var minAmount = 0.0
    var maxAmount = 1000.0
        
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Filtrar prestamos con valor inferior a $  \(Int(self.maxLoan))")
                .font(.system(.title2, design: .rounded))
                .bold()
            
            HStack{
                Text("$\(Int(minAmount))")
                    .font(.system(.callout, design: .rounded))
                
                Slider(value: self.$maxLoan, in: minAmount...maxAmount, step: 50)
                
                Text("$\(Int(maxAmount))")
                    .font(.system(.callout, design: .rounded))
                
            }
        })
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        
    }
}

#Preview {
    FilterView(maxLoan: .constant(600))
}
