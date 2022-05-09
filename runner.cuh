#include <iostream>
using namespace std;
#define NN 100
#define MAX 5
class runner {
public:
	int indis, speed, location, rank;
	void p_location() {
		cout << indis << ". kisinin konumu " << location << endl;
	}
	void p_rank() {
		cout << indis << ". kisinin siralamasi " << rank << endl;
	}
};
class runway {
public:
	int length = NN;
};
runway p;
runner r[NN];