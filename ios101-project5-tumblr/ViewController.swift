//
//  ViewController.swift

//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookdata.count
    }
    var selected = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostCellTableViewCell
        // Get the first photo in the post's photos array
        if let bookimage = bookdata[indexPath.row].formats.image_jpeg {
              let url = bookimage
            
            let title = bookdata[indexPath.row].title
            cell.configure(text: title, bImage: URL(string: url))
            print(title)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
       
        performSegue(withIdentifier: "GoDetail", sender: self)
     //   navigationController?.pushViewController(destinationVc, animated: true)
    }
var bookdata = [Book]()

    @IBOutlet weak var SearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
        //PostTable.rowHeight = UITableView.automaticDimension
        //PostTable.estimatedRowHeight = 250
        PostTable.dataSource = self
        PostTable.delegate = self
        
        fetchPosts()
    }


    @IBOutlet weak var PostTable: UITableView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoDetail" {
         //   if let indexPath = sender as? IndexPath {
               
                let destinationVc = segue.destination as! DetailViewController
              
            if let photo = bookdata[selected].formats.image_jpeg {
                      let url = photo

                let title = bookdata[selected].title
                    destinationVc.text = title
                    destinationVc.bimage = URL(string: url)
                destinationVc.book = bookdata[selected]
          //      }
                
            }
        }
    }
    
    
    
    
    func fetchPosts(urltofetch: String = "https://gutendex.com/books?topic=children") {
        let url = URL(string: urltofetch)!
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
                let d = String(data: data, encoding: .utf8)
               print(d)
                let books = try JSONDecoder().decode(BookResults.self, from: data)

                DispatchQueue.main.async { [weak self] in
                    
                    let bookresults = books.results
        
                   
                 
                    
                
                self!.bookdata = books.results
                    self!.PostTable.reloadData()
                
                
                    }
                }
              
            

           catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
extension String {
    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
}

extension ViewController: UISearchBarDelegate {
    
        
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("ButtonClick")
        fetchPosts(urltofetch: "https://gutendex.com/books?/search=%20" + (searchBar.text ?? ""))
        searchBar.text = ""
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
