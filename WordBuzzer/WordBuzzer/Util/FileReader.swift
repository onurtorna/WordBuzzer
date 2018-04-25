//
//  FileReader.swift
//  WordBuzzer
//
//  Created by Onur Torna on 25/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import Foundation

final class FileReader {

    /// Reads json file and returns json array if possible
    ///
    /// - Parameter resource: Resource file name
    /// - Returns: Json array of strings
    static func readJsonList(resource: String) -> [[String: String]]? {

        if let path = Bundle.main.path(forResource: resource,
                                       ofType: Global.File.Extension.json) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                    options: .mappedIfSafe)
                let jsonList = try JSONSerialization.jsonObject(with: data,
                                                                options: .mutableLeaves)

                return jsonList as? [[String: String]]
            } catch {
                // TODO: Handle Error
            }
        }

        return nil
    }
}
