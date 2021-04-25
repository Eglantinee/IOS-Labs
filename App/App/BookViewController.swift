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
        var bookImage: UIImage {
            if (image.isEmpty){
                return UIImage(systemName: "book")!;
            }
            let imageData = Bundle.main.path(forResource: image, ofType: "", inDirectory: "Images")!
            return UIImage(contentsOfFile: imageData) ?? UIImage(systemName: "book")!
        }
    }

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
    
    @IBOutlet weak var tableView: UITableView!
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        books = loadBookList()
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
}

