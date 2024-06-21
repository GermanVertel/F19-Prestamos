//
//  CellView.swift
//  F19-Prestamos
//
//  Created by German David Vertel Narvaez on 19/06/24.
//

import SwiftUI

struct CellView: View {
    
    var loan: Loan
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading, content: {
                Text(loan.name)
                    .font(.system(.title2, design: .rounded))
                    .bold()
                
                Text(loan.country)
                    .font(.system(.subheadline, design: .rounded))
                
                Text(loan.use)
                    .font(.system(.caption, design: .rounded))
            })
            
            Spacer()
            
                Text("$ \(loan.amount)")
                    .font(.system(.title, design: .rounded))
                    .bold()
            
        }.padding()
    }
}

#Preview {
    CellView(loan: Loan(name: "German David", country: "Colombia", use: "para construir un colegio", amount: 270))
}
