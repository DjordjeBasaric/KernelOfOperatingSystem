//
// Created by basara on 19.6.24..
//

#ifndef OS_PROJEKAT_SYSCALL_CPP_HPP
#define OS_PROJEKAT_SYSCALL_CPP_HPP

#include "syscall_c.hpp"


//void* ::operator new(size_t);
//void ::operator delete(void*);

class Thread {

public:
    Thread(void (*body)(void*), void* arg):body(body), arg(arg){}
    virtual ~Thread() { thread_exit();}

    int start(){
        if (body == nullptr){
            thread_create(&myhandle, &threadWrapper,this);
        }
        else {
            thread_create(&myhandle, body,arg);
        }
        return 0;
    }

    static void dispatch() {thread_dispatch();}
    static int sleep(time_t);

protected:
    Thread(){};
    virtual void run(){}

private:
    static void threadWrapper(void* p){
        Thread* thr = (Thread*)p;
        if (thr) thr->run();
    }

    thread_t myhandle;  //rucka do thread objekta
    void (*body)(void*) = nullptr;
    void* arg;

};


class Semaphore{
public:
    Semaphore(unsigned init=1);
    virtual ~Semaphore();

    int wait();
    int signal();
    int tryWait();

private:
    sem_t myHandle;
};


#endif //OS_PROJEKAT_SYSCALL_CPP_HPP
