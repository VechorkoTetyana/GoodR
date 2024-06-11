import UIKit

class GoodReadsViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case header = 0
        case rowsOfLists = 1
    }
    
    @IBOutlet weak var goodReadsUITableView: UITableView!
  
    var books: [Book] = []
    var lists: [Book] = []
    var details: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lists = bookLists()
        books = rebooks()
        details = bookDetails()
    
        configureTableView()
        }
    
    func configureTableView() {
        goodReadsUITableView.dataSource = self
        goodReadsUITableView.delegate = self
        
        goodReadsUITableView.register(UINib(nibName: "GoodReadsHeaderCell", bundle: nil), forCellReuseIdentifier: "GoodReadsHeaderCell")
        
        goodReadsUITableView.register(UINib(nibName: "GoodReadsListCell", bundle: nil), forCellReuseIdentifier: "GoodReadsListCell")
    }
    
    func present(with audioList: Book) {
        let goodReadsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        
        goodReadsViewController.bookDetails = audioList
        
        goodReadsViewController.modalPresentationStyle = .fullScreen
        
        present(goodReadsViewController, animated: true)
    }
    
    
    private func rebooks() -> [Book] {
        
        var books = [Book]()
        
        books.append(Book(
            title: "Liked Books",
            subtitle: "Books you like in any GoodReads app will show here. You can change this in Settings.",
            authors: [],
            coverImage: .smsSearch
        ))
        
        return books
    }

    private func bookLists() -> [Book] {
        
        var lists = [Book]()
        
        lists.append(Book(
            title: "Weyward",
            subtitle: "Emilia Hart - 7h 5m",
            authors: ["Emilia Hart"],
            coverImage: .weywardThumbnail
        ))
        
        lists.append(Book(
            title: "The Covenant of Water",
            subtitle: "Abraham Verghese - 2h 3m left",
            authors: ["Abraham Verghese"],
            coverImage: .covenantThumbnail
        ))
        
        lists.append(Book(
            title: "Lady Tan’s Circle of Women",
            subtitle: "Lisa See - 5h 5m",
            authors: ["Lisa See"],
            coverImage: .ladyTansCircleThumbnail
        ))
        
        lists.append(Book(
            title: "The Heaven & Earth Grocery Store",
            subtitle: "James McBride - 2h 23m",
            authors: ["James McBride"],
            coverImage: .theHeavenAndEarthThumbnail
        ))
        
        lists.append(Book(
            title: "The Echo of Old Books",
            subtitle: "Barbara Davis - 5h 2m",
            authors: ["Barbara Davis"],
            coverImage: .theEchoThumbnail
        ))
        
        lists.append(Book(
            title: "The House of Eve",
            subtitle: "Sadeqa Johnson - 4h 5m",
            authors: ["Sadeqa Johnson"],
            coverImage: .theHouseOfEveThumbnail
        ))
        
        lists.append(Book(
            title: "The Wind Knows My Name",
            subtitle: "Isabel Allende - 4h 5m",
            authors: ["Isabel Allende"],
            coverImage: .theWindKnowsMyNameThumbnail
        ))
        
        return lists
    }


private func bookDetails() -> [Book] {
    
    var details = [Book]()
    
    details.append(Book(
        title: "Weyward",
        subtitle: "Emilia Hart",
        authors: ["Emilia Hart"],
        coverImage: .bookCover1
    ))
    
    details.append(Book(
        title: "The Covenant of Water",
        subtitle: "Abraham Verghese",
        authors: ["Abraham Verghese"],
        coverImage: .bookCover2
    ))
    
    details.append(Book(
        title: "Lady Tan’s Circle of Women",
        subtitle: "Lisa See",
        authors: ["Lisa See"],
        coverImage: .bookCover3
    ))
    
    details.append(Book(
        title: "The Heaven & Earth Grocery Store",
        subtitle: "James McBride",
        authors: ["James McBride"],
        coverImage: .bookCover4
    ))
    
    details.append(Book(
        title: "The Echo of Old Books",
        subtitle: "Barbara Davis",
        authors: ["Barbara Davis"],
        coverImage: .bookCover5
    ))
    
    details.append(Book(
        title: "The House of Eve",
        subtitle: "Sadeqa Johnson",
        authors: ["Sadeqa Johnson"],
        coverImage: .bookCover6
    ))
    
    details.append(Book(
        title: "The Wind Knows My Name",
        subtitle: "Isabel Allende",
        authors: ["Isabel Allende"],
        coverImage: .bookCover7
    ))
    
    return details
    }
}


extension GoodReadsViewController: UITableViewDataSource {
   
    func numberOfSections(in goodReadsUITableView: UITableView) -> Int {
        
        Section.allCases.count
    }
    
    func tableView(_ goodReadsUITableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .header:
            return 1
        case .rowsOfLists:
            return lists.count
        }
    }
    
    func tableView(_ goodReadsUITableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let section = Section(rawValue: indexPath.section)
        else { return UITableViewCell() }
        
        switch section {
        case .header:
            let cell = goodReadsUITableView.dequeueReusableCell(withIdentifier: "GoodReadsHeaderCell", for: indexPath) as! GoodReadsHeaderCell
            if let firstBook = books.first {
                cell.configure(with: firstBook)
            }
            
            return cell
            
        case .rowsOfLists:
            guard 
                let cell = goodReadsUITableView.dequeueReusableCell(withIdentifier: "GoodReadsListCell") as? GoodReadsListCell
            else { return UITableViewCell() }
            
            let book = lists[indexPath.row]
            
            cell.configure(with: book)
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

extension GoodReadsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioList = details[indexPath.row]
        present(with: audioList)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { return 0 }
        
        switch section {
        case .header:
            return 323
        case .rowsOfLists:
            return 64
        }
    }
}

extension GoodReadsViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

