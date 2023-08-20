//
//  ViewController.swift
//  json handling
//
//  Created by Praval Gautam on 20/08/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var changeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getData()
        
        changeBtn.layer.cornerRadius = 20.0
        
        
    }
    
    func getData() {
        let session = URLSession.shared
        let serviceURL = URL(string: "https://meme-api.com/gimme")
        
        let task = session.dataTask(with: serviceURL!) { (serviceData, serviceResponse, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            if let httpResponse = serviceResponse as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let jsonData = try? JSONSerialization.jsonObject(with: serviceData!, options: []) as? [String: Any],
                   let link = jsonData["url"] as? String,
                   let imageURL = URL(string: link),
                   let imageData = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        
        task.resume()
    }
                @IBAction func changeTapped(_ sender: Any) {

                    getData()
                }
            }
            
        
