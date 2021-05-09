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
            if (image.isEmpty){
                return UIImage(systemName: "book")!;
            }
            let imageData = Bundle.main.path(forResource: image, ofType: "", inDirectory: "Images")!
            return UIImage(contentsOfFile: imageData) ?? UIImage(systemName: "book")!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        if (self.searchedBooks.count == 0 && self.searching)
        {
            nbf.isHidden = false
        }
        else {
            nbf.isHidden = true
        }
        return 1

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchedBooks.count : books.count
    }
       
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        let book = searching ? searchedBooks[indexPath.row] : books[indexPath.row]
        cell.setUp(book: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        let selectedBookID = searching ? searchedBooks[indexPath.row].isbn13 : books[indexPath.row].isbn13
        
        if let singleBook = loadBookInfo(with: selectedBookID) {
            let controller = BookSingleController.create(book: singleBook)
            self.present(controller, animated: true, completion: nil)
        }
       
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if searching {
                let deletedBook = searchedBooks.remove(at: indexPath.row)
                books.removeAll { $0.isbn13 == deletedBook.isbn13 }
            } else {
                books.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nbf: UILabel!
    var books: [Book] = []
    var searchedBooks: [Book] = []
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nbf.isHidden = true
        books = loadBookList()
        searchBar.delegate = self
        searchBar.resignFirstResponder()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookTableViewCell")
        tableView.reloadData()
    }
    
    func loadBookList() -> [Book] {
        do {
        let path = Bundle.main.path(forResource: "BooksList", ofType: "txt")!
        let encodedData = try String(contentsOfFile: path, encoding: String.Encoding.utf8).data(using: .utf8)
        let decodedData = try JSONDecoder().decode(BookList.self, from: encodedData!)
        return decodedData.books;
        } catch {
            print("Error in processing with BooksList")
        }
        return [];
    }
    
    func loadBookInfo(with id: String) -> Book? {
        if id.isEmpty {
            return nil
        }
            do {
                if let path = Bundle.main.path(forResource: id, ofType: "txt", inDirectory: "Books"),
                   let encodedData = try String(contentsOfFile: path, encoding: String.Encoding.utf8).data(using: .utf8) {
                        print("I found data")
                    let decodedData = try JSONDecoder().decode(Book.self, from: encodedData)
                    return decodedData
                }
            } catch let error {
                print(error.localizedDescription)
            }
            return nil
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
        searchedBooks = books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        searching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searching = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
