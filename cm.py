#!/bin/python
import argparse
import json
import os
import shutil
import sys
from pathlib import Path
from subprocess import CalledProcessError, check_output

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

def git_checkout_head():
    cmd = os.popen()

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
    name = args.config_name
    config = get_config().get(name, None)
    if config is None:
        print(f"Config with name {name} not found!")
        exit(1)
    curr_path, dest_path = get_paths(config)
    shutil.copytree(curr_path, dest_path, dirs_exist_ok=True)
    print(f"Copied from {curr_path} to {dest_path}")


def push(args):
    update()
    name = args.config_name
    config = get_config().get(name, None)
    if config is None:
        print(f"Config with name {name} not found!")
        exit(1)
    curr_path, dest_path = get_paths(config)
    shutil.copytree(dest_path, curr_path, dirs_exist_ok=True)
    git_add(curr_path)
    git_commit(name)
    git_push()


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
    print(args)
    if not vars(args):
        parser.print_help()
    else:
        args.func(args)
