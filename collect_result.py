import csv
import os
import re

FILE_PATH = "/home/ubuntu/test"


def analyze_line(line, lost_dict, recovery_dict):
    lost_match = re.search(r'ART detect packet (\d+) is lost, time is: (\d+)', line)
    if lost_match:
        # 匹配到 "detect packet" 并提取两个数字
        num1 = lost_match.group(1)
        num2 = lost_match.group(2)
        # print(f"Found 'detect packet' in line: {line.strip()}, Numbers: {num1}, {num2}")
        lost_dict[num1] = num2
        return None, None, None, None
    if "Reward was calculated in " in line:
        # print(line)
        numbers = re.findall(r'\b\d+\.\d+|\b\d+\b', line)
        lost_number = numbers[-1]
        packno = numbers[-2]
        temp_round = numbers[-6]
        receive_time = numbers[-8]
        recovery_time = int(receive_time) - int(lost_dict[lost_number])
        if lost_number not in recovery_dict.keys():
            recovery_dict[lost_number] = []
        recovery_dict[lost_number].append(recovery_time)
        return int(temp_round), recovery_time, None, None
    if " bytes/sec" in line:
        numbers = re.findall(r'\d+', line)
        temp_throughput = numbers[-1]
        return None, None, None, int(temp_throughput)
    if "All_retrans_packets:" in line:
        numbers = re.findall(r'\d+', line)
        temp_redundancy = numbers[-1]
        return None, None, int(temp_redundancy), None
    # default
    return None, None, None, None


def analyze_file(file_path, result_path):
    # record lost time
    lost_dict = {}
    # record recovery time
    recovery_dict = {}
    round_list = []
    redundancy = None
    throughput = None
    print(file_path)
    print(os.path.splitext(file_path)[0].split('/')[-1])
    result_csv_path = result_path + "/" + os.path.splitext(file_path)[0].split('/')[-1] + ".csv"
    print(result_csv_path)
    with open(file_path, 'r', encoding='utf-8') as file:
        line = file.readline()
        while line:
            # print(line)
            temp_round, recovery_time, temp_redundancy, temp_throughput = analyze_line(line, lost_dict, recovery_dict)
            if temp_round is not None:
                round_list.append(temp_round)
            if temp_redundancy is not None:
                redundancy = temp_redundancy
            if temp_throughput is not None:
                throughput = temp_throughput * 8
            line = file.readline()
        print(f"redundancy is: {redundancy}\nthroughput is: {throughput} bps\nmax_round is: {max(round_list)}\nmax_recovery_time is: ")
        print(round_list)

    with open(result_csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        # 写入列表数据
        writer.writerow(["redundancy", str(redundancy)])
        writer.writerow(["throughput(bps)", str(throughput)])
        writer.writerow(["round"])
        writer.writerow(round_list)
        writer.writerow(["recovery"])
        for k,v in recovery_dict.items():
            if len(v) > 1:
                print(f"ERROR, there are more than one recovery time of {k}, time list is: {v}")
            writer.writerow([str(k), v[0]])

def analyze_folder(folder_path):
    if not os.path.exists(folder_path) or not os.path.isdir(folder_path):
        print(f"Error: {folder_path} is not a valid folder path.")
        return

    result_path = os.path.join(folder_path, "result")
    # 判断文件夹是否存在
    if not os.path.exists(result_path):
        # 如果不存在，创建文件夹
        os.makedirs(result_path)

    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        if os.path.isfile(file_path):
            analyze_file(file_path, result_path)


analyze_folder(FILE_PATH)