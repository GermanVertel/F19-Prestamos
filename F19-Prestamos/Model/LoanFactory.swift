//
//  LoanFactory.swift
//  F19-Prestamos
//
//  Created by German David Vertel Narvaez on 19/06/24.
//

import Foundation

class LoanFactory: Decodable, ObservableObject {
    
    private var downloadedLoans: [Loan] = []
    
    @Published var loans: [Loan] = []
    
    
    enum CodingKeys: CodingKey {
    case loans
    }
    
    //MARK: Constructores
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.loans = try container.decode([Loan].self, forKey: .loans)
    }
    
       
    init() {
        self.loans = []
    }
    
    //MARK: Descarga de la API
    private static var apiUrl = "https://api.kivaws.org/v1/loans/newest.json"
    
    //metodo para conectar a la api utilizando una URLsession
    func fetchFromApi(){
        guard let url = URL(string: LoanFactory.apiUrl) else {
            return
        }
        // se crea la peticion web
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            //caso donde hay un error en la descarga
            if let error = error {
                print(error)
                return
            }
            
            //Caso donde nos llega el JSON correctamente
            if let data = data {
                DispatchQueue.main.async {
                    self.downloadedLoans = self.parseJson(data: data)
                }
            }
        }
        //arrancara el procesamiento de la tarea
        task.resume()
        
    }
    
    
    
    func parseJson(data: Data) -> [Loan]{
        let decoder = JSONDecoder()
       
        do {
            let loanFactory = try decoder.decode(LoanFactory.self, from: data)
            self.loans = loanFactory.loans
        } catch {
            print(error)
        }
        return self.loans
    }
    
    //MARK: FILTRADO DE LOS PRESTAMOS
    
    func filterLoans(maxAmount: Int){
        self.loans = self.downloadedLoans.filter {$0.amount < maxAmount }
    }
    
    
}
