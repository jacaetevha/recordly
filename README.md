## About Recordly

The record image was downloaded from [pixabay](https://pixabay.com/en/record-retro-music-vintage-504759/) and may be used without attribution.

The favicon.ico was generated from the pixabay record image.

And example application instance is hosted [on Heroku](https://recordly-jacaetevha.herokuapp.com). You can login with either `janedoe@example.com` or `johndoe@example.com`. Each user's password is `password`.

There are some sample records, artists, and songs on each account. Nothing has been favorited as of yet.

This implementation is a rough MVP (if not a somewhat ugly one).

There are a mix of AJAX and full page requests. AJAX is used for
- deleting records on the records listing page (the root of the site)
- (un-)marking an artist, song, or record as a favorite
Everything else is a traditional full-page load.

The domain model is simple, and could be improved upon.
- a `User` has many `Record`s.
- a `Record` has many `Song`s and `Artist`s
- an `Artist` has many `Song`s through `Record`s
- an `Artist`, `Song`, and `Record` has a `Favorite`

```
                       ########
                       # User #
                       ########
                          |
                       (0...n)
                          |
                          V
                      ##########
               +----- # Record # ------+
               |      ##########       |
            (0...n)        |        (0...n)
               |           |           |
               V           |           V
          ##########       |       ##########
          #  Song  #     (0,1)     # Artist #
          ##########       |       ##########
               |           |            |
               |           |            |
             (0,1)         V          (0,1)
               |      ############      |
               +----> # Favorite # <----+
                      ############
```
