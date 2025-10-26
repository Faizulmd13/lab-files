#include <sys/queue.h>
#include <iostream>

#define DCCP_ACK 1
#define DATA_PACKET 0

struct r_hist_entry {
    int seq_num_;
    int t_recv_;
    int type_;
    STAILQ_ENTRY(r_hist_entry) linfo_;
};

class DCCPTFRCAgent {
public:
    STAILQ_HEAD(r_hist_head, r_hist_entry) r_hist_;
    int num_dup_acks_;

    DCCPTFRCAgent(int num_dup) : num_dup_acks_(num_dup) {
        STAILQ_INIT(&r_hist_);
    }

    void removeAcksRecvHistory() {
        struct r_hist_entry *elm1 = STAILQ_FIRST(&r_hist_);
        struct r_hist_entry *elm2;
        int num_later = 1;
        while (elm1 != NULL && num_later <= num_dup_acks_) {
            num_later++;
            elm1 = STAILQ_NEXT(elm1, linfo_);
        }
        if (elm1 == NULL) return;

        elm2 = STAILQ_NEXT(elm1, linfo_);
        while (elm2 != NULL) {
            if (elm2->type_ == DCCP_ACK) {
                STAILQ_REMOVE(&r_hist_, elm2, r_hist_entry, linfo_);
                delete elm2;
            } else {
                elm1 = elm2;
            }
            elm2 = STAILQ_NEXT(elm1, linfo_);
        }
    }

    void printHistory() {
        std::cout << "Queue: ";
        for (r_hist_entry* curr = STAILQ_FIRST(&r_hist_); curr != nullptr; curr = STAILQ_NEXT(curr, linfo_)) {
            std::cout << curr->seq_num_ << "(" << (curr->type_==DCCP_ACK?"ACK":"DATA") << ") ";
        }
        std::cout << "\n";
    }
};

int main() {
    DCCPTFRCAgent agent(2); // allow 2 duplicate ACKs

    // Add some entries
    for (int i = 0; i < 6; ++i) {
        r_hist_entry* pkt = new r_hist_entry;
        pkt->seq_num_ = i;
        pkt->t_recv_ = 0;
        pkt->type_ = (i % 2 == 0) ? DCCP_ACK : DATA_PACKET;
        STAILQ_INSERT_TAIL(&agent.r_hist_, pkt, linfo_);
    }

    std::cout << "Before removing ACKs:\n";
    agent.printHistory();

    agent.removeAcksRecvHistory();

    std::cout << "After removing ACKs:\n";
    agent.printHistory();

    // Cleanup
    r_hist_entry* curr;
    while ((curr = STAILQ_FIRST(&agent.r_hist_)) != nullptr) {
        STAILQ_REMOVE(&agent.r_hist_, curr, r_hist_entry, linfo_);
        delete curr;
    }

    return 0;
}

