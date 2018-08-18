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

import argparse
import os
from shutil import copyfile


def copy_files(input_dataset, output_train, output_test, session_test):
    for root, dirs, files in os.walk(input_dataset):
        for name in files:
            if name.endswith((".jpg", ".png")):
                current_name = os.path.join(os.path.abspath(root), name)
                # Get the current label.
                label1 = name.split('/')
                label2 = label1[len(label1) - 1]
                label3 = label2.split('_')

                object_class = label3[1]  # object class
                parsed_session = label3[2]  # session
                if parsed_session == session_test:
                    if not os.path.exists(output_test + '/' + object_class):
                        os.makedirs(output_test + '/' + object_class)
                    copyfile(current_name, os.path.join(os.path.abspath(output_test), object_class, name))
                else:
                    if not os.path.exists(output_train + '/' + object_class):
                        os.makedirs(output_train + '/' + object_class)
                    copyfile(current_name, os.path.join(os.path.abspath(output_train), object_class, name))



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Split NICO Vision data into train and test sets.")
    parser.add_argument("--input_dataset", dest="input_dataset", type=str, required=True, help="The NICO Vision dataset")
    parser.add_argument("--output_train", dest="output_train", type=str, required=True, help="Output directory for train data")
    parser.add_argument("--output_test", dest="output_test", type=str, required=True, help="Output directory for test data")
    parser.add_argument("--session_test", dest="session_test", type=str, required=True, help="Test session: 1 or 2")

    args = parser.parse_args()
    copy_files(args.input_dataset, args.output_train, args.output_test, args.session_test)
