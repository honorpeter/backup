到处csv命令：
    hive -e 'set hive.cli.print.header=true; select * from wtb_member_address_group' | sed 's/[\t]/,/g'  > /tmp/table_1.csv
    
