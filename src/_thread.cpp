//
// Created by basara on 20.6.24..
//

#include "../h/_thread.hpp"
#include "../h/riscv.hpp"

_thread* _thread::running = nullptr;

void _thread::yield(){
    uint64 fcode = 0x13;
    asm volatile("mv a0, %0" : : "r" (fcode));  //a0 <- 13
    asm volatile("ecall");
}

int _thread::create_thread(thread_t* handle, Body body, void* arg, void* stack_space){

    *handle = new _thread(body, arg, stack_space);
    if(*handle != nullptr) return 0;//mozda treba !=nullptr
    return -1;
}


void _thread::thread_dispatch(){
    _thread *old = running;
    if(!old->isFinished()){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    running = Scheduler::get();

    //trenutni ra cuvam u old->context, a novi ra uzimam iz running->context i stavljam u ra registar
    _thread::contextSwitch(&old->context, &running->context);
}

int _thread::thread_exit() {
    _thread::running->setFinished(true);
    _thread::yield();
    return 0;
}

void _thread::threadWrapper() {
    Riscv::popSppSpie();
    running->body(running->arg);
    running->setFinished(true);//kada se sve zavrsi postavi da je kraj
    _thread::yield();
}

