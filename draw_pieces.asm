.186
.model large
.stack 64
.data

black_bishop                    db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh
db                                    0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh
db                                    0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,12h,12h,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                    0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
db                                    0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                    0ffh,12h,12h,0ffh,12h,12h,12h,12h,12h,12h,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh
db                                    0ffh,12h,12h,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh
db                                    12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh
db                                    0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h
db                                    12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                    0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh
db                                    0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h
db                                    12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h
db                                    12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h

;Size: 20 x 20 
black_king                              db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h
db 12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h
db 12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                 0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                 0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh
db                                 0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h
db                                 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
db                                 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h
db                  12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh
db                  0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,
db                  12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                  12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh

;Size: 20 x 20 
black_knight  db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh
db 0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h
db 12h,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h
db 12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h
db 12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh

;Size: 20 x 20 
black_pawn                              db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh
db 0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh
db 12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h
db 12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh
db 0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh
db 0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,12h,12h
db 12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h
db 12h,12h,12h,12h,12h,12h,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh

;Size: 20 x 20 
black_queen                             db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,12h,12h,0ffh,12h,12h,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh
db 0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h
db 0ffh,0ffh,0ffh

;Size: 20 x 20 
black_rock db    0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h
db 12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh
db 0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh
db 0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h
db 12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h
db 0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh

;Size: 20 x 20 
white_bishop                            db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh
db 0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0fh,0fh,0fh,0ffh,0fh,0fh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh
db 0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0fh,0fh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh
db                                        0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
db                                        0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh
                                        db    0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0fh,0fh,0fh,0fh,
db                                        0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh

;Size: 20 x 20 
white_king                              db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
db 0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh
db                                        0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh
db                                        0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh
db                                        0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh

;Size: 20 x 20 
white_knight                            db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh
db 0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh
db                                        0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh
db                                        0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh
db                                        0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh

;Size: 20 x 20 
white_pawn                              db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh
db                                        0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh
db                                        0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh
db                                        0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
db                                        0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
db                                        0fh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh

;Size: 20 x 20 
white_queen                             db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0fh,0fh,0ffh,0fh,0fh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh
db                                        0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
db                                        0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh
db                                        0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh
db 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh

;Size: 20 x 20 
white_rock db 0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
db 0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh
db 0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
db 0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh
db 0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh
db 0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
db 0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh
db 0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh
db 0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh
db 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
db 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
db 0fh,0fh,0fh,0fh,0fh,0fh,0ffh


grid db "br","bn","bb","bq","bk","bb","bn","br"
db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
db "--","--","--","--","--","--","--","--"
db "--","--","--","--","--","--","--","--"
db "--","--","--","--","--","--","--","--"
db "--","--","--","--","--","--","--","--"
db "wp","wp","wp","wp","wp","wp","wp","wp"  
db "wr","wn","wb","wq","wk","wb","wn","wr"
                                  

pieceWidth EQU 20
pieceHeight EQU 20

x0 dw 0
y0 dw 0
x1 dw 0
y1 dw 0

N dw 8
x dw ?
y dw ?

get_cell_x dw ?
get_cell_y dw ?


curr_marked_x_pixel dw 72
curr_marked_y_pixel dw 12
curr_marked_x_val dw 1
curr_marked_y_val dw 1

draw_piece_x dw  ?
draw_piece_y dw  ?


cell_clicked_x dw 1
cell_clicked_y dw 1 


DrawRectangle macro x_0, y_0, x_1, y_1
local border, row, l, m
pusha

mov di,x_0
mov si,y_0

cmp di,curr_marked_x_pixel
jnz l
cmp si,curr_marked_y_pixel
jnz m

mov al,0Ch

l:
m:
mov ah, 0ch
mov dx, y_0

border:
mov cx, x_0

row:
int 10h
inc cx
cmp cx, x_1
jne row

inc dx
cmp dx, y_1
jne border

popa
endm


ToggleColor macro c
local white, cont

cmp c, 8 ;Dark Grey
je white

mov c, 8
jmp cont

white:
mov c, 07h
cont: 

endm
 
Draw macro draw_x , draw_y , z;, x_r,y_c
local drawloop, jumb_if_black, l, m
; Drawing loop

pusha
mov cx,draw_x
mov dx,draw_y
mov bx,z
mov di,cx
add di, pieceWidth
mov si, dx
add si, pieceHeight

mov draw_piece_x , di
mov draw_piece_y , si

MOV AH,0ch

drawLoop:
    
    MOV AL,[bx]
    
    cmp al,0ffh
    jz jumb_if_black        
    INT 10h
    jumb_if_black: 
    
    INC CX
    INC BX
    CMP CX,draw_piece_x
JNE drawLoop 
	
    MOV CX , draw_x
    INC DX
    CMP DX , draw_piece_y
JNE drawLoop

popa
endm 

get_cell macro row_x,col_y
local add_square_val , add_square_val_2   

pusha
mov cx,51
mov dx,-9

