.data # in sectiunea .data ne declaram variabilele
vec: .long 5, 6, 76, 543, 43, 3, 8, 65, 67, 420
vec_size: .long 10
minus_doi: .long -2

.text # iar in sectiunea .text ne declaram codul/instructiunile
.global main

main:

lea vec, %esi # invatam adresa vectorului si o mutam in registrul esi 
movl $0, %ebx # vom folosi registrul ebx ca variabila in care stocam suma


movl $0, %ecx # iar registrul ecx ca fiind i-ul (din for-ul in C)
sum_loop: # iar acum ne construim bucla, ca sa ne adunam fiecare numar

# instructiunea cmp este neintuitiva si o ia dreapta-stanga in loc de stanga-dreapta
cmpl %ecx, vec_size 
jle sum_loop_end # daca i >= vec_size (care e complementara de la i < vec_size), iesim din bucla 


# aici folosim 4 pentru ca un .long (int) are 4 bytes (32 biti)
movl (%esi, %ecx, 4), %eax # incarcam valoarea de la vec[i] in eax


# METODA PENTRU INMULTIRE CU -2 CU BUCLA
# facem alta bucla pentru a inmulti cu -2:

movl $0, %edi # consideram registrul edi ca fiind j = 0 (ATENTIE: nu putem folosi edx pentru ca instructiunea de inmultire il va modifica!!!!!!!!!)
multiply_loop:
cmpl %edi, %ecx
jle multiply_loop_end # aceeasi logica ca mai sus, daca j >= i (ecx >= edx) iesim din bucla

movl $-2, %edx # stocam temporar numarul -2 in registrul edx pentru ca nu merge inmultirea pe numere constante :P
imull %edx # inmultim eax cu edx, iar rezultatul va fi un numar de 64 de biti (MONSTRUL) format prin alipirea in stanga lui edx la eax (asta inseamna ca -2-ul nostru va fi suprascris)
# imull minus_doi # merge si asta!! (foarte important sa prefixam cu i pentru a tine cont de semnul numarului)


incl %edi # j++
jmp multiply_loop
multiply_loop_end:


# METODA PENTRU INMULTIRE CU -2 FOLOSIND OPERATII BITWISE (explicata mai bine in fisierul C)

/*

# operatiile de shiftare pe biti merg numai cu numere constante sau registrul %cl (alti registri nu merg!!!!)
# pentru intelegerea mai usoara a alegerilor ciudate ale dezvoltatorilor x86, %cl suporta cel mult 255 de valori, si are sens sa shiftam cel mult cu 31 de biti
# cat despre de ce numai %cl, si nu alti registri (%bl, %al, ..) habar nu am!!!


shl %cl, %eax # ax = ax << i; shiftam la stanga numarul din vector (eax) cu i (ecx) biti


# acum ne formam numarul (1 - 2 * (i & 1)) in edi

movl $1, %edi # intai punem 1 in edi 

movl %ecx, %edx # formam 2 * (i & 1) in edx
andl $1, %edx # operatie AND intre 1 si edx, rezultat stocat in edx, echivalent cu edx mod 2 (par/impar)
shll $1, %edx # shiftare la stanga cu 1 bit, echivalenta cu inmultirea cu 2

subl %edx, %edi # echivalent cu edi = edi - edx

imull %edi # inmultim numarul format la eax, cu rezultatul in MONSTRU (dar e suficient sa adunam in continuare cu eax)
*/

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
