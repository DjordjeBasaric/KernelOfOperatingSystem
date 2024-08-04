//
// Created by marko on 20.4.22..
//

#include "../h/scheduler.hpp"

List<_thread> Scheduler::readyCoroutineQueue;

_thread *Scheduler::get()
{
    return readyCoroutineQueue.removeFirst();
}

void Scheduler::put(_thread *_thread)
{
    readyCoroutineQueue.addLast(_thread);
}