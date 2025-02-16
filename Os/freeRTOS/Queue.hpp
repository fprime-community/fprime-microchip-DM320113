#ifndef _Queue_hpp_
#define _Queue_hpp_

#include <Fw/Types/BasicTypes.hpp>
#include <Fw/Obj/ObjBase.hpp>
#include <Fw/Types/Serializable.hpp>
#include <Os/QueueString.hpp>
#include <FreeRTOS.h>
#include <queue.h>

namespace Os {
    // forward declaration for registry
    class QueueRegistry;

    class Queue {
        public:

            typedef enum {
                QUEUE_OK, //!<  message sent/received okay
                QUEUE_NO_MORE_MSGS, //!<  If non-blocking, all the messages have been drained.
                QUEUE_UNINITIALIZED, //!<  Queue wasn't initialized successfully
                QUEUE_SIZE_MISMATCH, //!<  attempted to send or receive with buffer too large, too small
                QUEUE_SEND_ERROR, //!<  message send error
                QUEUE_RECEIVE_ERROR, //!<  message receive error
                QUEUE_INVALID_PRIORITY, //!<  invalid priority requested
                QUEUE_EMPTY_BUFFER, //!<  supplied buffer is empty
                QUEUE_FULL, //!< queue was full when attempting to send a message
                QUEUE_UNKNOWN_ERROR //!<  Unexpected error; can't match with returns
            } QueueStatus;

            typedef enum {
                QUEUE_BLOCKING, //!<  Queue receive blocks until a message arrives
                QUEUE_NONBLOCKING //!<  Queue receive always returns even if there is no message
            } QueueBlocking;

            Queue();
            virtual ~Queue();
            QueueStatus create(const Fw::StringBase &name, NATIVE_INT_TYPE depth, NATIVE_INT_TYPE msgSize); //!<  create a message queue

            // Send serialized buffers
            QueueStatus send(const Fw::SerializeBufferBase &buffer, NATIVE_INT_TYPE priority, QueueBlocking block); //!<  send a message
            QueueStatus receive(Fw::SerializeBufferBase &buffer, NATIVE_INT_TYPE &priority, QueueBlocking block); //!<  receive a message

            // Send raw buffers
            QueueStatus send(const U8* buffer, NATIVE_INT_TYPE size, NATIVE_INT_TYPE priority, QueueBlocking block); //!<  send a message
            QueueStatus receive(U8* buffer, NATIVE_INT_TYPE capacity, NATIVE_INT_TYPE &actualSize, NATIVE_INT_TYPE &priority, QueueBlocking block); //!<  receive a message

            NATIVE_INT_TYPE getNumMsgs(void) const; //!< get the number of messages in the queue
            NATIVE_INT_TYPE getMaxMsgs(void) const; //!< get the maximum number of messages (high watermark)
            NATIVE_INT_TYPE getQueueSize(void) const; //!< get the queue depth (maximum number of messages queue can hold)
            NATIVE_INT_TYPE getMsgSize(void) const; //!< get the message size (maximum message size queue can hold)
            const QueueString& getName(void); //!< get the queue name
            static NATIVE_INT_TYPE getNumQueues(void); //!< get the number of queues in the system
#if FW_QUEUE_REGISTRATION
            static void setQueueRegistry(QueueRegistry* reg); // !< set the queue registry
#endif

        protected:
            //! Internal method used for creating allowing alternate implementations to implement different creation
            //! behavior without needing to duplicate the majority of the creation functionality.
            //! \param name: name of queue
            //! \param depth: depth of queue
            //! \param msgSize: size of a message stored on queue
            //! \return queue creation status
            QueueStatus createInternal(const Fw::StringBase &name, NATIVE_INT_TYPE depth, NATIVE_INT_TYPE msgSize); //!<  create a message queue
            QueueHandle_t m_handle; //!<  handle for implementation specific queue
            QueueString m_name; //!< queue name
            NATIVE_INT_TYPE m_msgSize; //!< message size

#if FW_QUEUE_REGISTRATION
            static QueueRegistry* s_queueRegistry; //!< pointer to registry
#endif
            static NATIVE_INT_TYPE s_numQueues; //!< tracks number of queues in the system

        private:
            Queue(Queue&); //!<  Disabled copy constructor
            Queue(Queue*); //!<  Disabled copy constructor
    };

    class QueueRegistry {
        public:
            virtual void regQueue(Queue* obj)=0; //!< method called by queue init() methods to register a new queue
            virtual ~QueueRegistry(); //!< virtual destructor for registry object
    };
}

#endif
