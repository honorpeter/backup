时间：      时间类 日期类 时间戳 时间格式化 
    包名：
        java.util.Date;             时间类 
        import java.util.Calendar;  日期类


        new Date():
            返回当前日期

        日期：
            Calendar c = Calendar.getInstance(); 
            c.add(Calendar.MONTH, 1); // 目前時間加1個月    
            System.out.println(df.format(c.getTime()));    
            c.add(Calendar.HOUR, 3); // 目前時間加3小時    
            System.out.println(df.format(c.getTime()));    
            c.add(Calendar.YEAR, -2); // 目前時間減2年    
            System.out.println(df.format(c.getTime())); 
            c.add(Calendar.DAY_OF_WEEK, 7); // 目前的時間加7天    
            System.out.println(df.format(c.getTime())); 

            c.getTime()和new Date()效果一样 
        时间格式化：java.text.SimpleDateFormat
