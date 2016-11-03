gzip:
    Example of how to read a compressed file:

            import gzip
            with gzip.open('file.txt.gz', 'rb') as f:
                file_content = f.read()
    Example of how to create a compressed GZIP file:

            import gzip
            content = "Lots of content here"
            with gzip.open('file.txt.gz', 'wb') as f:
                f.write(content)









