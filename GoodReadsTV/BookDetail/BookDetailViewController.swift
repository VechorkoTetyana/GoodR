import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    var bookDetails: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        titleLbl.text = bookDetails.title
        subtitleLbl.text = bookDetails.subtitle
        coverImageView.image = bookDetails.coverImage
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
