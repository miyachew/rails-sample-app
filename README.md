# Ruby on Rails sample application

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Next, seed the database with admin user:

```
$ rails db:seed
```


Next (optional), seed the database with users and their relationships:

```
$ rails db:seed:users
```

Next (optional), seed the database with 50posts for the first 6 users:

```
$ rails db:seed:microposts
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
