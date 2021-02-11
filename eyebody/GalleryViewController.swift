//
//  GalleryViewController.swift
//  eyebody
//
//  Created by 이도현 on 2021/01/20.
//

import UIKit

class GalleryViewController: UIViewController {
    let galleryViewModel = GalleryViewModel()
    
    var list = ["2", "4", "6", "8" ,"10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "34"]
    
    @IBOutlet weak var GalleryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GalleryCollectionView.delegate = self
        GalleryCollectionView.dataSource = self
        galleryViewModel.loadPhotos()
        print(galleryViewModel.photos)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        GalleryCollectionView.reloadData()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let detailPhotoViewController = segue.destination as? DetailPhotoViewController, let path = sender as? String else { return }
        detailPhotoViewController.path = path
        
       
//        detailViewController
    }

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        performSegue(withIdentifier: "detailSegue", sender: galleryViewModel.photos[indexPath.row].path)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryViewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoViewCell
        
//        cell.label.text = "\(list[indexPath.row])!"
//        let str = galleryViewModel.photos[indexPath.row].path
//        let strIdx = str.index(str.startIndex, offsetBy: 7)
//        let parse = galleryViewModel.photos[indexPath.row].path[strIdx...]
//        print(parse)
//      pri print(galleryViewModel.photos[indexPath.row].path[strIdx...])
//        cell.imageView.image = UIImage(contentsOfFile: galleryViewModel.photos[indexPath.row].path)
        
//        print(indexPath.row)
//        cell.layer.backgroundColor = UIColor.red.cgColor
        
        let imageName = galleryViewModel.photos[indexPath.row].path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        print(imagePath)
        let fileManager = FileManager.default
//           let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            cell.imageView.image = UIImage(contentsOfFile:imagePath)
        }else{
            print("Panic! No Image!")
        }
        return cell
    }
    
    
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 3 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: width)
        return size
    }
}

class PhotoViewCell: UICollectionViewCell {
//    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
}

