# Brainstorming

## Idea dump

- Movie watchlist app: Keep track of the movies a user plans to watch and has watched.
- Subscription app: Keep track of user subscriptions
- Photo rating app: Allow users to rate their photos
- Phone motion alarm: Phone alarms when moved (would need to be in the foreground).

## Evaluating ideas

The two app ideas that seem most interesting to me are:
- The movie watchlist app 
- The subscription-tracking app

#### Movie Watchlist App
- **Description**: Allows users to keep track of the movies they want to and have watched in one centralized place. Movie names are added to the app, then are marked watched by a user.
- **Mobile**: Users are able to add a movie to their watchlist wherever they are.
- **Story**: Provides a clear and obvious place for users to keep track of the movies they intend to watch. 
- **Market**: The audience for this app is well-defined: people really into movies who want a place to keep track of movies conveniently. 
- **Habit**: This app is a used-as-needed app, and is meant to be anti-addictive. The user experience: Add a movie, continue with your life, come back when you're finding a movie to watch. 
- **Scope**: I don't think this app will be too hard to build; the core features are (1) adding movie names (2) fetching movie posters from online (3) marking movies as watched/unwatched. 

#### Subscription-Tracking App
- **Description**: Allows users to track their subscriptions, including the name of the subscription, the frequency of the payment, and the payment amount.
- **Mobile**: Offline-only allows users to keep track of their subscriptions wherever they are. Because this doesn't need a server connection, user experience can be better because of lower latency. 
- **Story**: Provides a quick and clear place for users to keep track of their subscriptions and see how much money they're using per-month. 
- **Market**: There are multiple subscription-tracking apps out there—-even bank apps are offering subscription tracking—-but this crowded market makes it hard for users to decide on one. This app can be the "easy go-to."
- **Habit**: Like the movie watchlist app, this app will be anti-addictive. No notifications, users use the app only when they need to edit or analyze their subscriptions.
- **Scope**: This app will likely be easier than the movie watchlist app because it doesn't access the internet. The MVP experience will be: (1) adding a subscription (name, cost, frequency), (2) ability to view the subscriptions. 

## Final Decision

Based on my above evaluations, I'm going to work on the **movie watchlist app**. I want to challenge myself with using APIs for movie art! 
