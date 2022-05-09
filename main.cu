#include <stdio.h>
#include <curand.h>
#include <curand_kernel.h>
#include <iostream>

#include "device_launch_parameters.h"
#include "./runner.cuh"

#include<windows.h>

using namespace std;

__global__ void init(unsigned int seed, curandState_t* states) {
	int i = blockDim.x * blockIdx.x + threadIdx.x;
	curand_init(seed, threadIdx.x, 0, &states[i]);
}

__global__ void randoms(curandState_t* states, int* speed) {
	int i = blockDim.x * blockIdx.x + threadIdx.x;
	speed[i] = curand(&states[i]) % 5;
	speed[i] = speed[i] + 1;
}

__global__ void race(int *speed, int *location,int *de) {
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
}

int main() {
	curandState_t* states;
	cudaMalloc((void**)&states, NN * sizeof(curandState_t));
	init << <1, NN >> > (time(0), states);

	int speed[NN];
	int* de_speed;

	cudaMalloc((void**)&de_speed, NN * sizeof(int));
	randoms << <1,NN >> > (states, de_speed);
	cudaMemcpy(speed, de_speed, NN * sizeof(int), cudaMemcpyDeviceToHost);

	for (int i = 0; i < NN; i++) {
		r[i].speed = speed[i];
	}

	int location[NN];
	int *de_location;
	cudaMalloc((void**)&de_location, NN * sizeof(int));

	int *de;
	int d[1];

	cudaMalloc((void**)&de, 1 * sizeof(int));

	int sec = 0;
	for (sec; sec < NN; sec++) {
		race << <1, NN >> > (de_speed, de_location, de);
		cudaMemcpy(d, de, 1 * sizeof(int), cudaMemcpyDeviceToHost);
		if (d[0] > 0) {
			break;
		}
		Sleep(1000);
	}

	cudaMemcpy(location, de_location, NN * sizeof(int), cudaMemcpyDeviceToHost);

	for (int i = 0; i < NN; i++) {
		if (location[i] >= 0 && location[i] < 20){
			location[i] = p.length;
		}
		r[i].indis= i+1;
		r[i].location = location[i];
		r[i].p_location();
	}

	for (sec; sec < NN; sec++) {
		race << <1, NN >> > (de_speed, de_location, de);
		Sleep(1000);
	}

	cudaMemcpy(location, de_location, NN * sizeof(int), cudaMemcpyDeviceToHost);

	for (int i = 0; i < NN; i++) {
		r[i].rank = location[i];
		r[i].p_rank();
	}

	cudaFree(de_location);
	cudaFree(de_speed);
	cudaFree(de);
	cudaFree(states);

	return 0;
}