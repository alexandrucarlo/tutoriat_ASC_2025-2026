int main() {
	int vec[10] = {5, 6, 76, 543, 43, 3, 8, 65, 67, 420};
	int vec_size = 10;
	int sum = 0;
	int ax;
	// (-2) ^ i
	for (int i = 0; i < vec_size; i++) {
		ax = vec[i];
		for (int j = 0; j < i; j++) ax *= -2; 

		// sau putem face cu operatii pe biti (mai eficient):
		//ax = ax << i; // shiftam la stanga cu i pozitii (echivalenta cu inmultirea cu 2^i)
		//
		//ax = ax * (1 - 2 * (i & 1)); // si apoi inmultim cu "-1^i"
		/* aici se intampla o smecherie mare:
		 * i & 1 este operatia logica AND dintre indice si numarul 1, si este echivalenta cu i % 2
		 * chestia asta functioneaza pentru ca paritatea unui numar binar este data de ultima lui cifra (LSB - least significant bit)
		 * 12 = 0b1100 - par
		 * 13 = 0b1101 - impar
		 * 13 & 1:
		 * 
		 * 1101 &
		 * 0001
		 * = (se face operatia AND bit cu bit)
		 * 0001
		 *
		 *
		 * expresia 1 - 2 * (i & 1) ne va da:
		 * 1 - 2 * 0 = 1, daca i este par
		 * 1 - 2 * 1 = -1, daca i este impar
		 *
		 * evident, -1 la orice putere impara va da tot -1, dar la o putere para va da 1
		 * astfel nu mai folosim o bucla pentru calcule, salvand o gramada de inmultiri pe care le-ar fi facut for-ul initial (complexitate O(i)) cu 2 operatii (complexitate O(1)) 
		 * */ 
		sum += ax;
	}
	return 0;
}
