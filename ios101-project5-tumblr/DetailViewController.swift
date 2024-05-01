//
//  DetailViewController.swift
//  ios101-project5-tumblr
//
//  Created by Mike Gomez on 3/28/24.
//

import UIKit
import Nuke
class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        if Words == nil {
            print("isNill")
        }
        else {
            if let url = bimage {
               
              Words.text = text
               Nuke.loadImage(with: url, into: Picture)
                print(book)
                fetchtext(url: (book?.formats.text_plain_charset_us_ascii)!)
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var Words: UITextView!
    
    @IBOutlet weak var Picture: UIImageView!
    var text = "Text"
    var bimage: URL? = nil
    var book: Book? = nil
    
    func fetchtext(url: String) {
        let url = URL(string: url)!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let booktext = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    let split = "*** START OF THE PROJECT GUTENBERG EBOOK"
                    guard let editedtext =  booktext?.components(separatedBy: split) else {
                        print("error")
                        return
                    }
                    
                    if editedtext.count > 1 {
                        
                        
                        self.Words.text = editedtext[1]
                    }
                    else {
                        self.Words.text = booktext!
                    }
                }
              
                }
              
            

           catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
    
    
    

