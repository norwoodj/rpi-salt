#!yaml|gpg

stupidchess:
  nginx-version: 21.1027.1
  uwsgi-version: 21.1027.0

  mongo-password: |
    -----BEGIN PGP MESSAGE-----

    hQGMA4rzglNLQgSYAQv/clMJt+msU/ifl27t3SmNM0zn5FfbmoTtglFZe+kwz4+E
    OZ29pNeCni5p5fcqkLDkF0PRyO/zjOavoCf723Y140Qfr5N3v+mY/aufcd1zrAGk
    sLJcW39WBmYTEfJ5aKma/Ack3H2NnJX6yWjevT7MAl6hmXwRqJcOKf3dYF+LHoNh
    5k/kY8KJz6M6dAINyjcaphgSrO69LOcHxEvAdLGAOSr5auXYyuNUjmK4wyudiIvU
    /T26vyCvcGcLKQVhx5Kl8Y29OPdvCDdYf1SxUOk51aF9hKTlA8xDYmd8ZNMeSzvA
    Ww1y0iMYTJsiQ9iP6p7lm6QyFzAOndk4qx0PhvfBXqAP/Ah2ZnFxzIFwd5xMpJ1f
    E8BhWldoFZg8kYRJihjwfuUhpK3gA8xUMiqkMi0YZBN2YvJ3CLrYqvIpC22kcuED
    FcLf1zhESOdj8pP3w8mwtq+cIxkQv3QzqAN7u/mKfxeTVPpQr7P1TZSfew6RXfoF
    vKiwKuffSItsIL0nkg8V0lsBhmBx1L03vhDVDYBQQMC5G9nFTd4xncChI+Lp/tux
    /qTN8JZoRqplaCLUj/D/+Q2u9lnFvYkxUVIojcBjEjy80JKOe/E6hBHcvFhbFeso
    clXLBbaXKfvw8vIT
    =Ywsj
    -----END PGP MESSAGE-----

  flask-app-secret-key: |
    -----BEGIN PGP MESSAGE-----

    hQGMA4rzglNLQgSYAQwAiERrtqx+fIAx8ZzBvCh4rlVA2Rq7WVt8h3JjA8FviRvj
    e0BZDfsNLfgzOo7v5rnBSNXIKfCHrlDfrWApOc6fU59XACld/meARHJ+3ZWpBUSw
    fYGB5ScB1bsTIEBfQhQSc5xFs/Cl+fa5LqrND2nBwaQSuadlbN6dMWN9jG8XzRTR
    PgbYKZ0VEs0ynLwS6zVa/FqYkvuxSIMqC4bAXdXijCwZ4UQ7SBE6tp6v9yrYwjWw
    APK6Wvc+JWgfikW2ZBAUSwYvvHi47OR323R/o2fm6ZXBt3YGGAtVvetk4u63O/lS
    +GNigki4foPd8jC74sMKspwZPJLVX4wrsZ5VT+0hWtB2TzBuDRs6j/89Jiu8cGxk
    f0STGieNa08hKFTGpp6/t2Ngj6xSnmEvsiL6ucQruVN+O4FVHUp9j1zFLh/64yYG
    ljJ8NwMEVJKTui0EoWo/5+2iBXKJiALvBAXJotIHJw9IhJWvOE+l/D1BOoDpLcMx
    Z4HD0sM5CKEW7lsTIAYB0lsBaf56fq84BjkM3SD/lre/ujpQe+a5acoVwSo0wnim
    FZdmkQKgzD0yGVEQu7DAqHr3rWjgLtjKea/hNSKULz/9bQpEat2HaGruUgv63QcO
    fM5t/g4I9KH7rJRa
    =tDUu
    -----END PGP MESSAGE-----

users:
  stupidchess:
    password: '*' # http://arlimus.github.io/articles/usepam/
    shell: /sbin/nologin
