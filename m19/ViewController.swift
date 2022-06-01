//
//  ViewController.swift
//  m19
//
//  Created by Natalia Shevaldina on 12.05.2022.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    
    var item = FromTableModel(birth: 0, occupation: "", name: "", lastname: "", country: "")
    let letters = Set("QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnmЙЦУКЕНГШЩЗХФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮйцукенгшщзхъЪфывапролджэёячсмитьбю -'")
    
    @IBAction func dateDidEnd(_ sender: UITextField) {
        guard let value: Int = Int(sender.text!) else {
          //  sender.text = nil
            item.birth = 0
            return
        }
        item.birth = value
    }
    
    @IBAction func occDidEnd(_ sender: UITextField) {
        item.occupation = sender.text ?? ""
    }
    @IBAction func nameDidEnd(_ sender: UITextField) {
        item.name = sender.text ?? ""
    }
    @IBAction func lastnameDidEnd(_ sender: UITextField) {
        item.lastname = sender.text ?? ""
    }
    @IBAction func countryDidEnd(_ sender: UITextField) {
        item.country = sender.text ?? ""
    }
    
    
    let json: JsonModel = JsonModel(birth: 1987, occupation: "Artist", name: "Kiyohara", lastname: "Yukinobu", country: "Russia")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkingString() -> Bool {
        guard item.birth != 0 else {
            self.notANumber()
            return false
        }
        guard let i1 = item.name, let i2 = item.country, let i3 = item.lastname, let i4 = item.occupation else {
            notALetters()
            return false
        }
        guard letters.isSuperset(of: i1) == true && letters.isSuperset(of: i2) == true && letters.isSuperset(of: i3) == true && letters.isSuperset(of: i4) == true else {
            notALetters()
            return false
        }
        return true
    }
    
    func sendRequestAlamofire() {
        
        guard checkingString() == true else { return }
        
        AF.request(
            "https://jsonplaceholder.typicode.com/posts",
            method: .post,
            parameters: item,
            encoder: JSONParameterEncoder.default
        ).response { [weak self] response in
            guard response.error == nil else {
                self?.displayFailure()
                return
            }
            self?.displaySuccessAF()
            debugPrint(response)
        }
    }
    
    func sendRequestURLSession() {
        let jsonData = try? JSONSerialization.data(withJSONObject: [json.dictionaryRepresentation()])
        
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.displayFailure()
                }
                return
            }
            DispatchQueue.main.async {
                self?.displaySuccess()
            }
            
            let responseJson = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJson = responseJson as? [String: Any] {
                print(responseJson)
            }
        }.resume()
    }
    
    private func displayFailure() {
        let alert = UIAlertController(title: "Error", message: "An error occurred while sending data", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func displaySuccess() {
        let alert = UIAlertController(title: "Success", message: "Success with URLSession", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func displaySuccessAF() {
        let alert = UIAlertController(title: "Success", message: "Success with Alamofire", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func notANumber() {
        let alert = UIAlertController(title: "Error", message: "Please enter in numbers year of birth", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func notALetters() {
        let alert = UIAlertController(title: "Error", message: "Please enter only letters", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onButtonSession(_ sender: UIButton) {
        sendRequestURLSession()
    }
    
    @IBAction func onButtonAlamofire(_ sender: UIButton) {
        sendRequestAlamofire()
    }
    
}

