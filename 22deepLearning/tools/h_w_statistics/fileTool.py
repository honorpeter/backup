#coding: utf-8

import os

class fileTool:

    __allFile = []
    __root = str()

    def __init__(self,root):
        self.__root = root

    def recursiveWalk(self,folder):
        for folderName, subfolders, filenames in os.walk(folder):
            for filename in filenames:
                filePath = os.path.join(folderName, filename)
                self.__allFile.append(filePath)

    def getAllFile(self):
        self.recursiveWalk(self.__root)
        return self.__allFile

if __name__ == "__main__":
    files_path = fileTool(".")
    print files_path.getAllFile()




