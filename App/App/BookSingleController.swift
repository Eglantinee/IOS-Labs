//
//  BookSingleController.swift
//  App
//
//  Created by Ivan on 07.05.2021.
//

import UIKit

class BookSingleController: UIViewController {
    
    static func create(book: BookViewController.Book) -> BookSingleController {
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main) .instantiateViewController(withIdentifier: "BookSingleController") as! BookSingleController
        controller.book = book
        print(controller)
        return controller
    }
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleSingle: BookSingleView!
    @IBOutlet weak var subtitleSingle: BookSingleView!
    @IBOutlet weak var yearSingle: BookSingleView!
    @IBOutlet weak var pagesSingle: BookSingleView!
    @IBOutlet weak var publisherSingle: BookSingleView!
    @IBOutlet weak var authorsSingle: BookSingleView!
    @IBOutlet weak var descSingle: BookSingleView!
    @IBOutlet weak var ratingSingle: BookSingleView!
    
    
    var book: BookViewController.Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let book = book else {
            return
        }
        bookImageView.sd_setImage(with: URL(string: book.image), placeholderImage: book.bookImage)
        titleSingle.setup(with: book.title, description: "Title")
        subtitleSingle.setup(with: book.subtitle, description: "Subtitle")
        
        if let description = book.desc {
            descSingle.setup(with: description, description: "Description")
        } else {
            descSingle.isHidden = true
        }
        
        if let authors = book.authors {
            authorsSingle.setup(with: authors, description: "Authors")
        } else {
            authorsSingle.isHidden = true
        }

        if let publisher = book.publisher {
            publisherSingle.setup(with: publisher, description: "Publisher")
        } else {
            publisherSingle.isHidden = true
        }

        if let pages = book.pages {
            pagesSingle.setup(with: pages, description: "Pages")
        } else {
            pagesSingle.isHidden = true
        }

        if let year = book.year {
            yearSingle.setup(with: year, description: "Year")
        } else {
            yearSingle.isHidden = true
        }
        
        if let rating = book.rating {
            ratingSingle.setup(with: rating, description: "Rating")
        } else {
            ratingSingle.isHidden = true
        }
    }
}
