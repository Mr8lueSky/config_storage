#!/bin/python
import argparse
import json
import os
import shutil
import sys
from argparse import Namespace
from pathlib import Path
from subprocess import check_output

GIT_CURR_HASH_LIST = ["git", "rev-parse", "HEAD"]
GIT_PULL = "git pull"
GIT_PUSH = "git push"
GIT_COMMIT = "git commit -m"
GIT_ADD = "git add"
GIT_COMMIT_MSG = "Changes to {name} config"

CONFIGS_PATH = "configs.json"


def get_paths(config):
    return Path(os.path.expanduser(config["path"])), Path(
        os.path.expanduser(config["dest_path"])
    )


def get_config():
    if not os.path.exists(CONFIGS_PATH):
        print(f"Config file not found! {CONFIGS_PATH}")
        exit(1)
    with open(CONFIGS_PATH, "r") as file:
        return json.load(file)


def get_curr_git_hash():
    return str(check_output(GIT_CURR_HASH_LIST), encoding="utf-8")[:-1]


def git_pull():
    cmd = os.popen(GIT_PULL)
    status = cmd.close()
    if status != 36096:
        print("Failed to pull")
        exit(1)


def git_push():
    cmd = os.popen(GIT_PUSH)
    status = cmd.close()
    if status:
        print("Failed to push")
        exit(1)


def git_commit(config_name):
    msg = GIT_COMMIT_MSG.format(name=config_name)
    cmd = os.popen(f'{GIT_COMMIT} "{msg}"')
    status = cmd.close()
    if status not in (0, -3328):
        print("Failed to commit")
        exit(1)


def git_add(file_path: Path):
    cmd = os.popen(f"{GIT_ADD} {file_path.as_posix()}")
    status = cmd.close()
    if status:
        print("Failed to pull")
        exit(1)


def update():
    curr_hash = get_curr_git_hash()
    git_pull()
    new_hash = get_curr_git_hash()

    if curr_hash != new_hash:
        print(f"Updated to {new_hash}. Relaunching")
        cmd = os.popen(" ".join(sys.orig_argv))
        s = cmd.close()
        if s:
            exit(s)


def pull(args):
    update()
    config_name = args.config_name
    if config_name == "all":
        for config_name in get_config():
            pull_one(config_name)    
    else:
        pull_one(config_name)


def pull_one(config_name):
    config = get_config().get(config_name, None)
    if config is None:
        print(f"Config with name {config_name} not found!")
        exit(1)
    curr_path, dest_path = get_paths(config)
    if os.path.isdir(curr_path):
        shutil.copytree(curr_path, dest_path, dirs_exist_ok=True)
    else:
        with open(curr_path, "r") as curr_file:
            with open(dest_path, "w") as dest_file:
                dest_file.write(curr_file.read())
    print(f"Copied from {curr_path} to {dest_path}")



def push(args):
    update()
    config_name = args.config_name
    if config_name == "all":
        for config_name in get_config():
            push_one(config_name)
    else:
        push_one(args.config_name)
    
    git_push()

def push_one(config_name):
    config = get_config().get(config_name, None)
    if config is None:
        print(f"Config with name {config_name} not found!")
        exit(1)
    curr_path, dest_path = get_paths(config)
    if os.path.isdir(dest_path):
        shutil.copytree(dest_path, curr_path, dirs_exist_ok=True)
    else:
        with open(dest_path, "r") as dest_file:
            with open(curr_path, "w") as curr_file:
                curr_file.write(dest_file.read())
    git_add(curr_path)
    git_commit(config_name)





if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="Configs Manager", description="Help with managing configs!"
    )
    subparser = parser.add_subparsers(title="subcomands", description="", help="desc")

    pull_parser = subparser.add_parser("pull")
    pull_parser.add_argument("config_name")

    pull_parser.set_defaults(func=pull)

    push_parser = subparser.add_parser("push")
    push_parser.add_argument("config_name")

    push_parser.set_defaults(func=push)

    args = parser.parse_args()
    if not vars(args):
        parser.print_help()
    else:
        args.func(args)
