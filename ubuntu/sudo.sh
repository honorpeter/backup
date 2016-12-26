Python：sudo 权限执行的时候 保留环境变量 
        The sudo environment did not contain my PYTHONPATH, 
        becuase my /etc/sudoers contains Defaults env_reset. 
        I simply added Defaults env_keep += "PYTHONPATH" to 
        /etc/sudoers and now it works.









