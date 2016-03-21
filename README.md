# tektek
An http load test tool by.

**I am very beginner with crystal-lang** and **this is a demo project.**

And this means :

- Do not use for production
- You can fork this and improve
- Use with your own risk
- There may be lots of bugs. But feel free to [open an issue](https://github.com/hasantayyar/tektek/issues/new).
- This project is not well documented.

There are many [super cool crystal projects](https://github.com/search?l=crystal&q=http&ref=simplesearch&type=Repositories&utf8=%E2%9C%93) if you want to check.


## Build

```
crystal build src/tektek.cr --release
```

## Use

```
./tektek -u http://hasantayyar.net -n 100
```

Output
```
________________________

Elapsed time : 6393.71 ms
Transactions : 100 hits
Shortest transaction : 60.495 ms
Longest transaction  : 266.518 ms
Average transaction  : 63.9371 ms
________________________
Transaction rate : 15.6404 trans/sec
Successful transactions 100
Failed transactions 0
```


