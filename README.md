# cidr

[![build](https://github.com/ntkme/postgresql-cidr/actions/workflows/build.yml/badge.svg)](https://github.com/ntkme/postgresql-cidr/actions/workflows/build.yml)

## Installation

``` sh
make install
```

### Comparison with Built-In `inet_merge`

| Function    | `inet_merge(inet, inet)`                                       | `cidr(inet, inet)`                                                                                                                                                                                                                                                                                                             |
|-------------|----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Return Type | `cidr`                                                         | `TABLE (cidr cidr)`                                                                                                                                                                                                                                                                                                            |
| Description | the smallest network which includes both of the given networks | the smallest set of network(s) which includes both of the given addresses                                                                                                                                                                                                                                                      |
| Example     | `inet_merge('8.8.8.8', '8.255.255.255')`                       | `cidr('8.8.8.8', '8.255.255.255')`                                                                                                                                                                                                                                                                                             |
| Result      | `8.0.0.0/8`                                                    | `8.8.8.8/29`<br>`8.8.8.16/28`<br>`8.8.8.32/27`<br>`8.8.8.64/26`<br>`8.8.8.128/25`<br>`8.8.9.0/24`<br>`8.8.10.0/23`<br>`8.8.12.0/22`<br>`8.8.16.0/20`<br>`8.8.32.0/19`<br>`8.8.64.0/18`<br>`8.8.128.0/17`<br>`8.9.0.0/16`<br>`8.10.0.0/15`<br>`8.12.0.0/14`<br>`8.16.0.0/12`<br>`8.32.0.0/11`<br>`8.64.0.0/10`<br>`8.128.0.0/9` |
