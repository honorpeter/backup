遍历目录下所有文件：
    namespace fs = boost::filesystem;

int get_dir_files(const string & dir_name,vector<string> &file_names)
{
	fs::path path(dir_name)	;
	if(!fs::exists(path))
	{
		return -1;
	}

	fs::directory_iterator end_iter;
	for(fs::directory_iterator iter(path); iter != end_iter; ++iter){
		if (fs::is_regular_file(iter->status())){
			file_names.push_back(iter->path().string());
		}

		if(fs::is_directory(iter->status())){
			get_dir_files(iter->path().string(),file_names);
		}
	}

	return file_names.size();
}
