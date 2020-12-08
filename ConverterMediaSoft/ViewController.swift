//
//  ViewController.swift
//  ConverterMediaSoft
//
//  Created by Alexander Nazarov on 07.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    var rubCurrency: [String] = []
    var rubCurrencyValue: [Double] = []
    var rub: Double?
    
    
    
    @IBOutlet weak var usdText: UITextField!
    
    @IBOutlet weak var rubText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    //Кнопка OK(CONVERT)
    @IBAction func buttonOk(_ sender: Any) {
        
        convertCarrently()
        
        //Проверка на текст
        if let text = usdText.text, let rubble = rub, !text.isEmpty
        {
            rubText.text = String(format:"%.2f", Double(text)! * rubble)
        } else {
            print("error")
        }
    }
    
    // Проверка URL
    func convertCarrently() {
        guard let url = URL(string: "https://open.exchangerate-api.com/v6/latest") else { return }
        
        // Создаем сессию
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let response = response
            else { return }
            do {
                let json = try JSONDecoder().decode(Rates.self, from: data)
                self.rubCurrency.append(contentsOf: json.rates.keys)
                self.rubCurrencyValue.append(contentsOf: json.rates.values)
                self.rub = json.rates["RUB"]
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
}


