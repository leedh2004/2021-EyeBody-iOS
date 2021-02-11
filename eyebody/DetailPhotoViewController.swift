//
//  DetailPhotoViewController.swift
//  eyebody
//
//  Created by 이도현 on 2021/02/11.
//

import UIKit

class DetailPhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
//            scrollView.contentSize = imageView.frame.size
//            scrollView.delegate = self
            scrollView.maximumZoomScale = 2.0
            scrollView.minimumZoomScale = 1.0
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    var path: String?
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = path {
            let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(path)
            let fileManager = FileManager.default
    //           let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
            if fileManager.fileExists(atPath: imagePath){
                self.imageView?.image = UIImage(contentsOfFile:imagePath)
            }
        }
        scrollView.isPagingEnabled = true
        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let testLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        testLabel.text = "TEST"
        testView.addSubview(testLabel)
        scrollView.addSubview(testView)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
