#ifndef OS_PROJEKAT_SYSCALL_CPP_HPP
#define OS_PROJEKAT_SYSCALL_CPP_HPP

#include "syscall_c.hpp"
#include "../test/printing.hpp"

void* operator new(size_t);
void operator delete(void*);

class Semaphore{
public:
    Semaphore(unsigned init=1){
        sem_open(&myHandle, init);
    };
    virtual ~Semaphore(){
        sem_close(myHandle);
    };

    int wait(){
        return sem_wait(myHandle);
    }
    int signal(){
        return sem_signal(myHandle);
    }
    int tryWait(){
        return sem_trywait(myHandle);
    }

private:
    sem_t myHandle;
};

class Console {
public:
    static char getc (){
        return ::getc();
    }
    static void putc (char ch){
        ::putc(ch);
    }
};


class Thread {

public:

    static void SetMaximumThreads(int num_of_threads){ //NAPRAVLJENO ZA MAXTHREAD
        maxNumOfThreads = num_of_threads; //NAPRAVLJENO ZA MAXTHREAD
        sem = new Semaphore(maxNumOfThreads); //NAPRAVLJENO ZA MAXTHREAD
        maxThread= true;
    }
    int getThId(){ //NAPRAVLJENO ZA MAXTHREAD
        return id;//NAPRAVLJENO ZA MAXTHREAD
        // return getId(); //NAPRAVLJENO ZA MAXTHREAD ovo je sistemski poziv i vraca running mora u okviru funckije da se pozove
    }


    Thread(void (*body)(void*), void* arg):body(body), arg(arg){
    }
    virtual ~Thread(){}

    int start(){
        if(maxThread){
            sem->wait();//NAPRAVLJENO ZA MAXTHREAD
        }

        if (body == nullptr){
            thread_create(&myhandle, &threadWrapper,this);
        }
        else {
            thread_create(&myhandle, body,arg);
        }

        return 0;
    }

    static void dispatch() { thread_dispatch();}
    static int sleep(time_t);

    void join(){
        thread_join(&myhandle);
    }

protected:
    Thread(){}


    virtual void run(){}

private:
    static Semaphore* sem; //NAPRAVLJENO ZA MAXTHREAD

    static void threadWrapper(void* p) {
        Thread *thr = (Thread *) p;
        if (thr) {
            thr->id = getId();  //NAPRAVLJENO ZA MAXTHREAD
            thr->run();
            if(maxThread){
                sem->signal(); //NAPRAVLJENO ZA MAXTHREAD
            }

        }

    }

    thread_t myhandle;  //rucka do thread objekta
    void (*body)(void*) = nullptr;
    void* arg;

    int id;//NAPRAVLJENO ZA MAXTHREAD

    static bool maxThread;
    static int maxNumOfThreads;//NAPRAVLJENO ZA MAXTHREAD

};


#endif //OS_PROJEKAT_SYSCALL_CPP_HPP
