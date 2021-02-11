//
//  CapturedPhoto.swift
//  eyebody
//
//  Created by 이도현 on 2021/02/10.
//

import Foundation

struct Photo: Codable, Equatable {
    let id: Int
    let path: String
    let date: Date
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

class PhotoManager {
    static let shared = PhotoManager()
    static var lastId: Int = 0
    var photos: [Photo] = []
    
    func createPhoto(path: String) -> Photo {
        let nextId = PhotoManager.lastId + 1
        PhotoManager.lastId = nextId
        return Photo(id: nextId, path: path, date: Date())
    }
    
    func addPhoto(_ photo: Photo) {
        photos.append(photo)
        savePhoto()
    }
    
    func deletePhoto(_ photo: Photo){
        photos = photos.filter{$0.id != photo.id}
        savePhoto()
    }
    
    func savePhoto(){
        Storage.store(photos, to: .documents, as: "photos.json")
    }
    
    func retrievePhoto() {
        photos = Storage.retrive("photos.json", from: .documents, as: [Photo].self) ?? []
        let lastId = photos.last?.id ?? 0
        PhotoManager.lastId = lastId
        print("LAST ID: \(PhotoManager.lastId)")
    }
}

class CameraViewModel {
    
    private let manager = PhotoManager.shared
    
    var photos: [Photo] {
        return manager.photos
    }
    
    func loadPhotos() {
        manager.retrievePhoto()
    }
    
    func addPhoto(_ photo: Photo) {
        manager.addPhoto(photo)
    }
    
}

class GalleryViewModel {
    private let manager = PhotoManager.shared
    
    var photos: [Photo] {
        return manager.photos
    }
    
    func loadPhotos() {
        manager.retrievePhoto()
    }
    
    func addPhoto(_ photo: Photo) {
        manager.addPhoto(photo)
    }
}
