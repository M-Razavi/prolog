ask(Question) :-  write('Question: '),
      write(Question),
      write('? '),
      write('(yes or no) : '),
      read(Response),
      nl,
      ((Response == yes ; Response == y) -> assert(yes(Question)) ; 
       (Response==no ; Response ==n) -> assert(no(Question)) ;
        write('\nInvalid Input!!!\n'),fail).