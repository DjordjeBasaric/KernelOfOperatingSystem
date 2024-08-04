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
    Thread(void (*body)(void*), void* arg);
    virtual ~Thread(); //virtual ~Thread(){ thread_exit();}

    int start();

    static void dispatch();
    static int sleep(time_t);


    //virtual ~Thread(){ delete myhandle;}

    thread_t getHandle()const{ return myhandle; }



protected:
    Thread();
    virtual void run(){}

private:
    thread_t myhandle;  //rucka do thread objekta
    void (*body)(void*);
    void* arg;

};


class Semaphore{
public:
    Semaphore(unsigned init=1){
        sem_open(&myHandle,init);
    }

    virtual ~Semaphore(){ sem_close(myHandle);}

    int wait(){ return sem_wait(myHandle);}

    int signal(){ return sem_signal(myHandle);}


private:
    sem_t myHandle;
};


#endif //OS_PROJEKAT_SYSCALL_CPP_HPP
