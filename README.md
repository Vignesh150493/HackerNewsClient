#### A client for Hacker News (https://news.ycombinator.com/) built using flutter.

- Key Flutter/Dart Stuffs in this app,
    - Bloc Pattern.
    - Streams.
    - Navigation.
    - Caching.
    - Abstract classes.
    - Basic Unit testing
    
- Unit Testing,
    - Using dart test package for basic api layer testing.
    - Mocking client.
    
We are clearing caches on refresh and then fetch from server
which would again populate the cache.

- TODO:
     - We fetch from server every single time, and populate cache.
     - Start storing/fetching the list of ids to and from cache too.
     - Stateful Widget probably not needed for GlobalKey in Ticket detail page. Check. 
