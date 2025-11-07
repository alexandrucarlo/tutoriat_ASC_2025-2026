.data # in sectiunea .data ne declaram variabilele
vec: .long 5, 6, 76, 543, 43, 3, 8, 65, 67, 420
vec_size: .long 10

.text # iar in sectiune .text ne declaram codul/instructiunile
.global main

main:

lea vec, %esi # invatam adresa vectorului si o mutam in registrul esi 
movl $0, %ebx # vom folosi registrul ebx ca variabila in care stocam suma


movl $0, %ecx # iar registrul ecx ca fiind i-ul (din for-ul in C)
sum_loop: # iar acum ne construim bucla, ca sa ne adunam fiecare numar

# instructiunea cmp este neintuitiva si o ia dreapta-stanga in loc de stanga-dreapta
cmpl %ecx, vec_size 
jle sum_loop_end # ...daca i >= vec_size (care e complementara de la i < vec_size), iesim din bucla 


# aici folosim 4 pentru ca un .long (int) are 4 bytes (32 biti)
movl (%esi, %ecx, 4), %eax # incarcam valoarea de la vec[i] in eax
# movl vec(, %ecx, 4), %eax # merge si asa!! (si nici nu mai trebuie sa folositi instructiunea lea)

addl %eax, %ebx # si apoi adunam eax la registrul ebx (pe care l-am stabilit ca variabila suma)

incl %ecx # i++ (sau addl $1, %ecx)
jmp sum_loop # ne intoarcem la capul buclei

sum_loop_end:
# aici continuam cu alte chestii din program (facem chestii cu suma obtinuta, sau poate vrem sa calculam alte chestii)
# dar noi o sa inchidem programul :P

exit: # return 0
movl $1, %eax # syscall-ul 1 (exit), asta face si limbajul C in interiorul sau
movl $0, %ebx # codul pe care il va returna programul, adica 0
int $0x80 # apeleaza syscall-ul! (si inchidem programul corect)
