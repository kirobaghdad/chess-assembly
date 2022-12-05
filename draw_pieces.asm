.Model Small
.Stack 64
.Data

pieceWidth EQU 20
pieceHeight EQU 20

;Size: 20 x 20 
arrow_right                             db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,0ffh,0ffh,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,0ffh,0ffh,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,0ffh,36h,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,36h,36h,36h,36h,36h,36h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

;Size: 20 x 20 
black_bishop                            db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,12h,12h,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,12h,12h,12h,12h,12h,12h,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh
                                        db    0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h

;Size: 20 x 20 
black_king                              db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh

;Size: 20 x 20 
black_knight                            db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh

;Size: 20 x 20 
black_pawn                              db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh

;Size: 20 x 20 
black_queen                             db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,12h,12h,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh

;Size: 20 x 20 
black_rock                              db    0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,12h,12h,12h,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh,0ffh,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,12h,0ffh

;Size: 20 x 20 
white_bishop                            db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0fh,0fh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh
                                        db    0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh

;Size: 20 x 20 
white_king                              db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh

;Size: 20 x 20 
white_knight                            db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh

;Size: 20 x 20 
white_pawn                              db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh

;Size: 20 x 20 
white_queen                             db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0fh,0fh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh

;Size: 20 x 20 
white_rock                              db    0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0ffh,0ffh,0ffh
                                        db    0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh,0ffh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ffh


.Code
MAIN PROC FAR
    MOV AX , @DATA
    MOV DS , AX
    
    MOV AH, 0
    MOV AL, 13h
    INT 10h
		
    LEA BX , white_q ; BL contains index at the current drawn pixel
	
	MOV CX,0
    MOV DX,0
    MOV AH,0ch

	
	call Draw
	
    
	LEA BX , white_queen ; BL contains index at the current drawn pixel
    
    call Draw
	
    ; Press any key to exit
    MOV AH , 0
    INT 16h
    
    ;Change to Text MODE
    MOV AH,0          
    MOV AL,03h
    INT 10h 

    ; return control to operating system
    MOV AH , 4ch
    INT 21H
    
MAIN ENDP

Draw PROC

; Drawing loop
drawLoop:
    MOV AL,[BX]
    INT 10h 
    INC CX
    INC BX
    CMP CX,pieceWidth
JNE drawLoop 
	
    MOV CX , 0
    INC DX
    CMP DX , pieceHeight
JNE drawLoop

ret

Draw ENDP 



END MAIN