mov si,row_x
mov di,col_y

add_square_val:

add cx,22

dec si
jnz add_square_val

add_square_val_2:

add dx,22

dec di
jnz add_square_val_2

mov get_cell_x, cx
mov get_cell_y, dx


popa
endm

draw_grid macro
local row,col,con,con1

pusha

mov al, 6h ;Brown

DrawRectangle 0, 0, 320, 12

DrawRectangle 0, 12, 72, 188

DrawRectangle 248, 12, 320, 188

DrawRectangle 0, 188, 320, 200



mov y0, 12 
mov y1, 34

mov al, 07h ;light gray

col:
ToggleColor al
mov x0, 72 
mov x1, 94

row:
ToggleColor al

DrawRectangle x0, y0, x1, y1

add x0, 22
add x1, 22

cmp x0, 248

je con
jmp row
con:  

add y0, 22
add y1, 22

cmp y0, 188

je con1
jmp col
con1:    

popa
endm

draw_pieces_in_grid macro
local col,row,con,con1

pusha
mov bx, offset grid
mov x,1
mov y,1

col: 
row:
mov cx,[bx]
xchg ch,cl
cmp cx,"bb"
jnz not_black_bishop
get_cell x,y
mov di,offset black_bishop
draw get_cell_x , get_cell_y , di;, x, y
not_black_bishop:

cmp cx,"br"
jnz not_black_rock
get_cell x,y
mov di,offset black_rock
draw get_cell_x , get_cell_y , di;, x, y
not_black_rock:

cmp cx,"bn"
jnz not_black_knight
get_cell x,y
mov di,offset black_knight
draw get_cell_x , get_cell_y , di;, x, y
not_black_knight:

cmp cx,"bp"
jnz not_black_pawn
get_cell x,y
mov di,offset black_pawn
draw get_cell_x , get_cell_y , di;, x, y
not_black_pawn:

cmp cx,"bq"
jnz not_black_queen
get_cell x,y
mov di,offset black_queen
draw get_cell_x , get_cell_y , di;, x, y
not_black_queen:

cmp cx,"bk"
jnz not_black_king
get_cell x,y
mov di,offset black_king
draw get_cell_x , get_cell_y , di;, x, y
not_black_king:

cmp cx,"wb"
jnz not_white_bishop
get_cell x,y
mov di,offset white_bishop
draw get_cell_x , get_cell_y , di;, x, y
not_white_bishop:

cmp cx,"wr"
jnz not_white_rock
get_cell x,y
mov di,offset white_rock
draw get_cell_x , get_cell_y , di;, x, y
not_white_rock:

cmp cx,"wn"
jnz not_white_knight
get_cell x,y
mov di,offset white_knight
draw get_cell_x , get_cell_y , di;, x, y
not_white_knight:

cmp cx,"wp"
jnz not_white_pawn
get_cell x,y
mov di,offset white_pawn
draw get_cell_x , get_cell_y , di;, x, y
not_white_pawn:

cmp cx,"wq"
jnz not_white_queen
get_cell x,y
mov di,offset white_queen
draw get_cell_x , get_cell_y , di;, x, y
not_white_queen:

cmp cx,"wk"
jnz not_white_king
get_cell x,y
mov di,offset white_king
draw get_cell_x , get_cell_y , di;, x, y
not_white_king:

inc x
inc bx
inc bx
cmp x,9
jz con
jmp row
con:
mov x, 1
inc y
cmp y,9

jz con1
jmp col
con1:

popa
endm

.code
start:

MOV AX , @DATA
MOV DS , AX

mov ah, 0
mov al, 13h
int 10h

  
 
;Drawing outer border (Brown)

;Down arrow       E0 50
;Left arrow       E0 4B
;Right arrow      E0 4D
;Up arrow         E0 48

game: 
mov ah,0
int 16h

cmp al,'d'     ;move right
jnz m1
mov dx,curr_marked_x_pixel
add dx, 22
mov curr_marked_x_pixel,dx
inc curr_marked_x_val
m1:
cmp al,'w'
jnz m2
mov dx,curr_marked_y_pixel   ;move up
sub dx, 22
mov curr_marked_y_pixel,dx
dec curr_marked_y_val
m2:
cmp al,'s'
jnz m3          ;move down
mov dx,curr_marked_y_pixel
add dx, 22
mov curr_marked_y_pixel,dx
inc curr_marked_y_val
m3:
cmp al,'a'
jnz m4           ;move left
mov dx,curr_marked_x_pixel
sub dx, 22
mov curr_marked_x_pixel,dx
dec curr_marked_x_val
m4:
cmp al,'q'         ; source
jnz m5
mov dx, curr_marked_x_val
mov cx, curr_marked_y_val

mov cell_clicked_x,dx
mov cell_clicked_y,cx
m5:



draw_grid
draw_pieces_in_grid


cmp al,'9'
jz l
jmp game
l:

mov ax,4c00h

int 21h

end start



.end
