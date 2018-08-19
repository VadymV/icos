# Copyright (C) 2018  Vadym Gryshchuk (vadym.gryshchuk@protonmail.com)
# Date created: 29 July 2018
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

import os
import re

from shutil import copyfile
from shutil import copy2

import argparse

sessions = ('MIX', 'ROT2D', 'ROT3D', 'SCALE', 'TRANSL')
days = ('day1', 'day2', 'day3', 'day4', 'day5', 'day6', 'day7', 'day8', 'day9', 'day10', 'day11', 'day12', 'day13',
        'day14', 'day15')
cameras = ('left', 'right')
categories = ('book', 'cellphone', 'mouse', 'pencilcase', 'ringbinder',
              'hairbrush', 'hairclip', 'perfume', 'sunglasses', 'wallet',
              'flower', 'glass', 'mug', 'remote', 'soapdispenser',
              'bodylotion', 'ovenglove', 'sodabottle', 'sprayer', 'squeezer')


def find_value(old_name, list_values):
    for session_id in list_values:
        if session_id in old_name:
            session = session_id
            break
        else:
            session = ''
    if session == '':
        raise ValueError("Session cannot be empty!")
    return session


def rename_files(input_data):
    # Rename original ICWT data to produce unique labels.
    for root, dirs, files in os.walk(input_data):
        for name in files:
            if name.endswith((".jpg", ".png")):
                old_name = os.path.join(os.path.abspath(root), name)
                session = find_value(old_name, sessions)
                day = find_value(old_name, days)
                camera = find_value(old_name, cameras)
                before_session = old_name.split(session)[0].split('/')
                raw_new_label = before_session[len(before_session) - 2]
                id = old_name[-12:]
                number = re.findall('\d+', raw_new_label)[0]
                new_label = "_" + raw_new_label[0:-len(number)] + \
                            "_" + number + "_" + session + "_" + day + "_" + camera + "_" + id
                os.rename(old_name, os.path.join(root, new_label))


def extract_instances(path_to_images, root_instances, test_data):
    # Extract instances to new folders.
    for root, dirs, files in os.walk(path_to_images):
        for name in files:
            if name.endswith((".jpg", ".png")):
                file_path = os.path.join(os.path.abspath(root), name)
                file_path_list = file_path.split('/')
                file_name = file_path_list[len(file_path_list)-1]

                file_name_list = file_name.split("_")

                session = file_name_list[3]
                if test_data and session != 'MIX':
                    continue

                if not test_data and session == 'MIX':
                    continue

                instance = file_name_list[1] + file_name_list[2]
                instance_directory = os.path.join(root_instances, instance)

                if not os.path.exists(instance_directory):
                    os.makedirs(instance_directory)

                copy2(file_path, instance_directory)



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Prepare the ICWT dataset")
    parser.add_argument("--input_dataset", dest="input_dataset", type=str, required=True, help="The original ICWT dataset")
    # parser.add_argument("--output_train_directory", dest="output_train_directory", type=str, required=True, help="Output directory for train data")
    # parser.add_argument("--output_test_directory", dest="output_test_directory", type=str, required=True, help="Output directory for test data")

    args = parser.parse_args()
    rename_files(args.input_dataset)
    # extract_instances(args.input_dataset, args.output_train_directory, False)
    # extract_instances(args.input_dataset, args.output_test_directory, True)
