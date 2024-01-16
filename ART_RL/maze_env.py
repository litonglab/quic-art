"""
Reinforcement learning maze example.

Red rectangle:          explorer.
Black rectangles:       hells       [reward = -1].
Yellow bin circle:      paradise    [reward = +1].
All other states:       ground      [reward = 0].

This script is the environment part of this example.
The RL is in RL_brain.py.

View more on my tutorial page: https://morvanzhou.github.io/tutorials/
"""
import numpy as np
import time
import sys
import mmap
import struct

from collections import namedtuple

np.set_printoptions(suppress=True)

action_file = '/home/ubuntu/quic-art/action.txt'
action_size = 1
state_file = '/home/ubuntu/quic-art/state.txt'
state_format = '<4Q3I'
state_size = struct.calcsize(state_format)
print(state_size)
state_names = namedtuple('State', 'send_rate ack_rate min_rtt srtt lost_packet_number inflight round')
records_file = '/home/ubuntu/quic-art/records.txt'
record_format = '<4Q3I4x2Id4Q3I4x'
record_size = struct.calcsize(record_format)
print(record_size)
records_size = 2048 * record_size
record_names = namedtuple('Record', 'send_rate ack_rate min_rtt srtt lost_packet_number inflight round dup_number ack_or_not reward next_send_rate next_ack_rate next_min_rtt next_srtt next_lost_packet_number next_inflight next_round')


class ART_RL():
    def __init__(self):
        self.action_space = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        self.n_actions = len(self.action_space)
        self.n_features = 7
        self.state_fd = open(state_file, "r+b")
        self.state_mm = mmap.mmap(self.state_fd.fileno(), state_size, access=mmap.ACCESS_READ, offset=0)
        self.records_file = open(records_file, "r+b")
        self.records_mm = mmap.mmap(self.records_file.fileno(), records_size, access=mmap.ACCESS_READ, offset=0)
        self.action_file = open(action_file, "r+b")
        self.action_mm = mmap.mmap(self.action_file.fileno(), action_size, access=mmap.ACCESS_WRITE, offset=0)



    def render(self):
        # time.sleep(0.01)
        return self.sample()

    def sample(self):
        self.state_mm.seek(0)
        temp_state = self.state_mm.read(state_size)
        # cur_state = state_names._make(struct.unpack(state_format, temp_state))
        cur_state = struct.unpack(state_format, temp_state)
        return np.array(cur_state)

    def collect_memory(self, index, count):
        records = []
        start_addr = index * record_size
        # print(f"start from {start_addr}")
        self.records_mm.seek(start_addr)
        temp_record = self.records_mm.read(count * record_size)
        for i in range(count):
            record = temp_record[i*record_size:(i+1)*record_size]
            # print(f"record is {record}")
            # records.append(record_names._make(struct.unpack(record_format, record)))
            records.append(struct.unpack(record_format, record))
        return np.array(records)
        # return records

    def write_action(self, action):
        self.action_mm.seek(0)
        print(f'{action} is been writen to action_file, its type is: {type(action)}')
        self.action_mm.write(action)

# test = ART_RL()
# print(test.render())
# print(test.collect_memory(0, 100))