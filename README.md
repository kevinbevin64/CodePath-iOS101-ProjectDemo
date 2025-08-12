# Movie Watchlist App

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

This app helps users keep track of the movies they want to and have watched!

Watch a demo! 

<a href="https://www.loom.com/share/d6a0552d397045ecb6c22ff23de3d5e7">
  <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/d6a0552d397045ecb6c22ff23de3d5e7-03bc60abd5c13fbf-full-play.gif">
</a>

### Description

Users are able to search and add movie names, toggle movies watched/unwatched, and see the movie's poster art. 

### App Evaluation

- **Category**: Allows users to keep track of the movies they want to and have watched in one centralized place. Movie names are added to the app, then are marked watched by a user.
- **Mobile**: Users are able to add a movie to their watchlist wherever they are.
- **Story**: Provides a clear and obvious place for users to keep track of the movies they intend to watch. 
- **Market**: The audience for this app is well-defined: people really into movies who want a place to keep track of movies conveniently. 
- **Habit**: This app is a used-as-needed app, and is meant to be anti-addictive. The user experience: Add a movie, continue with your life, come back when you're finding a movie to watch. 
- **Scope**: I don't think this app will be too hard to build; the core features are (1) adding movie names (2) fetching movie posters from online (3) marking movies as watched/unwatched.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

Users want to be able to search for and add movies to their watchlists. They must be able to toggle movies watched/unwatched, and add movies to and remove movies from the watchlist.  

**Quality-of-Life**

Users can manage multiple watchlists, such as "For Family", "Personal", and "For watching with friends". 

### 2. Screen Archetypes

- [x] Main watchlist table view 
- [x] Search view (where users search for movies)

### 3. Navigation

**Flow Navigation** (Screen to Screen)

- [x] Main watchlist screen
    - User clicks on the search bar to enter the search view 
- [x] Search view 
    - User enters search terms and then clicks on a search result to return to the main watchlist screen

## Wireframes

<img src="Wireframe.png" width=600>

## Schema 

### Models

- Movie: Represents a movie instance 
- MovieFeed: Represents a response from the API

### Networking

- The app accesses The Movie DB's API 

## Sprints / Features

- [x] Create the navigation controller
- [x] Add in the table view and table view cells (just some empty cells)
- [x] Add in the search controller 
- [x] Add ability to call TMDB API to search for movies 
- [x] Add toggle for watched/unwatched
- [x] Add persistence using JSON, Codable, and a simple UserDefaults setup
