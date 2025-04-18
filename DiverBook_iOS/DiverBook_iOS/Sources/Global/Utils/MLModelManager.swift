//
//  MLModelManager.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/16/25.
//

import CoreML
import SwiftUI
import Vision

class MLModelManager {
    static var shared: MLModelManager = MLModelManager()
    
    private init() { }
    
    
    // MARK: - inspect result(분류된 Label 반환)
    func inspectIdCard(image: CIImage, completion: @escaping (VNClassificationObservation) -> Void) {
        guard let coreMLModel = try? DiverBookIDCardClassfier(configuration: MLModelConfiguration()),
              let visionModel = try? VNCoreMLModel(for: coreMLModel.model) else {
            fatalError("Loading CoreML Model Failed")
        }
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            guard error == nil else {
                fatalError("Failed Request")
            }
            guard let classification = request.results as? [VNClassificationObservation] else {
                fatalError("Failed convert VNClassificationObservation")
            }
            
            if let fitstItem = classification.first {
                completion(fitstItem)
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            fatalError("Failed to perform")
        }
    }
    
    func inspectNickname(image: UIImage?, completion: @escaping (String?) -> Void) {
        guard let cgImage = image?.cgImage else {
            fatalError("could not get image")
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            guard let text = observations[1].topCandidates(1).first?.string else {
                completion(nil)
                return
            }
            
            if text.lowercased() != "postech" {
                DispatchQueue.main.async {
                    completion(text)
                }
            }
        }
   
        if #available(iOS 16.0, *) {
            let revision3 = VNRecognizeTextRequestRevision3
            request.revision = revision3
            request.recognitionLevel = .accurate
            request.recognitionLanguages = ["en-US"]
            request.usesLanguageCorrection = true

            do {
                var possibleLanguages: Array<String> = []
                possibleLanguages = try request.supportedRecognitionLanguages()
                print(possibleLanguages)
            } catch {
                print("Error getting the supported languages.")
            }
        } else {
            // Fallback on earlier versions
            request.recognitionLanguages =  ["en-US"]
            request.usesLanguageCorrection = true
        }
    
        do{
            try handler.perform([request])
        } catch {
            print("vision Error: \(error)")
        }
    }
}
