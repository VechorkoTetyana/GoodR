import UIKit

struct BookFlow {
    let title: String
    let subtitle: String
    let coverImage: UIImage
}

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    var book: BookFlow!
    var bookLists: Book!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        titleLbl.text = book.title
        subtitleLbl.text = book.subtitle
        coverImageView.image = book.coverImage
    }
    
    @IBAction func downBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func shareBtnTapped(_ sender: Any) {}
    @IBAction func saveBtnTapped(_ sender: Any) {}
    @IBAction func commentBtnTapped(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
       
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: true)
    }
}
