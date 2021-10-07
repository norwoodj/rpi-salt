#!yaml|gpg

hashbash:
  backend-version: 21.1007.0
  nginx-version: 21.1006.0

  postgres-password: |
    -----BEGIN PGP MESSAGE-----

    hQGMA4rzglNLQgSYAQwAn1HDtKIIskI0q2HR1ZgMSccSITH4Ulyyj5PJUtKjBZ48
    MLi8p2rC3LhP0Y8ich6fZ54gXqL6JFvDoIZAaR5AWqic+sN0Rakh7U5ajDddRpWQ
    OLakFTivKWQIo0Dkf9Dvdrw7xGifXMcNNXB+j8FZemI0qDE+oQTKTK5LuzeoyFhI
    SPWUYO8LvA04hZeSbKCkTDvzFrVt+OjFsxVkg3+j2Snp5NB3l8/i/FA4zQvFVZvE
    V7enhH889ak2vDG33jYnNX4yry7zpsznLlRmtGAZx0fju5xDAnLuwRAoFT1GrQCC
    ZfhUGBgsHawdZ0PuPftLRnaGUauyKdvQrxzy4+JHHYJ+dx9R4WdAhWhGXJlE7ruc
    wmgiDzY1ZLqOxPXsAiJBzFEUmkwvA9TDTOn+OqwHkp03X24B2cGvVZQS6gBUkc35
    qC3I3xMHDkXaaFLW2DDVYNFc2SStJLmrDXeXarkHfklVFt4fPRr/VYdqmt8FQfi0
    /eLfAK6RkK5BH7YgfjfM0lsBDHSB34W7pExabepyrgNNALzIR9/Bb2HAD9S2EQOd
    cp6ciMNWUQ9ZRiJz5dPLui86uythoRf6jGRF7PsICTt+3oJBqgJ9FgaAvB/yhf8g
    De1e66nP1V1c0tjU
    =BGvH
    -----END PGP MESSAGE-----

  rabbitmq-password: |
    -----BEGIN PGP MESSAGE-----

    hQGMA4rzglNLQgSYAQwAogdzfRVo5KcyGzB9/NVQEwc+hyqoA33CkasyeY2L4rzL
    k5kYpjVErorh58hun7bRaJrdOlNnCl8DzU1yDBh9fDjfXEepV26m4ZgYVJb0xQOZ
    FjyaCAZsoyGNIuqGHiDkGNo1FBoLBLy8zqYiI8Z5shyybmqSaaQyMmcyHPUWxrjd
    /40m4vQCQXRZoDdEge44jBhljrHxUALOkxEn5sjch/TfojheAW5tmtuvhT9q68zN
    SDPfzK/eH9skJLWo5KgopYTjkVA5GSD4I5B95/ABUL4S9OQJfwYM/FUOKvVF35L7
    G+C67tFDMeQeC0Llvjw02sqByia2P9bDA5ariSLfD2MHPjN8E0nohmWviKgXnXcs
    h7aroQeB+3vcWMlz37R3d2rmfE34sa4bLlMS/r1QPMN0+j4G8n9QAXg4Ft9SSMPF
    Di9496LJgKiXfy/Q3cpnVz2gTLAUFd1RQOTDpDsYtn9nIpxOp4xS4ch5t8Oe7+Z+
    5FOmscA8CtJyJ5EYREKk0lsBcIFsYv5gynt1mseusXq+GPSE0tlWl5sRIOSWGtEe
    ZWmBHK7vXTgGy8o4Tmv4Q7AhH/SuSWuWyT3W26zohKm1jDQMQe9zwc3LPae/D9Px
    FW+QnmyZf/OLt6XK
    =0Z5G
    -----END PGP MESSAGE-----

users:
  hashbash:
    password: '*' # http://arlimus.github.io/articles/usepam/
    home: /opt/hashbash
    homedir_owner: hashbash
    shell: /sbin/nologin
