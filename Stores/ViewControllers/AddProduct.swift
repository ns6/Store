////
////  AddProduct.swift
////  Stores
////
////  Created by ssion on 10/15/17.
////  Copyright © 2017 Prokuda. All rights reserved.
////
//
//import UIKit
//
//class AddProduct: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    var array = ["S", "M", "L", "XL", "XXL", "3XL", "4XL"];
//    var scrollViewBottom: CGFloat!
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var sexView: UISegmentedControl!
//    @IBOutlet weak var nameView: UITextField!
//    @IBOutlet weak var colorView: UITextField!
//    @IBOutlet weak var purchasePriceView: UITextField!
//    @IBOutlet weak var sellPriceView: UITextField!
//    @IBOutlet weak var commentView: UITextField!
//    @IBOutlet weak var sizesView: UICollectionView!
//    
//    @IBAction func imageViewTapped(_ sender: Any) {
//    }
//    
//    @IBAction func sexChanged(_ sender: Any) {
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.scrollViewBottom = self.scrollView.contentInset.bottom
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//    
//    
//    // MARK: UICollectionViewDataSource
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return self.array.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeCell", for: indexPath) as! SizeCell
//        
//        cell.sizeLabel.text = self.array[indexPath.row]
//        
//        return cell
//    }
//    
//    // MARK: UICollectionViewDelegate
//    
//    /*
//     // Uncomment this method to specify if the specified item should be highlighted during tracking
//     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//     return true
//     }
//     */
//    
//    /*
//     // Uncomment this method to specify if the specified item should be selected
//     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//     return true
//     }
//     */
//    
//    /*
//     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//     return false
//     }
//     
//     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//     return false
//     }
//     
//     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//     
//     }
//     */
//    
//    
////    @objc func keyboardWillShow(notification:NSNotification){
////        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
////        var userInfo = notification.userInfo!
////        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
////        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
////
////        var contentInset:UIEdgeInsets = self.scrollView.contentInset
////        contentInset.bottom = keyboardFrame.size.height
////        scrollView.contentInset = contentInset
////    }
////
////    @objc func keyboardWillHide(notification:NSNotification){
////        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
////        scrollView.contentInset = contentInset
////    }
//    
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        registerNotifications()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        unregisterNotifications()
//    }
//    
//    func registerNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
//    }
//    
//    func unregisterNotifications() {
//        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
//    }
//    
//    @objc func keyboardWillShow(notification: NSNotification){
//        guard let keyboardFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
//        print(keyboardFrame)
//        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height + 20
//        viewDidLayoutSubviews()
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification){
//        scrollView.contentInset.bottom = 0
//        viewDidLayoutSubviews()
//    }
//    
//}
//
//
