//
//  MovieFeed.swift
//  MovieWatchlist
//
//  Created by Kevin Chen on 8/4/25.
//

import Foundation

/// Represents the top-level JSON response from TMDB's movie search endpoint.
struct MovieFeed: Codable {
    let page: Int           // Current page of results
    let results: [Movie]    // Array of movies returned
    let total_pages: Int    // Total number of pages available
    let total_results: Int  // Total number of results available
}