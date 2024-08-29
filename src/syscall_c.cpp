#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/syscall_c.hpp"



void* mem_alloc(size_t size){
    uint64 const fcode = 0x01;
    void* retval;
    __asm__ volatile("mv a1, %0" : : "r"(size));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    return retval;
}

int mem_free(void *p){
    uint64 const fcode = 0x02;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(p));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval));
    return retval;

}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    uint64 const fcode = 0x11;
    int retval;
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0

    return retval;//PROVERITI DA LI JE UREDU

}

void thread_dispatch(){
    uint64 const fcode = 0x13;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
}

int thread_exit(){
    uint64 const fcode = 0x12;
    int retval;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval));
    return retval;
}


char getc(){
    uint64 const fcode = 0x41;
    char ch;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (ch));
    return ch;
}

void putc(char c){
    __putc(c);
}

int sem_open(sem_t* handle, unsigned init){
    uint64 const fcode = 0x21;
    int retval;
    __asm__ volatile("mv a2, %0" : : "r"(init));
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    return retval;
}

int sem_close(sem_t handle){
    uint64 const fcode = 0x22;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    return retval;
}

int sem_wait(sem_t handle){
    uint64 const fcode = 0x23;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    return retval;
}

int sem_signal(sem_t handle){
    uint64 const fcode = 0x24;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    return retval;
}

int sem_trywait(sem_t handle){
    uint64 const fcode = 0x26;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    return retval;
}


int getId(){

    uint64 const fcode = 0x50;
    int id;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (id));
    thread_dispatch();
    return id;
}

void thread_join(thread_t* handle){
    uint64 const fcode = 0x51;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
}
