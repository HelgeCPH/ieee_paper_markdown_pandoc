#!/usr/bin/env python
import sys


def get_replace_contents(path_str):
    # For some reason every now and then there might appear a unicode BOM 
    # character in the path ...
    if '\ufeff' in path_str:
        # path_str = path_str.encode('utf-8-sig').decode('utf-8-sig')
        path_str = path_str.replace(u'\ufeff', '')
    with open(path_str) as fp:
        contents = fp.read()
    return contents


def main(file_with_includes):
    to_replace = []
    with open(file_with_includes) as fp:
        for line in fp:
            plain_line = line.rstrip()
            if plain_line.startswith('[') and plain_line.endswith(']'):
                path_str = plain_line[1:-1]

                to_replace.append((line, path_str))
    
    for _, path_str in to_replace:
        print(path_str)
    
    replace_contents = [get_replace_contents(path_str) for _, path_str in to_replace]

    with open(file_with_includes) as fp:
        contents = fp.read()

    lines_to_replace = list(zip(*to_replace))[0]
    for line, replace_content in zip(lines_to_replace, replace_contents):
        contents = contents.replace(line, replace_content)

    with open('contents/_complete_paper.md', 'w', encoding='utf-8') as fp:
        fp.write(contents)
    # print(contents)


if __name__ == "__main__":
    main(sys.argv[1])
