#include "../h/syscall_cpp.hpp"



int Thread::maxNumOfThreads=5; //NAPRAVLJENO ZA MAXTHREAD
bool Thread::maxThread = false;
Semaphore* Thread::sem = nullptr; //NAPRAVLJENO ZA MAXTHREAD

