//
// Created by basara on 20.6.24..
//


#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/syscall_c.hpp"

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

    //dodati promenljivu za povratnu vrednost
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
    uint64 const fcode = 0x20;
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

}