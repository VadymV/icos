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
import argparse
from shutil import copy2


test_sessions = [3, 7, 10]


def extract_instances(path_to_images, root_instances, test_data):
    # Extract instances to new folders.
    for root, dirs, files in os.walk(path_to_images):
        for name in files:
            if name.endswith((".jpg", ".png")):
                file_path = os.path.join(os.path.abspath(root), name)
                file_path_list = file_path.split('/')
                file_name = file_path_list[len(file_path_list)-1]

                file_name_list = file_name.split("_")

                session = int(file_name_list[1])
                if test_data and session not in test_sessions:
                    continue

                if not test_data and session in test_sessions:
                    continue

                instance = file_name_list[2]
                instance_directory = os.path.join(root_instances, instance)

                if not os.path.exists(instance_directory):
                    os.makedirs(instance_directory)

                copy2(file_path, instance_directory)


if __name__ == "__main__":
 parser = argparse.ArgumentParser(description="Prepare the ICWT dataset")
    parser.add_argument("--input_dataset", dest="input_dataset", type=str, required=True, help="The original ICWT dataset")
    parser.add_argument("--output_train_directory", dest="output_train_directory", type=str, required=True, help="Output directory for train data")
    parser.add_argument("--output_test_directory", dest="output_test_directory", type=str, required=True, help="Output directory for test data")

    args = parser.parse_args()
    extract_instances(args.input_dataset, args.output_train_directory, False)
    extract_instances(args.input_dataset, args.output_test_directory, True)


