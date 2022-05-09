#include <stdio.h>
#include <curand.h>
#include <curand_kernel.h>
#include <iostream>

#include "device_launch_parameters.h"
//#include "./runner.cuh"

#include<windows.h>

/*__global__ void init(unsigned int seed, curandState_t* states) {
	int i = blockDim.x * blockIdx.x + threadIdx.x;
	curand_init(seed, threadIdx.x, 0, &states[i]);
}

__global__ void randoms(curandState_t* states, int* speed) {
	int i = blockDim.x * blockIdx.x + threadIdx.x;
	speed[i] = curand(&states[i]) % 5;
	speed[i] = speed[i] + 1;
}

__global__ void race(int *speed, int *location, int *de) {
	int i = blockDim.x * blockIdx.x + threadIdx.x;
	if (location[i] < 100) {
		location[i] = speed[i] + location[i];
	}

	if (location[i] >= 100) {
		//location[i] = 0;
		speed[i] = 0;
		de[0] += 1;
		location[i] = de[0];
	}
}*/


/*void device_random() {
	r[0].p_rank();
}*/