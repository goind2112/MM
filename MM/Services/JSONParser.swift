//
//  JSONParser.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 27.12.2022.
//

import Foundation

class JSONParser {
    
    func request(completion: @escaping (ValuteModel?, Error?)-> Void){
        let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Sistem: \"\(error.localizedDescription)\"")
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                do {
                    let valut = try JSONDecoder().decode(ValuteModel.self, from: data)
                    completion(valut, nil)
                } catch {
                    print("Sistem: \"\(error.localizedDescription)\"")
                }
            }
        }.resume()
    }
}
