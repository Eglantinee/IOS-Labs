//
//  BookViewController.swift
//  App
//
//  Created by Ivan on 24.04.2021.
//
import UIKit

class BookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    struct BookList: Codable {
        let books: [Book]
    }
    
    struct Book: Codable {
        let title: String;
        let subtitle: String;
        let isbn13: String;
        let price: String;
        let image: String;
        let authors, publisher, pages, year, rating, desc: String?
        var bookImage: UIImage {
            return UIImage(systemName: "book.fill") ?? UIImage()
        }
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//        if (self.searchedBooks.count)
//        {
//            nbf.isHidden = false
//        }
//        else {
//            nbf.isHidden = true
//        }
//        return 1
//
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
       
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {
                    return UITableViewCell()
                }
                
                let book = books[indexPath.row]
                cell.setUp(book: book)
                
                return cell
            }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        let selectedBookID = books[indexPath.row].isbn13
        loadBookInfo(with: selectedBookID)
       
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            if searching {
//                let deletedBook = searchedBooks.remove(at: indexPath.row)
//                books.removeAll { $0.isbn13 == deletedBook.isbn13 }
//            } else {
//                books.remove(at: indexPath.row)
//            }
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nbf: UILabel!
    @IBOutlet weak var bookActivityIndicator: UIActivityIndicatorView!
    var books: [Book] = []
      
    override func viewDidLoad() {
        super.viewDidLoad()
        nbf.isHidden = true
        searchBar.delegate = self
        searchBar.resignFirstResponder()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookTableViewCell")
        tableView.reloadData()
        bookActivityIndicator.hidesWhenStopped = true
        bookActivityIndicator.layer.cornerRadius = 5
    }
    
    func loadBookList(with name:String){
      
    
        guard name.count >= 3 else {
            books = []
            nbf.isHidden = false
            tableView.reloadData()
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.itbook.store"
        urlComponents.path = "/1.0/search/\(name)"
        
        guard let url = urlComponents.url else {
            return
        }
        
        bookActivityIndicator.startAnimating()
        
        URLSession(configuration: .default).dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
                    let serverResponse = try JSONDecoder().decode(BookList.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.bookActivityIndicator.stopAnimating()
                        self?.books = serverResponse.books
                        self?.nbf.isHidden = !serverResponse.books.isEmpty
                        self?.tableView.reloadData()
                    }
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        .resume()
    }
    
    func loadBookInfo(with id: String) {
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.itbook.store"
                urlComponents.path = "/1.0/books/\(id)"
                
                guard let url = urlComponents.url else {
                    return
                }
                
                bookActivityIndicator.startAnimating()
                
                URLSession(configuration: .default).dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let data = data {
                        do {
                            let serverResponse = try JSONDecoder().decode(Book.self, from: data)
                            
                            DispatchQueue.main.async {
                                self?.bookActivityIndicator.stopAnimating()
                                let controller = BookSingleController.create(book: serverResponse)
                    
                                self?.present(controller, animated: true, completion: nil)
                            }
                            
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }
                .resume()
            }
    
    @IBAction func addBook(_ sender: Any) {
        let createBook = UIAlertController(title: "New book", message: "Can not add new book", preferredStyle: .alert)

        createBook.addTextField { $0.placeholder = "Title" }
        createBook.addTextField { $0.placeholder = "Subtitle" }
        createBook.addTextField {
            $0.keyboardType = .numberPad
            $0.placeholder = "Price"
        }

        createBook.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        createBook.addAction(UIAlertAction(title: "Add", style: .default) { [weak createBook, weak self] _ in

            guard let title = createBook?.textFields?[0].text,
                  let subTitle = createBook?.textFields?[1].text,
                  let price = createBook?.textFields?[2].text else {
                return
            }

            guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  !subTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  !price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {

                let alert = UIAlertController(title: "", message: "All field should be filled", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.present(alert, animated: true)
                return
            }

            guard let intPrice = Int(price),
                  intPrice > 0 else {

                let alert = UIAlertController(title: "Invalid price", message: "Please enter correct price", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.present(alert, animated: true)
                return
            }

            self?.createBook(title: title, subtitle: subTitle, price: "$\(price)")
        })

        present(createBook, animated: true)
    }

    private func createBook(title: String, subtitle: String, price: String) {

        let newBook = Book(title: title, subtitle: subtitle, isbn13: UUID().uuidString, price: price, image: "", authors: nil, publisher: nil, pages: nil, year: nil, rating: nil, desc: nil)

        books.append(newBook)
        tableView.reloadData()
    }
}

extension BookViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty){
            nbf.isHidden = !books.isEmpty
            tableView.reloadData()
            return
        }
        print(searchText.lowercased())
        loadBookList(with: searchText.lowercased())
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
