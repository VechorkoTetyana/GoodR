import UIKit

class CommentsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addNewItemView: UIView!
    @IBOutlet private weak var addNewItemSaveAreaView: UIView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var addBtn: UIButton!
    
    @IBOutlet weak var addNewItemSaveAreaViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraints: NSLayoutConstraint!
            
    var comments: [Book]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
 //       addBtn.imageView!.tintColor = .red
        
        configureTableView()
        comments = fillCommentsDataSource()
                
        configureTableView()
        configureKeyboard()
        
        setupHideKeyBoardGesture()
        configureTextField()
        
        setAddCommentButton(enabled: false)
        
        didChangeText()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func didChangeText() {
        setAddCommentButton(enabled: isDataValid)
    }
    
    private func setAddCommentButton(enabled isEnabled: Bool) {
        if  isEnabled {
                addBtn.tintColor = .white
            } else {
                addBtn.tintColor = UIColor(hex: "#FFFFFF")?.withAlphaComponent(0.5)
            }
    }
    
    private var isDataValid: Bool {
        guard let text = textField.text else { return false }
        
        return text.count >= 3
    }
    
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyBoardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyBoardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyBoardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let isKeyBoardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        // if the keyboard is hidden
        if isKeyBoardHidden {
            addNewItemSaveAreaViewBottomConstraint.constant = 0 + 20
        } else {
            // if the keyboard is presented
            addNewItemSaveAreaViewBottomConstraint.constant = -1 * (endFrame.height - view.safeAreaInsets.bottom + 8)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func fillCommentsDataSource()  -> [Book] {
            
        var comments = [Book]()
            
        comments.append(Book(
            title: "@dayganat - 2 months ago",
            subtitle: "Such a magnificent book. Haunting and hugely underrated",
            authors: [],
            coverImage: .dAvatar
        ))
        
        comments.append(Book(
            title: "@s.penkevich - 1 month ago",
            subtitle: "I find it hard to stay positive in this rubbish world.",
            authors: [],
            coverImage: .daAvatar
        ))
        
        comments.append(Book(
            title: "@CanadianJen - 3 months ago",
            subtitle: "Allende is a master at spinning an epic story. I really wanted this one to ...",
            authors: [],
            coverImage: .dbAvatar
        ))
        
        comments.append(Book(
            title: "@theoverbookedbibliophile - 12 hours ago",
            subtitle: "In I938 Vienna, in the aftermath of Kristallnacht, six-year-old Samuel...",
            authors: [],
            coverImage: .dcAvatar
        ))
        
        comments.append(Book(
            title: "@AngelaM - 3 months ago",
            subtitle: "In two different times, in two different places, under different and horrible...",
            authors: [],
            coverImage: .deAvatar
        ))
        
        comments.append(Book(
            title: "@Helga - 3 months ago",
            subtitle: "There is a star where the people and the animals all live happily, and it’s even ...",
            authors: [],
            coverImage: .dfAvatar
        ))
            
            return comments
        }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private var isNewItemValid: Bool {
        guard let text = textField.text else { return false }
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    @IBAction func addCommentBtnTapped(_ sender: Any) {
        textField.becomeFirstResponder()
        
        guard isNewItemValid, let text = textField.text else { return }
        
        _ = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let newComment = Book(
            title: "@tvechorkofedora - 12 hours ago",
            subtitle: text,
            authors: [],
            coverImage: .smallAvatar
        )
            comments.append(newComment)
        
        
        let indexPath = IndexPath(row: comments.count - 1, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        textField.text = ""
        setAddCommentButton(enabled: false)
        
    }
    
    private func configureTextField() {
        textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Add a comment...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#A7AEC1")!])
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsTableViewCell")
        tableView.rowHeight = 118
    }
    
    func present(with book: Book) {
        let commentsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        
        commentsViewController.comments = comments
        
        commentsViewController.modalPresentationStyle = .fullScreen
        
        present(commentsViewController, animated: true)
    }
    
    private func setupHideKeyBoardGesture() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyBoard)
        )
        
        tap.delegate = self
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyBoard() {
        view.endEditing(true)
    }
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as? CommentsTableViewCell
        else { return UITableViewCell() }
        
        let commentList = comments[indexPath.row]
        
        cell.configureTableView(with: commentList)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentList = comments[indexPath.row]
        present(with: commentList)
    }
}

extension CommentsViewController: UIScrollViewDelegate {
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            view.endEditing(true)
        }
}

