//
//  Book.swift
//  Book Share
//
//  Created by Mike Gomez on 4/17/24.
//

import Foundation
struct BookResults: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Book]
}

struct Book: Decodable {
    let id: Int
    let title: String
    let authors: [Author]
    let translators: [String]
    let subjects: [String]
    let bookshelves: [String]
    let languages: [String]
    let copyright: Bool
    let media_type: String
    let formats: Formats
    let download_count: Int
}

struct Author: Decodable {
    let name: String
    let birth_year: Int
    let death_year: Int
}

struct Formats: Decodable {
    let text_html: String?
    let application_epub_zip: String?
    let application_x_mobipocket_ebook: String?
    let application_rdf_xml: String?
    let image_jpeg: String?
    let text_plain_charset_us_ascii: String?
    let application_octet_stream: String?

    private enum CodingKeys: String, CodingKey {
        case text_html = "text/html"
        case application_epub_zip = "application/epub+zip"
        case application_x_mobipocket_ebook = "application/x-mobipocket-ebook"
        case application_rdf_xml = "application/rdf+xml"
        case image_jpeg = "image/jpeg"
        case text_plain_charset_us_ascii = "text/plain; charset=us-ascii"
        case application_octet_stream = "application/octet-stream"
    }
}
// testing below



