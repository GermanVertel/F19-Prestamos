//
//  Loan.swift
//  F19-Prestamos
//
//  Created by German David Vertel Narvaez on 19/06/24.
//

import Foundation

struct Loan: Identifiable {
    var id = UUID()
    var name: String
    var country: String
    var use: String
    var amount: Int
    
    //inicializador
    
    init(name: String, country: String, use: String, amount: Int) {
        self.name = name
        self.country = country
        self.use = use
        self.amount = amount
    }
    
}

// una buena practica es separar separar el modelo de datos de las funcionalidades, para eso creamos esta extension de loan
// se va a encargar de toda al logica relacionanda con el protocolo codable

extension Loan: Codable{
    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }
    
    enum LocationKeys: String, CodingKey {
    case country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let locationContainer = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
        self.country = try locationContainer.decode(String.self, forKey: .country)
        self.use = try container.decode(String.self, forKey: .use)
        self.amount = try container.decode(Int.self, forKey: .amount)
    }
}
    
    

