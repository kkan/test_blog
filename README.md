# README

## Starting
- `git clone git@github.com:kkan/test_blog.git`
- `cp config/secrets.yml.sample config/secrets.yml` and add your credentials to `config/secrets.yml`
- `rake db:create db:migrate`
- `rails s`

## Test Data
- `rake db:seed` to add test data to database

## Tests
- `rspec` to run tests

## Endpoints calling with curl
Add new post
```
curl -X POST http://localhost:3000/posts -d '{ "login": "My Login", "title": "hello world", "content": "la-la-land", "ip": "192.168.0.8"}' -H "content-type:application/json"
```
Rate post with id `1`
```
curl -X POST http://localhost:3000/reviews -d '{ "score": 5, "post_id": 1 }' -H "content-type:application/json"
```
Get top 10 posts by rating
```
curl http://localhost:3000/posts/top?n=10
```
Get list of IP addreses which were used by several users
```
curl http://localhost:3000/ip_addresses/multiuser
```
